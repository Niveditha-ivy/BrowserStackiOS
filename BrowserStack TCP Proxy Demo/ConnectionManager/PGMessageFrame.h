/******************************************************************************/
/**
 ** \file PGMessageFrame.h
 **
 ** Message Frames are the actual objects of communication between the client and the server.
 ** All the message objects are converted to message frames before writing into the sockets as raw data of bytes
 ** Construction of a MessageFrame follows the protocol as described below in the Protocol Description
 ** Each frame will contaion the receiver id as '0' if it addressed to client or a non-zero number which 
 ** indicates the game peer.**
 **
 **
 ** Protocol Description     
 ** 
 ** Following is the proposed structure of a frame in the new protocol 
 ** |---------------------------------------------------------------------------------------------------------------------------------------|
 **|  1 bit  |  3 bits  |  2 bits  |  1 bit  |  1 bit  |  1 - 4 bytes  |  1 / 2 bytes  |  0 / 3 bytes  |  0 / 2 bytes  |  length bytes []  |
 ** |  fs     |  ft      |  lol     |  rp     |  loc    |  length       |  class id     |  receiver id  |  nat info     |  message bytes    |
 ** |---------------------------------------------------------------------------------------------------------------------------------------|
 ** 
 ** ### fs - source of this frame
 ** 0 - frame orginated from client directly 
 ** 1 - frame is being orignated by another connection service 
 ** 
 ** ### ft - frame type indicating what kind of information is held in the frame 
 ** 000 - simple frame 
 ** 001 - simple zipped frame 
 ** 010 - protobuf frame 
 ** 011 - protobuf zipped frame 
 ** 
 ** ### lol - field indicating the length of the length field 
 ** 00 - 1 byte 
 ** 01 - 2 bytes 
 ** 10 - 3 bytes 
 ** 11 - 4 bytes 
 ** 
 ** ### rp - receiver id presence 
 ** 0 - receiver id absent 
 ** 1 - receiver id present 
 ** 
 ** ### loc - field indicating the length of the class id field 
 ** 0 - 1 byte 
 ** 1 - 2 bytes  
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 **
 *******************************************************************************/


#import "PGByteArrayReader.h"
#import "PGByteArrayWriter.h"

@interface PGMobMessageFrame : NSObject {
	int mLengthOfLength;
	uint8_t mProtocolVersion;
	bool mReceiverIdPresent;		
	int mLengthOfMessage;
	int mClassId;
	int mReceiverId;
}

@property (nonatomic) int LengthOfLength;
@property (nonatomic) uint8_t ProtocolVersion;
@property (nonatomic) bool ReceiverIdPresent;		
@property (nonatomic) int LengthOfMessage;
@property (nonatomic) int ClassId;
@property (nonatomic) int ReceiverId;

-(id) initWithLength:(int) lengthOfMessage
			   classId:(int) classId 
			receiverId:(int) receiverId;
///Reads the message frame from the byte stream.
-(void) read:(PGByteArrayReader*) byteArrayReader;
///Writes the message frame to the byte stream.
-(void) write:(PGByteArrayWriter*) byteArrayWriter;

@end
