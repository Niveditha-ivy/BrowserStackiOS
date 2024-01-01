/******************************************************************************/
/**
 ** \file PGMessageFrame.m
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
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 **
 ** Author : Suyash Motarwar.
 *******************************************************************************/

#import "PGMessageFrame.h"

@implementation PGMobMessageFrame

@synthesize LengthOfLength = mLengthOfLength;
@synthesize ProtocolVersion = mProtocolVersion;
@synthesize ReceiverIdPresent = mReceiverIdPresent;		
@synthesize LengthOfMessage = mLengthOfMessage;
@synthesize ClassId = mClassId;
@synthesize ReceiverId = mReceiverId;

- (id) init{
	  

	self = [super init];
	if (self != nil) {
		mLengthOfLength = -1;
		mReceiverIdPresent = false;
		mLengthOfMessage = -1;
		mClassId = -1;
		mReceiverId = 0;
		mProtocolVersion = -1;
	}
	return self;
}

-(id) initWithLength:(int) lengthOfMessage
			 classId:(int) classId 
		  receiverId:(int) receiverId{	
	
	self = [super init];
	
	if (self != nil) {
		mLengthOfMessage = lengthOfMessage;
		mClassId = classId;
		mReceiverId = receiverId;
		
		mReceiverIdPresent = true;
		if(mReceiverId <= 0 )
		{
			mReceiverIdPresent = false;
		}
		
		mLengthOfLength = 0;
		if(mLengthOfMessage < 256) 
		{
			mLengthOfLength = 0;
		} 
		else if(mLengthOfMessage > 255 && mLengthOfMessage < 65536) 
		{
			mLengthOfLength = 1;
		} 
		else if(mLengthOfMessage > 65535 && mLengthOfMessage < 16777216) 
		{
			mLengthOfLength = 2;
		} 
		else 
		{
			mLengthOfLength = 3;
		}	
		
		mProtocolVersion = 2; //Hardcoded for now.	
	}
	return self;
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
	
	uint8_t header = [byteArrayReader getByte];
	mLengthOfLength = (header & 12) >> 2;
	
	switch(mLengthOfLength) 
	{
		case 0:
			mLengthOfMessage = [byteArrayReader getByte];
			break;
		case 1:
			mLengthOfMessage = [byteArrayReader getTwoByteInt];
			break;
		case 2:			
			mLengthOfMessage = [byteArrayReader getThreeByteInt];
			break;
		case 3:
			mLengthOfMessage = [byteArrayReader getFourByteInt];
			break;
	}
	
	mProtocolVersion = (uint8_t)((header >> 4) & 7);
	mReceiverIdPresent = (header & 2) != 0;
	
		
	int uncompressedSize = 0;
	if(mProtocolVersion == 1 || mProtocolVersion == 3) 
		uncompressedSize = [ byteArrayReader getTwoByteInt];
	else if(mProtocolVersion == 4) 
		uncompressedSize = [byteArrayReader getFourByteInt];
	
	mClassId = [byteArrayReader getThreeByteInt];
	
	NSString *logMessage = [NSString stringWithFormat:@"Class ID from PGMessageFrame = %d", mClassId];	
	//PGDEBUG(logMessage);
	
	if(mReceiverIdPresent) 
	{
		mReceiverId = [byteArrayReader getFourByteInt];
	}
	
	//TODO: suyash - check if the compressed message is deserialized correctly.
	if(mProtocolVersion == 1 || mProtocolVersion == 3 || 
	   mProtocolVersion == 4)
		[byteArrayReader uncompress:uncompressedSize];
	
}

-(void) write:(PGByteArrayWriter*) byteArrayWriter{
	
	uint8_t header = (uint8_t)(0);
	header = (uint8_t)((header << 3) | mProtocolVersion/*version - Regular*/);
	header = (uint8_t)((header << 2) | mLengthOfLength);
	header = (uint8_t)((header << 1) | (mReceiverIdPresent == 0 ? 0 : 1));
	header = (uint8_t)(header << 1);
	[byteArrayWriter putByte:header];
	
	switch(mLengthOfLength) {
		case 0:
			[byteArrayWriter putByte:(uint8_t)mLengthOfMessage];
			break;
		case 1:
			[byteArrayWriter putTwoByteData:mLengthOfMessage];
			break;
		case 2:
			[byteArrayWriter putThreeByteData:mLengthOfMessage];
			break;
		case 3:
			[byteArrayWriter putFourByteData:mLengthOfMessage];
			break;
	}
	
	[byteArrayWriter putThreeByteData:mClassId];

	if(mReceiverIdPresent)
		[byteArrayWriter putFourByteData:mReceiverId];
}

-(void)dealloc
{
	  
//	[super dealloc];
}

@end

