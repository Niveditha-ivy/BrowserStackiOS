/******************************************************************************/
/**
 ** \file PGByteArrayReader.m
 **
 **  PGByteArrayWriter serializes the message object in to the byte stream that can be sent to server.
 **  This class implements protobuf algorithms.
 **     This class provides basic methods to write data to the byte stream. Individual message classes would use this class to serialize themselves.
 **
 **  Copyright (c) PartyGaming, Plc. All rights reserved.
 **
 ** Author : Suyash Motarwar
 *******************************************************************************/

#import "MessageBaseClasses.h"
#import "PGByteArrayWriter.h"
#import "Constants.h"
const int kMaxVarint32Bytes = 5;
const int kMaxVarintBytes = 10;


@implementation PGByteArrayWriter

- (id) init
{
      

    self = [super init];
    if (self != nil) {
        mBasePointer = nil;
        mCurrentPointer = nil;
        mLength = 0;
    }
    return self;
}

- (void) dealloc
{
      

    free(mBasePointer);
    mBasePointer = nil;
    mCurrentPointer = nil;
    mLength = 0;
    [super dealloc];
}

-(void) write:(uint8_t*) byteArray length:(int) len
{
    [self refreshBuffer:len];
    /*int available = mLength - (mCurrentPointer-mBasePointer);
     if(available < len)
     {
     mLength += 1024 + len;
     uint8_t* buf = malloc(mLength);
     memset(buf,'\0',sizeof(buf));
     memcpy(buf, mBasePointer, (mCurrentPointer-mBasePointer));
     mCurrentPointer = buf + (mCurrentPointer-mBasePointer);
     free(mBasePointer);
     mBasePointer = buf;
     }*/
    memcpy(mCurrentPointer, byteArray, len);
    mCurrentPointer += len;
}

-(void) refreshBuffer:(int) len {
    int available = mLength - (mCurrentPointer-mBasePointer);
    if(available < len)
    {
        mLength += 1024 + len;
        uint8_t* buf = malloc(mLength);
        memset(buf,'\0',sizeof(buf));
        memcpy(buf, mBasePointer, (mCurrentPointer-mBasePointer));
        mCurrentPointer = buf + (mCurrentPointer-mBasePointer);
        free(mBasePointer);
        mBasePointer = buf;
    }
}

-(void) putBOOL:(bool) val
{
    [self putByte:val];
}

-(void) putByte:(uint8_t) bByte
{
    [self write:&bByte
         length:1];
}

-(void) putInt:(int) val
{
    [self writeVariant32:val];
}

-(void) putShort:(int) val
{
    [self writeVariant32:val];
}

-(void) putIntFixed:(int) val
{
    unsigned long convertedValue = htonl(val);
    [self write:(uint8_t*)&convertedValue
         length:sizeof(convertedValue)];
}

-(void) putInt64:(long long) val
{
    [self writeVariant64:val];
}

-(void) putInt64Fixed:(long long) val
{
    unsigned long long h =  htonl( (val >> 32) & 0xFFFFFFFF);
    [self write:(uint8_t*)&h
         length:sizeof(h)];
#pragma message( "ARA : While Trying To Suppress This Warning Check Whether You Are Getting Correct Output, AS SUPPRESSING THIS WARNING IS INTRODUCING TRUNCATION ERROR C4293: '<<'  " )
#pragma message ("http://msdn.microsoft.com/en-us/library/cx0bb1cy(VS.80).aspx")
    h = ((long long) (((long long)htonl(val & 0xFFFFFFFF))  << 32));
    [self write:(uint8_t*)&h
         length:sizeof(h)];
}


-(void) putTwoByteData:(int) val
{
    [self putByte:( (uint8_t) (val>>8) )];
    [self putByte:( (uint8_t) (val) )];
}

-(void) putThreeByteData:(int) val
{
    [self putByte:( (uint8_t) (val>>16) )];
    [self putByte:( (uint8_t) (val>>8) )];
    [self putByte:( (uint8_t) (val) )];
}

-(void) putFourByteData:(int) val
{
    [self putByte:( (uint8_t) (val>>24) )];
    [self putByte:( (uint8_t) (val>>16) )];
    [self putByte:( (uint8_t) (val>>8) )];
    [self putByte:( (uint8_t) (val) )];
}

-(void) putString:(NSString*) str
{
    if([str length] == 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
        
    //Just write the number of bytes
    [self writeVariant32:[data length]];
    
    [self write:(uint8_t*)[data bytes]
         length:[data length]];
}

-(void) putObject:(PGSerializable*) obj
{
    [obj write:self];
    if(ENABLE_SRLZR_BW_COMPATIBILTY) {
        [obj writeLength:self];
    }
}

#if TARGET_MAC
-(bool) writeVarint32Fallback:(uint32) value
{
    int buffer_size_ = mLength - (mCurrentPointer-mBasePointer);
    if (buffer_size_ >= kMaxVarint32Bytes)
    {
        // Fast path:  We have enough bytes left in the buffer to guarantee that
        // this write won't cross the end, so we can skip the checks.
        uint8* target = (uint8*)mCurrentPointer;
        
        target[0] = (uint8_t)(value | 0x80);
        if (value >= (1 << 7))
        {
            target[1] = (uint8_t)((value >>  7) | 0x80);
            if (value >= (1 << 14))
            {
                target[2] = (uint8_t)((value >> 14) | 0x80);
                if (value >= (1 << 21))
                {
                    target[3] = (uint8_t)((value >> 21) | 0x80);
                    if (value >= (1 << 28))
                    {
                        target[4] = (uint8_t)(value >> 28);
                        [self advanceWritePointer:5];
                    }
                    else
                    {
                        target[3] &= 0x7F;
                        [self advanceWritePointer:4];
                    }
                }
                else
                {
                    target[2] &= 0x7F;
                    [self advanceWritePointer:3];
                }
            }
            else
            {
                target[1] &= 0x7F;
                [self advanceWritePointer:2];
            }
        }
        else
        {
            target[0] &= 0x7F;
            [self advanceWritePointer:1];
        }
        
        return true;
    }
    else
    {
        // Slow path:  This write might cross the end of the buffer, so we
        // compose the bytes first then use WriteRaw().
        uint8 bytes[kMaxVarint32Bytes];
        int size = 0;
        while (value > 0x7F)
        {
            bytes[size++] = ((uint8_t)(value) & 0x7F) | 0x80;
            value >>= 7;
        }
        bytes[size++] = (uint8_t)(value) & 0x7F;
        [self write:(uint8_t*)bytes
             length:size];
        return true;
    }
}


-(bool) writeVariant64:(uint64) value
{
    int buffer_size_ = mLength - (mCurrentPointer-mBasePointer);
    if (buffer_size_ >= kMaxVarintBytes)
    {
        // Fast path:  We have enough bytes left in the buffer to guarantee that
        // this write won't cross the end, so we can skip the checks.
        uint8* target = (uint8*)mCurrentPointer;
        
        // Splitting into 32-bit pieces gives better performance on 32-bit
        // processors.
        uint32 part0 = (uint32_t)(value      );
        uint32 part1 = (uint32_t)(value >> 28);
        uint32 part2 = (uint32_t)(value >> 56);
        
        int size;
        
        // Here we can't really optimize for small numbers, since the value is
        // split into three parts.  Cheking for numbers < 128, for instance,
        // would require three comparisons, since you'd have to make sure part1
        // and part2 are zero.  However, if the caller is using 64-bit integers,
        // it is likely that they expect the numbers to often be very large, so
        // we probably don't want to optimize for small numbers anyway.  Thus,
        // we end up with a hardcoded binary search tree...
        if (part2 == 0)
        {
            if (part1 == 0)
            {
                if (part0 < (1 << 14))
                {
                    if (part0 < (1 << 7))
                    {
                        size = 1; goto size1;
                    }
                    else
                    {
                        size = 2; goto size2;
                    }
                }
                else
                {
                    if (part0 < (1 << 21))
                    {
                        size = 3; goto size3;
                    }
                    else
                    {
                        size = 4; goto size4;
                    }
                }
            }
            else
            {
                if (part1 < (1 << 14))
                {
                    if (part1 < (1 << 7))
                    {
                        size = 5; goto size5;
                    }
                    else
                    {
                        size = 6; goto size6;
                    }
                }
                else
                {
                    if (part1 < (1 << 21))
                    {
                        size = 7; goto size7;
                    }
                    else
                    {
                        size = 8; goto size8;
                    }
                }
            }
        }
        else
        {
            if (part2 < (1 << 7))
            {
                size = 9; goto size9;
            }
            else
            {
                size = 10; goto size10;
            }
        }
        
    size10: target[9] = (uint8_t)((part2 >>  7) | 0x80);
        size9 : target[8] = (uint8_t)((part2      ) | 0x80);
        size8 : target[7] = (uint8_t)((part1 >> 21) | 0x80);
        size7 : target[6] = (uint8_t)((part1 >> 14) | 0x80);
        size6 : target[5] = (uint8_t)((part1 >>  7) | 0x80);
        size5 : target[4] = (uint8_t)((part1      ) | 0x80);
        size4 : target[3] = (uint8_t)((part0 >> 21) | 0x80);
        size3 : target[2] = (uint8_t)((part0 >> 14) | 0x80);
        size2 : target[1] = (uint8_t)((part0 >>  7) | 0x80);
        size1 : target[0] = (uint8_t)((part0      ) | 0x80);
        
        target[size-1] &= 0x7F;
        [self advanceWritePointer:size];
        return true;
    }
    else
    {
        // Slow path:  This write might cross the end of the buffer, so we
        // compose the bytes first then use WriteRaw().
        uint8 bytes[kMaxVarintBytes];
        int size = 0;
        while (value > 0x7F)
        {
            bytes[size++] = ((uint8_t)(value) & 0x7F) | 0x80;
            value >>= 7;
        }
        bytes[size++] = (uint8_t)(value) & 0x7F;
        [self write:(uint8_t*)bytes
             length:size];
        return true;
    }
}
#endif


#if TARGET_IOS
#endif

-(bool) writeVariant32:(int32_t) value
{
    if (value < 0)
    {
        return [self writeVariant64:(long long)(value)];
    }
    else
    {
        return [self writeVarint32Fallback:(uint32_t)(value)];
    }
}

-(void) advanceWritePointer:(int) nCount
{
    mCurrentPointer += nCount;
}

-(void) putStringEx:(PGStringEx*) str
{
    //if( [str literalId] < 0 )
//    {
//        [self putByte:0];
//        return;
//    }
    
    [self putByte:1];
    [self putInt:[str literalId]];
    [self putStringArray:[str parameterValues]];
    [self putBOOL:[str isLanguagePackElement]];
}


-(int) getSize
{
    return (mCurrentPointer-mBasePointer);
}

-(uint8_t*) bytes
{
    //return mBasePointer;
    
    int len = (mCurrentPointer-mBasePointer);
    if(len > 0 )
    {
        return mBasePointer;
    }

    return nil;
}

#pragma mark -
#pragma mark writting all arrays

-(void) putObjectArray:(NSArray*) array
{
    int nSize = [array count];
    if(nSize <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    [self putInt:nSize];
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    [self putByte:(uint8_t)ENTITY_TYPE_OBJECT];
    
    for(int i = 0; i < nSize; i++)
    {
        [self putObject:[array objectAtIndex:i]];
    }
}


-(void) putStringArray:(NSArray*) array
{
    int nSize = [array count];
    if(nSize <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    [self putInt:nSize];
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    [self putByte:(uint8_t)ENTITY_TYPE_STRING];
    
    for(int i = 0; i < nSize; i++)
    {
        NSString* str = nil;
        id object = [array objectAtIndex:i];
        
        if ([object isKindOfClass:[PGSerializable class]]) {
            str = [object description];
        }
        else {
            str = (NSString*) object;
        }
        
        [self putString:str];
    }
}


-(void) putInt64Array:(NSArray*) array
{
    int nSize = [array count];
    if(nSize <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    [self putInt:nSize];
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    [self putByte:(uint8_t)ENTITY_TYPE_LONG];
    
    for(int i = 0; i < nSize; i++)
    {
        [self putInt64:[(NSNumber*)[array objectAtIndex:i] longLongValue]];
    }
}


-(void) putIntArray:(NSArray*) array
{
    int nSize = [array count];
    if(nSize <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    [self putInt:nSize];
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    [self putByte:(uint8_t)ENTITY_TYPE_INT];
    
    for(int i = 0; i < nSize; i++)
    {
        [self putInt:[(NSNumber*)[array objectAtIndex:i] integerValue]];
    }
}

-(void) putStringExArray:(NSArray*) array
{
    int nSize = [array count];
    if(nSize <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    [self putInt:nSize];
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    [self putByte:(uint8_t)ENTITY_TYPE_STRINGEX];
    
    for(int i = 0; i < nSize; i++)
    {
        [self putStringEx:[array objectAtIndex:i]];
    }
}

-(void) putByteArray:(NSData*) data
{
    int nSize = [data length];
    if(nSize <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    [self putInt:nSize];

    [self write:(uint8_t *)[data bytes]
         length:nSize];
}

#pragma mark -
#pragma mark Map writers


-(void) putInt2IntMap:(NSDictionary*) dict
{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. Write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    
    //3. Send the key type
    [self putByte:(uint8_t)ENTITY_TYPE_INT];

    //4.  and value type
    [self putByte:(uint8_t)ENTITY_TYPE_INT];
    
    for (id key in dict) {
        id anObject = [dict objectForKey:key];
        
        int intKey = [key integerValue];
        int value  = [(NSNumber*)anObject integerValue];
        
        [self putInt:intKey];
        [self putInt:value];
    }
}

-(void) putInt2StringMap:(NSDictionary*) dict
{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    
    //3. Send the key type
    [self putByte:(uint8_t)ENTITY_TYPE_INT];
    
    //4.  and value type
    [self putByte:(uint8_t)ENTITY_TYPE_STRING];
    
    for (id key in dict) {
        id anObject = [dict objectForKey:key];
        
        int intKey = [key integerValue];
        NSString* value  = (NSString*)anObject;
        
        [self putInt:intKey];
        [self putString:value];
    }
}

-(void) putString2StringMap:(NSDictionary*) dict
{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    
    //3. Send the key type
    [self putByte:(uint8_t)ENTITY_TYPE_STRING];
    
    //4.  and value type
    [self putByte:(uint8_t)ENTITY_TYPE_STRING];
    
    for (id key in dict) {
        id anObject = [dict objectForKey:key];
        
        NSString* strKey = (NSString*) key;
        NSString* value  = (NSString*) anObject;
        
        [self putString:strKey];
        [self putString:value];
    }
}

-(void) putByte2ObjectArrayMap:(NSDictionary*) dict
{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    
    //3. Send the key type
    [self putByte:(uint8_t)ENTITY_TYPE_BYTE];
    
    //4.  and value type
    [self putByte:(uint8_t)ENTITY_TYPE_VECTOR];
    
    for (id key in dict) {
        id anObject = [dict objectForKey:key];
        
        uint8_t byteKey = (uint8_t)[key integerValue];
        NSArray*  array  = (NSArray*) anObject;
        
        [self putByte:byteKey];
        [self putObjectArray:array];
    }
}


-(void) putByte2Int64Map:(NSDictionary*) dict
{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    
    //3. Send the key type
    [self putByte:(uint8_t)ENTITY_TYPE_INT];
    
    //4.  and value type
    [self putByte:(uint8_t)ENTITY_TYPE_LONG];
    
    for (id key in dict) {
        id anObject = [dict objectForKey:key];
        
        uint8_t byteKey = (uint8_t)[key integerValue];
        long long value  = [(NSNumber*)anObject longLongValue];
        
        [self putByte:byteKey];
        [self putInt64:value];
    }
}

-(void) putString2IntMap:(NSDictionary*) dict
{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    
    //3. Send the key type
    [self putByte:(uint8_t)ENTITY_TYPE_STRING];
    
    //4.  and value type
    [self putByte:(uint8_t)ENTITY_TYPE_INT];
    
    for (id key in dict) {
        id anObject = [dict objectForKey:key];
        
        NSString* strKey = (NSString*) key;
        int value  = [anObject integerValue];
        
        [self putString:strKey];
        [self putInt:value];
    }
}


-(void) putShort2IntMap:(NSDictionary*) dict{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. Write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    
    //3. Send the key type
    [self putByte:(uint8_t)ENTITY_TYPE_SHORT];
    
    //4.  and value type
    [self putByte:(uint8_t)ENTITY_TYPE_INT];
    
    for (id key in dict) {
        id anObject = [dict objectForKey:key];
        
        short intKey = [key shortValue];
        int value  = [(NSNumber*)anObject integerValue];
        
        [self putShort:intKey];
        [self putInt:value];
    }
    
}

-(void) putShort2Int64Map:(NSDictionary*) dict{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. Write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    
    //3. Send the key type
    [self putByte:(uint8_t)ENTITY_TYPE_SHORT];
    
    //4.  and value type
    [self putByte:(uint8_t)ENTITY_TYPE_LONG];
    
    for (id key in dict) {
        id anObject = [dict objectForKey:key];
        
        short intKey = [key shortValue];
        long long value  = [(NSNumber*)anObject longLongValue];
        
        [self putShort:intKey];
        [self putInt64:value];
    }
    
}

-(void) putInt2Int64Map:(NSDictionary*) dict
{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    
    //3. Send the key type
    [self putByte:(uint8_t)ENTITY_TYPE_INT];
    
    //4.  and value type
    [self putByte:(uint8_t)ENTITY_TYPE_LONG];
    
    for (id key in dict) {
        id anObject = [dict objectForKey:key];
        
        int intKey = [key integerValue];
        long long value  = [(NSNumber*)anObject longLongValue];
        
        [self putInt:intKey];
        [self putInt64:value];
    }
}

-(void) putInt2BoolMap:(NSDictionary*) dict
{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    
    //3. Send the key type
    [self putByte:(uint8_t)ENTITY_TYPE_INT];
    
    //4.  and value type
    [self putByte:(uint8_t)ENTITY_TYPE_BOOLEAN];
    
    for (id key in dict) {
        id anObject = [dict objectForKey:key];
        
        int intKey = [key integerValue];
        int8_t value  = [(NSNumber*)anObject integerValue];
        
        [self putInt:intKey];
        [self putByte:value];
    }
}

-(void) putInt2PGSerializableMap:(NSDictionary*) dict
{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HETROGENEOUS];
        
    for (id key in dict) {
        //3. Send the key type
        [self putByte:(uint8_t)ENTITY_TYPE_INT];
        
        //4.  and value type
        [self putByte:(uint8_t)ENTITY_TYPE_OBJECT];
        
        id anObject = [dict objectForKey:key];
        int intKey = [key integerValue];
        PGSerializable*  messageObject  = (PGSerializable*) anObject;
        
        [self putInt:intKey];
        [self putObject:messageObject];
    }
}

-(void) putShort2StringMap:(NSDictionary*) dict
{
    int size = [dict count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    
    //1. write the number of elements.
    [self putInt:size];
    
    //2. write the nature homogeneous/heterogeneous
    [self putByte:(uint8_t)NATURE_HOMOGENEOUS];
    
    //3. Send the key type
    [self putByte:(uint8_t)ENTITY_TYPE_SHORT];
    
    //4.  and value type
    [self putByte:(uint8_t)ENTITY_TYPE_STRING];
    
    for (id key in dict) {
        id anObject = [dict objectForKey:key];
        
        int intKey = [key integerValue];
        NSString* value  = (NSString*)anObject;
        
        [self putInt:intKey];
        [self putString:value];
    }
}

-(void)putEmbeddedObjects:(NSArray*)array
{
    int size = [array count];
    if(size <= 0)
    {
        [self writeVariant32:0];
        return;
    }
    [self putInt:size];
    NSEnumerator *enumerator = [array objectEnumerator];
    PGSerializable *object = nil;
    while (object = [enumerator nextObject]) {
        [self putObject:object];
    }
}

- (int) getCurrentPointer {
    return mCurrentPointer - mBasePointer;
}
- (void) setCurrentPointer:(int) pointerValue {
    mCurrentPointer = mBasePointer + pointerValue;
}

- (void) putLength:(int)currentPointer length:(int) length {
    int numberOfBytes = [self getNumberOfBytesForLength:length];
    if(numberOfBytes > 1 ) {
        int additionalBytesForLength = numberOfBytes - 1;
        int newDataEndPosition = (mCurrentPointer - mBasePointer)+ additionalBytesForLength - 1;
        
        if(mLength < newDataEndPosition) {
            // refresh buffer..
            [self refreshBuffer:newDataEndPosition-mLength];
        }
        
        for(int i = newDataEndPosition; i > (int)(currentPointer + additionalBytesForLength); i--) {
            mBasePointer[i] = mBasePointer[i-additionalBytesForLength] ;
        }
        mCurrentPointer = mBasePointer + currentPointer;
        [self putInt:length];
        mCurrentPointer = mBasePointer + newDataEndPosition + 1;
    } else {
        mBasePointer[currentPointer] = (Byte) length;
        
    }
}

- (int) getNumberOfBytesForLength:(int) value {
    int count = 0;
    while (true) {
        if ((value & ~0x7F) == 0) {
            count++;
            return count;
        }
        count++;
        value >>= 7;
    }
}

- (bool)writeVarint32Fallback:(uint32_t)value {
    int buffer_size_ = mLength - (mCurrentPointer-mBasePointer);
    if (buffer_size_ >= kMaxVarint32Bytes)
    {
        // Fast path:  We have enough bytes left in the buffer to guarantee that
        // this write won't cross the end, so we can skip the checks.
        uint8_t* target = (uint8_t*)mCurrentPointer;
        
        target[0] = (uint8_t)(value | 0x80);
        if (value >= (1 << 7))
        {
            target[1] = (uint8_t)((value >>  7) | 0x80);
            if (value >= (1 << 14))
            {
                target[2] = (uint8_t)((value >> 14) | 0x80);
                if (value >= (1 << 21))
                {
                    target[3] = (uint8_t)((value >> 21) | 0x80);
                    if (value >= (1 << 28))
                    {
                        target[4] = (uint8_t)(value >> 28);
                        [self advanceWritePointer:5];
                    }
                    else
                    {
                        target[3] &= 0x7F;
                        [self advanceWritePointer:4];
                    }
                }
                else
                {
                    target[2] &= 0x7F;
                    [self advanceWritePointer:3];
                }
            }
            else
            {
                target[1] &= 0x7F;
                [self advanceWritePointer:2];
            }
        }
        else
        {
            target[0] &= 0x7F;
            [self advanceWritePointer:1];
        }
        
        return true;
    }
    else
    {
        // Slow path:  This write might cross the end of the buffer, so we
        // compose the bytes first then use WriteRaw().
        uint8_t bytes[kMaxVarint32Bytes];
        int size = 0;
        while (value > 0x7F)
        {
            bytes[size++] = ((uint8_t)(value) & 0x7F) | 0x80;
            value >>= 7;
        }
        bytes[size++] = (uint8_t)(value) & 0x7F;
        [self write:(uint8_t*)bytes
             length:size];
        return true;
    }
}

- (bool)writeVariant64:(uint64_t)value {
    int buffer_size_ = mLength - (mCurrentPointer-mBasePointer);
    if (buffer_size_ >= kMaxVarintBytes)
    {
        // Fast path:  We have enough bytes left in the buffer to guarantee that
        // this write won't cross the end, so we can skip the checks.
        uint8_t* target = (uint8_t*)mCurrentPointer;
        
        // Splitting into 32-bit pieces gives better performance on 32-bit
        // processors.
        uint32_t part0 = (uint32_t)(value      );
        uint32_t part1 = (uint32_t)(value >> 28);
        uint32_t part2 = (uint32_t)(value >> 56);
        
        int size;
        
        // Here we can't really optimize for small numbers, since the value is
        // split into three parts.  Cheking for numbers < 128, for instance,
        // would require three comparisons, since you'd have to make sure part1
        // and part2 are zero.  However, if the caller is using 64-bit integers,
        // it is likely that they expect the numbers to often be very large, so
        // we probably don't want to optimize for small numbers anyway.  Thus,
        // we end up with a hardcoded binary search tree...
        if (part2 == 0)
        {
            if (part1 == 0)
            {
                if (part0 < (1 << 14))
                {
                    if (part0 < (1 << 7))
                    {
                        size = 1; goto size1;
                    }
                    else
                    {
                        size = 2; goto size2;
                    }
                }
                else
                {
                    if (part0 < (1 << 21))
                    {
                        size = 3; goto size3;
                    }
                    else
                    {
                        size = 4; goto size4;
                    }
                }
            }
            else
            {
                if (part1 < (1 << 14))
                {
                    if (part1 < (1 << 7))
                    {
                        size = 5; goto size5;
                    }
                    else
                    {
                        size = 6; goto size6;
                    }
                }
                else
                {
                    if (part1 < (1 << 21))
                    {
                        size = 7; goto size7;
                    }
                    else
                    {
                        size = 8; goto size8;
                    }
                }
            }
        }
        else
        {
            if (part2 < (1 << 7))
            {
                size = 9; goto size9;
            }
            else
            {
                size = 10; goto size10;
            }
        }
        
    size10: target[9] = (uint8_t)((part2 >>  7) | 0x80);
        size9 : target[8] = (uint8_t)((part2      ) | 0x80);
        size8 : target[7] = (uint8_t)((part1 >> 21) | 0x80);
        size7 : target[6] = (uint8_t)((part1 >> 14) | 0x80);
        size6 : target[5] = (uint8_t)((part1 >>  7) | 0x80);
        size5 : target[4] = (uint8_t)((part1      ) | 0x80);
        size4 : target[3] = (uint8_t)((part0 >> 21) | 0x80);
        size3 : target[2] = (uint8_t)((part0 >> 14) | 0x80);
        size2 : target[1] = (uint8_t)((part0 >>  7) | 0x80);
        size1 : target[0] = (uint8_t)((part0      ) | 0x80);
        
        target[size-1] &= 0x7F;
        [self advanceWritePointer:size];
        return true;
    }
    else
    {
        // Slow path:  This write might cross the end of the buffer, so we
        // compose the bytes first then use WriteRaw().
        uint8_t bytes[kMaxVarintBytes];
        int size = 0;
        while (value > 0x7F)
        {
            bytes[size++] = ((uint8_t)(value) & 0x7F) | 0x80;
            value >>= 7;
        }
        bytes[size++] = (uint8_t)(value) & 0x7F;
        [self write:(uint8_t*)bytes
             length:size];
        return true;
    }    
}


@end
