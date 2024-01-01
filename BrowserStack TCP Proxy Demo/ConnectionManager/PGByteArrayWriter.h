/******************************************************************************/
/**
 ** \file PGByteArrayReader.h
 **
 **  PGByteArrayWriter serializes the message object in to the byte stream that can be sent to server.
 **  This class implements protobuf algorithms.
 **	 This class provides basic methods to write data to the byte stream. Individual message classes would use this class to serialize themselves.
 **
 **  Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 *******************************************************************************/


@class PGSerializable;

@interface PGByteArrayWriter : NSObject {

	uint8_t *mBasePointer, *mCurrentPointer;
	int mLength;
}

/// Writes the integer on to the byte array, uses protobuf algorithm internally.
-(void) putInt:(int) val;
///TODO: suyash - This is a redundant function, investigate with server team, if it can be removed.
-(void) putShort:(int) val;
/// Writes the 64-bit integer on to the byte array, uses protobuf algorithm internally.
-(void) putInt64:(long long) val;
/// Writes the boolean(represented by one byte) on to the byte array.
-(void) putBOOL:(bool) val;
/// Writes UTF8 string on to the byte array.
-(void) putString:(NSString*) val;
/// Writes byte on to the byte array.
-(void) putByte:(uint8_t) bByte;
/// Writes message object on to the byte array.
-(void) putObject:(PGSerializable*) object;
/// Writes string on to the byte stream.
-(void) putString:(NSString*) str;
/// Writes server string on to the byte stream.
-(void) putStringEx:(PGStringEx*) str;

/// Writes fixed integer on to the byte stream. This method do not use protobuf algorithm.
-(void) putIntFixed:(int) val;
/// Writes fixed 64-bit integer on to the byte stream. This method do not use protobuf algorithm.
-(void) putInt64Fixed:(long long) val;


/// Methods for writting frame information. These methods do not use protobuf algorithms
-(void) putTwoByteData:(int) val;
-(void) putThreeByteData:(int) val;
-(void) putFourByteData:(int) val;

/// Writes the specified bytes on to the byte array.
-(void) write:(uint8_t*) byteArray length:(int) len;

/// Protobuf algoriths for writting data to the byte stream
-(bool) writeVariant32:(int32_t) value;
#if TARGET_MAC
-(bool) writeVarint32Fallback:(uint32) value;
-(bool) writeVariant64:(uint64) value;
#else
-(bool) writeVarint32Fallback:(uint32_t) value;
-(bool) writeVariant64:(uint64_t) value;
#endif

/// Advances writting pointer byt specified number of bytes.
-(void) advanceWritePointer:(int) nCount;

/// Returns the size of the byte array.
-(int) getSize;
/// Returns the byte array.
-(uint8_t*) bytes;

/// Writes message object array on the byte stream.
-(void) putObjectArray:(NSArray*) array;
/// Writes string array on the byte stream.
-(void) putStringArray:(NSArray*) array;
/// Writes 64-bit integer array on the byte stream.
-(void) putInt64Array:(NSArray*) array;
/// Writes integer array on the byte stream.
-(void) putIntArray:(NSArray*) array;
/// Writes server string array on the byte stream.
-(void) putStringExArray:(NSArray*) array;
/// Writes byte array on the byte stream.
-(void) putByteArray:(NSData*) data;

//TODO: Suyash - Reinvestigation required. Probably need to add methods specific to short data type. As server expects this data type, though this is redundant after protobuf implementation.
-(void) putInt2IntMap:(NSDictionary*) dict;
-(void) putInt2StringMap:(NSDictionary*) dict;
-(void) putString2StringMap:(NSDictionary*) dict;
-(void) putByte2ObjectArrayMap:(NSDictionary*) dict;
-(void) putInt2Int64Map:(NSDictionary*) dict;
-(void) putInt2BoolMap:(NSDictionary*) dict;
-(void) putInt2PGSerializableMap:(NSDictionary*) dict;
-(void) putShort2StringMap:(NSDictionary*) dict;
-(void) putByte2Int64Map:(NSDictionary*) dict;
-(void) putShort2IntMap:(NSDictionary*) dict;
-(void) putShort2Int64Map:(NSDictionary*) dict;
-(void) putString2IntMap:(NSDictionary*) dict;
//Writes list of embedded objects on the byte stream
-(void)putEmbeddedObjects:(NSArray*)array;

// Adding for Backward Compatibilty for Serializer
- (int) getCurrentPointer;
- (void) setCurrentPointer:(int) pointerValue;
- (void) putLength:(int)currentPointer length:(int) length;

@end
