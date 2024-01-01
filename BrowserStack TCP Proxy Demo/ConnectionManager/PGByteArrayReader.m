/**
 ** \file PGByteArrayReader.m
 **
 **  PGByteArrayReader deserializes the byte stream received from server in to message object.
 **  This class implements protobuf algorithms and also provides support for decompressing the byte stream before actual deserialization
 **	 This class provides basic methods to read data from the byte stream. Individual message classes would use this class to populate themselves.
 **
 **  Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 ** Author: Suyash Motarwar
 *******************************************************************************/

#import "PGByteArrayReader.h"
#import	"Constants.h"
#import <zlib.h>
//#import "PGMessageFactory.h"

@implementation PGByteArrayReader

@synthesize delegate;

- (id) init{
	  

	self = [super init];
	if (self != nil) {
		self = [self initWithByteArray:nil length:0];
		delegate = nil;
	}
	return self;
}

- (id) initWithByteArray:(uint8_t*) bytes
				  length:(int)length{
	  

	self = [super init];
	if (self != nil && length > 0) {
		uint8_t* p = malloc(length);
		memcpy(p, bytes, length);
		mBasePointer = p;
		mCurrentPointer = p;
		mEndPointer = p + length;
		mLength = length;
	}
	return self;
}

- (void) dealloc{
	free(mBasePointer);
    [(NSObject *)delegate release];
	[super dealloc];
}

-(int) putByteArray:(const void*) pch
	  length:(int) nCount{
	int nOffset = (mCurrentPointer-mBasePointer);
	if(nOffset > 0)
	{
		if(mEndPointer > mCurrentPointer)
			memcpy(mBasePointer, mCurrentPointer, mLength-nOffset);
		mCurrentPointer = mBasePointer;
		mEndPointer -= nOffset;
	}
	if(((mEndPointer+nCount) > (mBasePointer+mLength)))
	{
		uint8_t *_bp = mBasePointer, *_pp = mEndPointer;
		int nLen = (mEndPointer-mBasePointer)+((nCount+1023)/1024)*1024;
		mBasePointer = mCurrentPointer = malloc(nLen);
		memset(mBasePointer,'\0',sizeof(mBasePointer));
		memset(mCurrentPointer,'\0',sizeof(mCurrentPointer));
		if(_bp != NULL)
		{
			memcpy(mBasePointer, _bp, mLength);
			free(_bp);
		}
		mEndPointer = mBasePointer + (_pp-_bp);
		mLength = nLen;
	}
	memcpy(mEndPointer, pch, nCount);
	mEndPointer += nCount;
	return nCount;
}

-(int) appendByteArray:(const void*) pch
	   length:(int) nCount{
	
	if(((mEndPointer+nCount) > (mBasePointer+mLength)))
	{
		int nOffset = (mCurrentPointer-mBasePointer);
		int nTotalBytes = mEndPointer-mBasePointer;
		uint8_t *_bp = mBasePointer;
		int nLen = (mEndPointer-mBasePointer)+((nCount+1023)/1024)*1024;
		mBasePointer = mCurrentPointer = malloc(nLen);
		memset(mBasePointer,'\0',sizeof(mBasePointer));
		memset(mCurrentPointer,'\0',sizeof(mCurrentPointer));
		if(_bp != NULL)
		{
			memcpy(mBasePointer, _bp, nTotalBytes);
			free(_bp);
		}
		mCurrentPointer = mBasePointer + nOffset;
		mEndPointer = mBasePointer + nTotalBytes;
		mLength = nLen;
	}
	memcpy(mEndPointer, pch, nCount);
	mEndPointer += nCount;
	return nCount;
}

-(NSData*) getByteArray{
	
	NSData* data = nil;
	int sizeOfByteArray = [self getInt];

//    int availableBytes = [self availableBytesToRead];
    
	if (sizeOfByteArray > 0 && (sizeOfByteArray <= [self availableBytesToRead]) )
	{		
		uint8_t* bytes = nil;
		bytes = malloc(sizeOfByteArray);
		
		memcpy(bytes, mCurrentPointer, sizeOfByteArray);
		
		mCurrentPointer = mCurrentPointer + sizeOfByteArray;
		
		data = [[NSData alloc] initWithBytes:bytes length:sizeOfByteArray ];
//		[data autorelease];
		free(bytes);
	}
			
	return data;
}

-(int) availableBytesToRead{
	return (mEndPointer-mCurrentPointer);
}


-(uint8_t) getByte{
	
	uint8_t bByte = (uint8_t)(*mCurrentPointer);
	mCurrentPointer += sizeof(uint8_t);
	return bByte;
}

-(short) getFixedLenShort{
	
	return [self readFixedLenShort];
}

-(short) readFixedLenShort{
	
	short v = *(short*)mCurrentPointer;
	v = ntohs(v);
	mCurrentPointer += sizeof(short);
	return v;
}

-(short) getShort
{
#if TARGET_MAC
	uint32 nVal = [self readVariant32];
#else
    uint32_t nVal = [self readVariant32];
#endif
	short v = (short)(nVal);
	return v;
}


-(int) getTwoByteInt
{
	int nVal=0;
	
	uint8_t vByte2 = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	uint8_t vByte1 = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	nVal = vByte2;
	nVal = nVal << 8; 
	
	nVal = nVal+vByte1;
	
	return nVal;
}

-(int) getThreeByteInt
{
	int nVal=0;
	
	uint8_t vByte3 = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	uint8_t vByte2 = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	uint8_t vByte1 = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	nVal = vByte3;
	nVal = nVal << 8; 
	
	nVal = nVal + vByte2;
	nVal = nVal << 8; 
	
	nVal = nVal+vByte1;
	
	return nVal;
}

-(int) getFourByteInt
{
	int nVal=0;
	
	uint8_t vByte4 = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	uint8_t vByte3 = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	uint8_t vByte2 = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	uint8_t vByte1 = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	nVal = vByte4;
	nVal = nVal << 8;
	
	nVal = nVal + vByte3;
	nVal = nVal << 8; 
	
	nVal = nVal + vByte2;
	nVal = nVal << 8; 
	
	nVal = nVal+vByte1;
	
	return nVal;
	
}


-(int) readFixedLenInt
{
	int v = *(int*)mCurrentPointer;
	v = ntohl(v);
	mCurrentPointer += sizeof(int);
	return v;
}

#if TARGET_MAC
-(int) getInt
{
	uint32 nVal = [self readVariant32];
	int v = nVal;
	return v;
}
#endif

#if TARGET_IOS
-(int) getInt
{
    uint32_t nVal = [self readVariant32];
    int v = nVal;
    return v;
}
#endif



-(int) getFixedLenInt
{
	return [self readFixedLenInt];
}

-(long long) getInt64
{
	long long lVal = [self readVarint64];
	long long v = lVal;
	return v;
}

-(int64_t) readFixedLenInt64
{
	long long v = *(long long*)mCurrentPointer;
	v= ( htonl ( (v >> 32) & 0xFFFFFFFF) | ((long long) (htonl (v & 0xFFFFFFFF))  << 32));
	mCurrentPointer += sizeof(v);
	return v;
}

-(long long) getFixedLenInt64
{
	return [self readFixedLenInt64];
}

-(BOOL) getBOOL
{
	uint8_t v = (uint8_t)(*mCurrentPointer);
	mCurrentPointer += sizeof(v);
	bool bVal = v == 1 ? true : false;
	return bVal;
}

-(void) resetReadingPointer
{
	mCurrentPointer = mBasePointer;
}

/*-(void) skipBytes:(int) nCount
{
	mCurrentPointer += nCount;
}

-(void) erase
{
	if(mBasePointer)
		free(mBasePointer);
	mBasePointer = mEndPointer = mCurrentPointer = NULL;
	mLength = 0;
}*/

#if TARGET_MAC
////code taken from google protobuf - dont change
-(int) readVariant32;
{
    uint32 b;
    uint32 result;
	int count = 0;
	uint32_t nValue = 0;
	int i = 0;
	
    uint8* ptr = (uint8*)mCurrentPointer;
	
    b = *(ptr++); 
	count++;
	result  = (b & 0x7F); 
	if (!(b & 0x80)) 
		goto done;
	
    b = *(ptr++); 
	count++;
	result |= (b & 0x7F) <<  7; 
	if (!(b & 0x80)) 
		goto done;
    
	b = *(ptr++); 
	count++;
	result |= (b & 0x7F) << 14; 
	if (!(b & 0x80)) 
		goto done;
	
    b = *(ptr++); 
	count++;
	result |= (b & 0x7F) << 21; 
	if (!(b & 0x80)) 
		goto done;
    
	b = *(ptr++); 
	count++;
	result |=  b << 28; 
	if (!(b & 0x80)) 
		goto done;
    
	//to handle the negative numbers
    for ( i = 0; i < 5; i++) 
	{
		b = *(ptr++); 
		count++;
		if (!(b & 0x80)) 
			goto done;
    }
	
	return nValue;
	
done:
	nValue = result;
	//nValue = ntohl(result); might need to use this.
	mCurrentPointer += count;
    return nValue;	
}
#endif


#if TARGET_IOS
////code taken from google protobuf - dont change
-(int) readVariant32;
{
    uint32_t b;
    uint32_t result;
    int count = 0;
    uint32_t nValue = 0;
    int i = 0;
    
    uint8_t* ptr = (uint8_t*)mCurrentPointer;
    
    b = *(ptr++);
    count++;
    result  = (b & 0x7F);
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++);
    count++;
    result |= (b & 0x7F) <<  7;
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++);
    count++;
    result |= (b & 0x7F) << 14;
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++);
    count++;
    result |= (b & 0x7F) << 21;
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++);
    count++;
    result |=  b << 28;
    if (!(b & 0x80))
        goto done;
    
    //to handle the negative numbers
    for ( i = 0; i < 5; i++)
    {
        b = *(ptr++);
        count++;
        if (!(b & 0x80))
            goto done;
    }
    
    return nValue;
    
done:
    nValue = result;
    //nValue = ntohl(result); might need to use this.
    mCurrentPointer += count;
    return nValue;	
}
#endif

#if TARGET_MAC
////code taken from google protobuf - dont change
-(long long) readVarint64;
{
	long long lValue = 0;
	uint8* ptr = (uint8*)mCurrentPointer;
	uint32 b;
	
	int count = 0;
	uint64 result = 0;
	// Splitting into 32-bit pieces gives better performance on 32-bit processors.
	
	uint32 part0 = 0, part1 = 0, part2 = 0;
	
	b = *(ptr++); count++; 
	part0  = (b & 0x7F); 
	if (!(b & 0x80)) 
		goto done;
	
	b = *(ptr++); count++; 
	part0 |= (b & 0x7F) <<  7; 
	if (!(b & 0x80)) 
		goto done;
	
	b = *(ptr++); count++; 
	part0 |= (b & 0x7F) << 14; 
	if (!(b & 0x80)) 
		goto done;
	
	b = *(ptr++); count++; 
	part0 |= (b & 0x7F) << 21; 
	if (!(b & 0x80)) 
		goto done;
	
	b = *(ptr++); count++; 
	part1  = (b & 0x7F); 
	if (!(b & 0x80)) 
		goto done;
	
	b = *(ptr++); count++; 
	part1 |= (b & 0x7F) <<  7; 
	if (!(b & 0x80)) 
		goto done;
	
	b = *(ptr++); count++; 
	part1 |= (b & 0x7F) << 14; 
	if (!(b & 0x80)) 
		goto done;
	
	b = *(ptr++); count++; 
	part1 |= (b & 0x7F) << 21; 
	if (!(b & 0x80)) 
		goto done;
	
	b = *(ptr++); count++; 
	part2  = (b & 0x7F); 
	if (!(b & 0x80))
		goto done;
	
	b = *(ptr++); count++; 
	part2 |= (b & 0x7F) <<  7; 
	if (!(b & 0x80)) 
		goto done;
	
	// We have overrun the maximum size of a variant (10 bytes).  The data must be corrupt.
	return lValue;
	
done:
	mCurrentPointer += count;
	result = ((long long)(part0)) | ((long long)(part1) << 28) |((long long)(part2) << 56);
	//might need to do ntohll here
	lValue = result;
	return lValue;
}
#endif

#if TARGET_IOS
////code taken from google protobuf - dont change
-(long long) readVarint64;
{
    long long lValue = 0;
    uint8_t* ptr = (uint8_t*)mCurrentPointer;
    uint32_t b;
    
    int count = 0;
    uint64_t result = 0;
    // Splitting into 32-bit pieces gives better performance on 32-bit processors.
    
    uint32_t part0 = 0, part1 = 0, part2 = 0;
    
    b = *(ptr++); count++;
    part0  = (b & 0x7F);
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++); count++;
    part0 |= (b & 0x7F) <<  7;
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++); count++;
    part0 |= (b & 0x7F) << 14;
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++); count++;
    part0 |= (b & 0x7F) << 21;
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++); count++;
    part1  = (b & 0x7F);
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++); count++;
    part1 |= (b & 0x7F) <<  7;
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++); count++;
    part1 |= (b & 0x7F) << 14;
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++); count++;
    part1 |= (b & 0x7F) << 21;
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++); count++;
    part2  = (b & 0x7F);
    if (!(b & 0x80))
        goto done;
    
    b = *(ptr++); count++;
    part2 |= (b & 0x7F) <<  7;
    if (!(b & 0x80))
        goto done;
    
    // We have overrun the maximum size of a variant (10 bytes).  The data must be corrupt.
    return lValue;
    
done:
    mCurrentPointer += count;
    result = ((long long)(part0)) | ((long long)(part1) << 28) |((long long)(part2) << 56);
    //might need to do ntohll here
    lValue = result;
    return lValue;
}
#endif



-(NSString*) getString
{	
	NSString* str = nil;
	int len = [self getInt];
	if(len <= 0)
	{
		str = [NSString string];
	}
	else
	{		
		len = (len > [self availableBytesToRead]) ? [self availableBytesToRead] : len;	
		str = [[NSString alloc] initWithBytes:mCurrentPointer 
									   length:len
									 encoding:NSUTF8StringEncoding];
		
		mCurrentPointer += len;
//		[str autorelease];
	}
	
	return str;
}

-(PGStringEx*) getStringEx
{
	PGStringEx* string = [[PGStringEx alloc] init];
	
	uint8_t nIsStringPresent = 0;
	nIsStringPresent = [self getByte];
	
	if( nIsStringPresent > 0)
	{
		[string setLiteralId:[self getInt]];
		[string setParameterValues:[self getParamStringArray] ];
		[string setIsLanguagePackElement:[self getBOOL] ];
	}
	
//	[string autorelease];
	return string;
}

-(int) uncompress:(int) nLen;
{
	uint8_t* p = malloc(nLen);
	unsigned long len = nLen;
	uncompress(p, &len, mCurrentPointer, [self availableBytesToRead]);
	uint8_t* temp = mBasePointer;
	mCurrentPointer = mBasePointer = p;
	mEndPointer = mCurrentPointer+len;
	free(temp);
	//m_bLocked = false;
	return len;
	
} 

-(PGSerializable*) getObject
{
	int classID = [self getInt];
    if(ENABLE_SRLZR_BW_COMPATIBILTY) {
        return [self getObjectForClassID:classID topLevel:FALSE];
    } else {
        return [self getObjectForClassID:classID];
    }
}

-(PGSerializable*) getObjectForClassID:(int) classID;
{
    if(ENABLE_SRLZR_BW_COMPATIBILTY) {
        return [self getObjectForClassID:classID topLevel:TRUE];
    } else {
    
        PGSerializable* obj = NULL;
        
        if(delegate)
            obj = [delegate createMessageObject:self
                                        classID:classID];
        else
//            obj = [[PGMessageFactory sharedInstance] messageObjectForClassID:classID];
        
        if(obj == NULL)
        {
            // what to do
            return NULL;
        }
        
        [obj read:self];
        
        return obj;
    }
}

-(PGSerializable*) getObjectForClassID:(int) classID topLevel:(BOOL) topLevel
{
	PGSerializable* obj = NULL;
	int length = 0;
    int startPosition = 0;
	if(delegate)
		obj = [delegate createMessageObject:self
                                    classID:classID];
    else
//        obj = [[PGMessageFactory sharedInstance] messageObjectForClassID:classID];
	
	if(obj == NULL)
	{
		// what to do
		return NULL;
	}
    
    if(ENABLE_SRLZR_BW_COMPATIBILTY) {
        if(!topLevel) {
            length = [self getInt];
            startPosition = [self getCurrentPointer];
        }
    }
	[obj read:self];
    
    if(ENABLE_SRLZR_BW_COMPATIBILTY) {
        if(!topLevel) {
            [self setCurrentPointer:startPosition+length];
        }
    }
	return obj;
}


/*-(void) getObjectEx:(PGSerializable*) obj
{
	if(obj == NULL)
	{
		// what to do
		return;
	}
	[self readObject:obj];
}

-(void) readObject: (PGSerializable*) obj;
{
	//TODO:Suyash
	//int clsid = [self ReadInt];
	//if(obj->m_classid != clsid) 
	//	return NULL;
	if(obj == NULL)
	{
		// what to do
		return;
	}
	//TODO: Suyash
	//obj->Read(*this);
}*/


-(NSMutableArray*) getParamStringArray{
	NSMutableArray* paramArray = [NSMutableArray array];
	short count = [self getShort];
	if(count <= 0)
	{
		return paramArray;
	}
	
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
	{
		uint8_t bByte = (uint8_t)(*mCurrentPointer);
		mCurrentPointer++; //skip entity type
		
		if(bByte == ENTITY_TYPE_NULL)
			return paramArray;
		
		for(int i = 0; i < count; i++)
		{
			NSString* obj; 
			obj = [self getString];
			[paramArray addObject:obj];
		}
		return paramArray;
	}
	
	for(int i = 0; i < count; i++)
	{
		uint8_t etType = (uint8_t)(*mCurrentPointer);
		mCurrentPointer++;
		NSString* strTemp;
		switch(etType)
		{
			case ENTITY_TYPE_INT:
			{
				int nVal = [self getInt];
				strTemp = [NSString stringWithFormat:@"%d", nVal];
				[paramArray addObject:strTemp];
			}
				break;
			case ENTITY_TYPE_LONG:
			{
				long long nVal = [self getInt64];
				strTemp = [NSString stringWithFormat:@"%qi", nVal];
				[paramArray addObject:strTemp];
			}
				break;
			case ENTITY_TYPE_STRING:
			{
				NSString* obj = [self getString];
				[paramArray addObject:obj];
			}
				break;
			case ENTITY_TYPE_OBJECT:
			{
				PGSerializable* obj = [self getObject/*read the class id from the byte array itself*/];
				if(obj)
					[paramArray addObject:obj];
				//TODO: Suyash - Handle the class_ID_Currency appropriately.
				//PGSerializable* obj = NULL;
				//int clsid = [self ReadInt];
				
				//TODO: Suyash - implement object creation correctly.
				/*if(GetPGClient())
					obj = GetPGClient()->CreateObject(clsid);
				if(obj == NULL)
				{
					// what to do
					continue;
				}
				obj->Read(*this);
								
				/*if (clsid == CLASS_ID_CURRENCYAMOUNT)
				{
					PGSCurrencyAmount *currAmt = (PGSCurrencyAmount*)obj;
					strTemp.Format(_T("%I64d~%s"), currAmt->lAmount, currAmt->strCurrencyCode);
					strVector.push_back(strTemp);
					//Currency Amount is no longer used. To avoid the memory leaks used the 
					//Safe delete
					SAFE_DELETE(currAmt);	
				}*/				
			}
				break;
			default:
				break;
		}
	}
	return paramArray;
}

-(NSMutableArray*) getObjectArray
{
	NSMutableArray* objectArray =[NSMutableArray array];
	
	//read the size
	short count = [self getShort];
	if(count <= 0)
	{
		return objectArray;
	}
	
	//read the nature of the collection - homogeneous/heterogeneous
	//if the elements in the vector are homogeneous then read the
	//entity type once, else read entity type for each element.
	
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
	{
		uint8_t bByte = (uint8_t)(*mCurrentPointer);
		mCurrentPointer++;
		if(bByte == ENTITY_TYPE_NULL)
		{
			return objectArray;
		}
		
		for(int i = 0; i < count; i++)
		{
			PGSerializable* obj = [self getObject/*read the class id from the byte array itself*/];
			if(obj != nil)
				[objectArray addObject:obj];
		}
	}
	else if(etCollType == NATURE_HETROGENEOUS)
	{
		//iterate through the objects
		for(int i = 0; i < count; i++)
		{
			uint8_t bByte = (uint8_t)(*mCurrentPointer);
			mCurrentPointer++;
			if(bByte == ENTITY_TYPE_NULL)
			{
				continue;
			}
			else
			{
				PGSerializable* obj = [self getObject/*read the class id from the byte array itself*/];
				if(obj != nil)
					[objectArray addObject:obj];				
			}
		}
	}
	
	return objectArray;
}

-(NSMutableArray*) getStringArray
{
	NSMutableArray* stringArray = [NSMutableArray array];

	//read the size
	short count = [self getShort];
	if(count <= 0)
	{
		return stringArray;
	}
	
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == ENTITY_TYPE_NULL)
	{
		return stringArray;
	}
	
	//if it is same type, then increment only once.
	//if it is different type, then every element needs to be
	//incremented to know the type
	if(etCollType == NATURE_HOMOGENEOUS)
	{
		uint8_t bByte = (uint8_t)(*mCurrentPointer);
		mCurrentPointer++;
		if(bByte == ENTITY_TYPE_NULL)
		{
			return stringArray;
		}
		for(int i = 0; i < count; i++)
		{
			NSString* obj = [self getString];
			[stringArray addObject:obj];
		}
	}
	else if(etCollType == NATURE_HETROGENEOUS)
	{
		for(int i = 0; i < count; i++)
		{
			uint8_t bByte = (uint8_t)(*mCurrentPointer);
			mCurrentPointer++;
			if(bByte == ENTITY_TYPE_NULL)
			{
				continue;
			}
			else
			{
				NSString* obj = [self getString];
				[stringArray addObject:obj];
			}
		}
	}
	
	return stringArray;
}

-(NSMutableArray*) getIntArray
{
	NSMutableArray* intArray = [NSMutableArray array];

	short count = [self getShort];
	if(count <= 0)
	{
		return intArray;
	}
	
	//if count is zero, what should we do, go ahead read coll type?
	
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
	{
		uint8_t bByte = (uint8_t)(*mCurrentPointer);
		mCurrentPointer++;
		if(bByte == ENTITY_TYPE_NULL)
		{
			return intArray;
		}
		
		for(int i = 0; i < count; i++)
		{
			int val = [self getInt];
			[intArray addObject:[NSNumber numberWithInt:val]];
		}
	}
	else if(etCollType == NATURE_HETROGENEOUS) 
	{	
		for(int i = 0; i < count; i++)
		{
			uint8_t bByte = (uint8_t)(*mCurrentPointer);
			mCurrentPointer++;
			if(bByte == ENTITY_TYPE_NULL)
				continue;
			int val = [self getInt];
			[intArray addObject:[NSNumber numberWithInt:val]];
		}
	}
	
	return intArray;
}

-(NSMutableArray*) getInt64Array
{
	NSMutableArray* intArray = [NSMutableArray array];
	
	short count = [self getShort];
	if(count <= 0)
	{
		return intArray;
	}
	
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
	{	
		uint8_t bByte = (uint8_t)(*mCurrentPointer);
		mCurrentPointer++;
		if(bByte == ENTITY_TYPE_NULL)
		{
			return intArray;
		}
		for(int i = 0; i < count; i++)
		{
			long long val =[self getInt64];
			[intArray addObject:[NSNumber numberWithLongLong:val]];
		}
	}
	else if(etCollType == NATURE_HETROGENEOUS)
	{
		for(int i = 0; i < count; i++)
		{
			uint8_t bByte = (uint8_t)(*mCurrentPointer);
			mCurrentPointer++;
			if(bByte == ENTITY_TYPE_NULL)
			{
				continue;
			}
			long long val =[self getInt64];
			[intArray addObject:[NSNumber numberWithLongLong:val]];
		}
	}
	
	return intArray;
}

-(NSMutableArray*) getStringExArray
{
	NSMutableArray* stringArray = [NSMutableArray array];
	
	short count = [self getShort];
	if(count <= 0)
	{
		return stringArray;
	}
	
	//if count is zero, what should we do, go ahead read coll type?
	
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
	{
		uint8_t bByte = (uint8_t)(*mCurrentPointer);
		mCurrentPointer++;
		if(bByte == ENTITY_TYPE_NULL)
		{
			return stringArray;
		}
		for(int i = 0; i < count; i++)
		{
			PGStringEx* strEx = [self getStringEx];
			if (strEx != nil) {
				[stringArray addObject:strEx];
			}			
		}
	}
	else if(etCollType == NATURE_HETROGENEOUS) 
	{	
		for(int i = 0; i < count; i++)
		{
			uint8_t bByte = (uint8_t)(*mCurrentPointer);
			mCurrentPointer++;
			if(bByte == ENTITY_TYPE_NULL)
				continue;
			
			PGStringEx* strEx = [self getStringEx];
			if (strEx != nil) {
				[stringArray addObject:strEx];
			}
		}
	}
	
	return stringArray;
}

#pragma mark -
#pragma mark map deserializers

-(NSMutableDictionary*) getShort2ShortMap
{
	NSMutableDictionary* dict =[NSMutableDictionary dictionary];
			
	short count = [self getShort];
	if(count <= 0)
	{
		return dict;
	}
	
	//check whether it is homogeneous/heterogeneous
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
		mCurrentPointer += 2;
	
	for(int i = 0; i < count; i++)
	{
		if(etCollType == NATURE_HETROGENEOUS)
			mCurrentPointer += 2;
		
		short sKey,sValue;
		sKey = [self getShort];
		sValue = [self getShort];
		
		[dict setValue:[NSNumber numberWithInt:sValue] forKey:[NSString stringWithFormat:@"%d",sKey]];	
	}
	
	return dict;
}

-(NSMutableDictionary*) getShort2StringMap
{
	NSMutableDictionary* dict =[NSMutableDictionary dictionary];
	

	short count = [self getShort];
	if(count <= 0)
	{
		return dict;
	}
	
	//check whether it is homogeneous/heterogeneous
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
		mCurrentPointer += 2;
	
	for(int i = 0; i < count; i++)
	{
		if(etCollType == NATURE_HETROGENEOUS)
			mCurrentPointer += 2;
		
		short sKey = [self getShort];
		NSString* strValue = [self getString];
		
		[dict setValue:strValue forKey:[NSString stringWithFormat:@"%d",sKey]];
 	}
	
	return dict;
}

-(NSMutableDictionary*) getShort2IntMap
{
	NSMutableDictionary* dict =[NSMutableDictionary dictionary];
	
	
	short count = [self getShort];
	if(count <= 0)
	{
		return dict;
	}
	
	//check whether it is homogeneous/heterogeneous
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
		mCurrentPointer += 2;
	
	for(int i = 0; i < count; i++)
	{
		if(etCollType == NATURE_HETROGENEOUS)
			mCurrentPointer += 2;
		
		short sKey = [self getShort];
		int nValue = [self getInt];
		[dict setValue:[NSNumber numberWithInt:nValue] forKey:[NSString stringWithFormat:@"%d",sKey]];			
	}
	
	return dict;
}

-(NSMutableDictionary*) getString2IntMap
{
    NSMutableDictionary* dict =[NSMutableDictionary dictionary];
    
    short count = [self getShort];
    if(count <= 0)
    {
        return dict;
    }
    
    //check whether it is homogeneous/heterogeneous
    //read the nature
    uint8_t etCollType = (uint8_t)(*mCurrentPointer);
    mCurrentPointer++;
    
    if(etCollType == NATURE_HOMOGENEOUS)
        mCurrentPointer += 2;
    
    for(int i = 0; i < count; i++)
    {
        if(etCollType == NATURE_HETROGENEOUS)
            mCurrentPointer += 2;
        
        NSString* strKey = [self getString];
        int nValue = [self getInt];
        
        [dict setValue:[NSNumber numberWithInt:nValue] forKey:strKey];
    }
    
    return dict;
}


-(NSMutableDictionary*) getString2StringMap
{
	NSMutableDictionary* dict =[NSMutableDictionary dictionary];
	
	short count = [self getShort];
	if(count <= 0)
	{
		return dict;
	}
	
	//check whether it is homogeneous/heterogeneous
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
		mCurrentPointer += 2;
	
	for(int i = 0; i < count; i++)
	{
		if(etCollType == NATURE_HETROGENEOUS)
			mCurrentPointer += 2;
		
		NSString* strKey = [self getString];
		NSString* strValue = [self getString];
		
		[dict setValue:strValue forKey:strKey];
	}
	
	return dict;
}

-(NSMutableDictionary*) getByte2VectorMap
{
	NSMutableDictionary* dict =[NSMutableDictionary dictionary];
	
	
	short count = [self getShort];
	if(count <= 0)
	{
		return dict;
	}
	
	//check whether it is homogeneous/heterogeneous
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
		mCurrentPointer += 2;
	
	for(int i = 0; i < count; i++)
	{
		if(etCollType == NATURE_HETROGENEOUS)
			mCurrentPointer += 2;
		
		uint8_t byteKey = [self getByte];
		NSMutableArray* objectArray = [self getObjectArray];
		
		[dict setValue:objectArray forKey:[NSString stringWithFormat:@"%d",byteKey]];
		//@"%%" is not working to format byte into string, however %d is working

	}
	
	return dict;
}

-(NSMutableDictionary*) getByte2Int64Map
{
	NSMutableDictionary* dict =[NSMutableDictionary dictionary];
	
	
	short count = [self getShort];
	if(count <= 0)
	{
		return dict;
	}
	
	//check whether it is homogeneous/heterogeneous
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
		mCurrentPointer += 2;
	
	for(int i = 0; i < count; i++)
	{
		if(etCollType == NATURE_HETROGENEOUS)
			mCurrentPointer += 2;
		
		uint8_t byteKey = [self getByte];
		long long nValue = [self getInt64];
		
		[dict setValue:[NSNumber numberWithLongLong:nValue] forKey:[NSString stringWithFormat:@"%d",byteKey]];
		//@"%%" is not working to format byte into string, however %d is working
	}
	
	return dict;
}


-(NSMutableDictionary*) getInt2PGSerializableMap
{
	NSMutableDictionary* dict =[NSMutableDictionary dictionary];
	
	
	short count = [self getShort];
	if(count <= 0)
	{
		return dict;
	}
	
	//check whether it is homogeneous/heterogeneous
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
		mCurrentPointer += 2;
	
	for(int i = 0; i < count; i++)
	{
		if(etCollType == NATURE_HETROGENEOUS)
			mCurrentPointer += 2;
		
		int nKey = [self getInt];
		PGSerializable* obj = [self getObject/*read the class id from the byte array itself*/];
		[dict setValue:obj forKey:[NSString stringWithFormat:@"%d",nKey]];
	}
	
	return dict;
}

-(NSMutableDictionary*) getShort2Int64Map
{
	NSMutableDictionary* dict =[NSMutableDictionary dictionary];
	
	
	short count = [self getShort];
	if(count <= 0)
	{
		return dict;
	}
	
	//check whether it is homogeneous/heterogeneous
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
		mCurrentPointer += 2;
	
	for(int i = 0; i < count; i++)
	{
		if(etCollType == NATURE_HETROGENEOUS)
			mCurrentPointer += 2;
		
		short sKey = [self getShort];
		long long nValue = [self getInt64];
		
		[dict setValue:[NSNumber numberWithLongLong:nValue] forKey:[NSString stringWithFormat:@"%d",sKey]];
	}
	
	return dict;
}

-(NSMutableDictionary*) getInt2StringMap
{
	NSMutableDictionary* dict =[NSMutableDictionary dictionary];
	
	
	short count = [self getShort];
	if(count <= 0)
	{
		return dict;
	}
	
	//check whether it is homogeneous/heterogeneous
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
		mCurrentPointer += 2;
	
	for(int i = 0; i < count; i++)
	{
		if(etCollType == NATURE_HETROGENEOUS)
			mCurrentPointer += 2;
		
		int nArticleId = [self getInt];
		NSString* strLang = [self getString];

		[dict setValue:strLang forKey:[NSString stringWithFormat:@"%d",nArticleId]];
	}
	
	return dict;
}

-(NSMutableDictionary*) getInt2IntMap
{
	NSMutableDictionary* dict =[NSMutableDictionary dictionary];
	
	
	short count = [self getShort];
	if(count <= 0)
	{
		return dict;
	}
	
	//check whether it is homogeneous/heterogeneous
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
		mCurrentPointer += 2;
	
	for(int i = 0; i < count; i++)
	{
		if(etCollType == NATURE_HETROGENEOUS)
			mCurrentPointer += 2;
		
		int nKey = [self getInt];
		int nValue = [self getInt];
	
		[dict setValue:[NSNumber numberWithInt:nValue] forKey:[NSString stringWithFormat:@"%d",nKey]];
	}
	
	return dict;
}

-(NSMutableDictionary*) getInt2BoolMap
{
	NSMutableDictionary* dict =[NSMutableDictionary dictionary];
	
	
	short count = [self getShort];
	if(count <= 0)
	{
		return dict;
	}
	
	//check whether it is homogeneous/heterogeneous
	//read the nature
	uint8_t etCollType = (uint8_t)(*mCurrentPointer);
	mCurrentPointer++;
	
	if(etCollType == NATURE_HOMOGENEOUS)
		mCurrentPointer += 2;
	
	for(int i = 0; i < count; i++)
	{
		if(etCollType == NATURE_HETROGENEOUS)
			mCurrentPointer += 2;
		
		int intKey = [self getInt];
		BOOL bValue = [self getBOOL];
		
		[dict setValue:[NSNumber numberWithBool:bValue] forKey:[NSString stringWithFormat:@"%d",intKey]];
	}
	
	return dict;
}

-(NSMutableArray*)getEmbeddedObjects
{
	uint8_t * embeddedObjectsStartPointer = mCurrentPointer;
	int size = [self getInt];
	NSMutableArray *objects = [NSMutableArray array];
	while ( (mCurrentPointer - embeddedObjectsStartPointer) <= size) {
		PGSerializable *object = [self getObject];
		if (object) {
			[objects addObject:object];
		}
		else
		{
			break;		
		}
	}
	return objects;
}

- (int) getCurrentPointer {
    return mCurrentPointer - mBasePointer;
}

- (void) setCurrentPointer:(int) pointerValue {
    mCurrentPointer = mBasePointer + pointerValue;
}

@end
