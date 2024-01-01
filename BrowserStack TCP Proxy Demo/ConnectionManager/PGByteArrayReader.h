/******************************************************************************/
/**
 ** \file PGByteArrayReader.h
 **
 **  PGByteArrayReader deserializes the byte stream received from server in to message object.
 **  This class implements protobuf algorithms and also provides support for decompressing the byte stream before actual deserialization
 **	 This class provides basic methods to read data from the byte stream. Individual message classes would use this class to populate themselves.
 **
 **  Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 *******************************************************************************/

#import "MessageBaseClasses.h"
@class PGByteArrayReader;

@protocol PGByteArrayReaderDelegate

-(id) createMessageObject:(PGByteArrayReader*) sender
				  classID:(int) classID;

@end


@interface PGByteArrayReader : NSObject {

	uint8_t *mBasePointer, *mCurrentPointer, *mEndPointer;
	int	mLength;
	id<PGByteArrayReaderDelegate> delegate;
};

@property (nonatomic, retain) id<PGByteArrayReaderDelegate> delegate;

///initializers
- (id) initWithByteArray:(uint8_t*) bytes
				  length:(int)length;

#pragma mark - byte array modifiers
///Method sets new byte array.
-(int) putByteArray:(const void*) pch
	  length:(int) nCount;
///Method appends the new byte array to the existing byte array.
-(int) appendByteArray:(const void*) pch
	   length:(int) nCount;
//returns the remaining byte array
-(NSData*) getByteArray;
//returns remaining bytes to read on the byte array
-(int) availableBytesToRead;

///Reads the UTF8 string from the byte array
-(NSString*) getString;
///Reads integer from the byte array. Uses protobuf algorithms internally.
-(int) getInt;
///Reads 64 bit integer from the byte array. Uses protobuf algorithms internally.
-(long long) getInt64;
///Reads boolean(represented by single byte) from the byte array.
-(BOOL) getBOOL;
///Reads the byte from the byte array.
-(uint8_t) getByte;
//TODO: Suyash - this method seems redundant and can be removed.
///Reads short from the byte array.
-(short) getShort;

///Reads the serializable object from the byte stream for the specified class id.
-(id) getObjectForClassID:(int) classID;
///Reads the serializable object from the byte stream, reads the class id from the bytestream itself.
-(id) getObject;
//TODO: Suyash - need to relook at these methods.
//-(void) readObject: (PGSerializable*) obj;
//-(void) getObjectEx:(PGSerializable*) obj;

///Reads the server string object from the byte array.
-(PGStringEx*) getStringEx;

/// This method uncompresses the remaining bytes on the byte stream. Replaces the existing bytes with uncompressed bytes.
/// Uses ZLib internally for uncompressing the byte stream.
-(int) uncompress:(int) nLen;

/// Resets the reading pointer to the start of the byte stream.
-(void) resetReadingPointer;

/// Methods for reading frame information. These methods do not use protobuf algorithms
-(int) getTwoByteInt;
-(int) getThreeByteInt;
-(int) getFourByteInt;

/// Protobuf algoriths for reading data from the byte stream
-(int) readVariant32;
-(long long) readVarint64;

//TODO:Suyash needs relook, read methods can be removed. short methods can also be removed.
-(short) getFixedLenShort;
-(short) readFixedLenShort;
-(int) readFixedLenInt;
-(int) getFixedLenInt;
-(long long) readFixedLenInt64;
-(long long) getFixedLenInt64;



//-(void) skipBytes:(int) nCount;
//-(void) erase;

/// Method reads the server string parameters from the byte array.
/// Method checks the entity type before reading the parameters.
-(NSMutableArray*) getParamStringArray;
/// Reads the array of objects from the byte array
-(NSMutableArray*) getObjectArray;
/// Reads the array of strings from the byte array
-(NSMutableArray*) getStringArray;
/// Reads the array of integers from the byte array
-(NSMutableArray*) getIntArray;
/// Reads the array of 64 bit integers from the byte array
-(NSMutableArray*) getInt64Array;
/// Reads the array of server strings from the byte array
-(NSMutableArray*) getStringExArray;

//TODO: Suyash - check if the short methods can be totally removed.
/// Reads the short to short dictionary from the byte array.
-(NSMutableDictionary*) getShort2ShortMap;
/// Reads the short to string dictionary from the byte array.
-(NSMutableDictionary*) getShort2StringMap;
/// Reads the short to int dictionary from the byte array.
-(NSMutableDictionary*) getShort2IntMap;
/// Reads the string to string dictionary from the byte array.
-(NSMutableDictionary*) getString2StringMap;
/// Reads the byte to message object array dictionary from the byte array.
-(NSMutableDictionary*) getByte2VectorMap;
/// Reads the byte to 64-bit integer dictionary from the byte array.
-(NSMutableDictionary*) getByte2Int64Map;
/// Reads the int to message object array dictionary from the byte array.
-(NSMutableDictionary*) getInt2PGSerializableMap;
/// Reads the short to 64-bit integer dictionary from the byte array.
-(NSMutableDictionary*) getShort2Int64Map;
/// Reads the int to string dictionary from the byte array.
-(NSMutableDictionary*) getInt2StringMap;
/// Reads the int to int dictionary from the byte array.
-(NSMutableDictionary*) getInt2IntMap;
/// Reads the int to bool dictionary from the byte array.
-(NSMutableDictionary*) getInt2BoolMap;
///Reads the list of objects embedded in a message
-(NSMutableArray*) getEmbeddedObjects;
/// Reads the string to int dictionary from the byte array.
-(NSMutableDictionary*) getString2IntMap;

// Adding for Backward Compatibilty for Serializer
- (int) getCurrentPointer;
- (void) setCurrentPointer:(int) pointerValue;

@end
