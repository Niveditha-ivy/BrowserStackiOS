/******************************************************************************/
/**
 ** \file MessageBaseClasses.h
 **
 **  This file contains all the base classes for client server messaging framework.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 *******************************************************************************/

#import <Foundation/Foundation.h>

@class PGByteArrayReader;
@class PGByteArrayWriter;

///Base class for all messages classes. 
///If mTopLevelMessage is true then the class ID would be written as part of the Frame. 
///If mTopLevelMessage is false then the class ID would be writen as part of the object serialization.
@interface PGSerializable : NSObject
{
	BOOL mTopLevelMessage;
	int mClassID;
    int mLengthStartPosition;
};

@property (nonatomic) BOOL topLevelMessage;
@property (nonatomic) int classID;
@property (nonatomic) int lengthStartPosition;

///This method is place holder, not being used.
-(void) read:(PGByteArrayReader*) byteArrayReader;

///This method writes the class ID in to the bytestream if the current object is not a top level object.
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
-(void) writeLength:(PGByteArrayWriter*) byteArrayWriter;

-(BOOL) isCompositeMessage;

-(NSMutableArray*) messages;

@end


///Base class for all privileged messages
///Message Number is a unique identifier assigned to every privileged message sent to server.
///Acknowledgement of message delivery is confirmed using Message number
@interface PGPrivilegedSerializable : PGSerializable
{
	int mMessageNumber;
};

@property (nonatomic) int messageNumber;

///Reads message  Number from the byte stream
-(void) read:(PGByteArrayReader*) byteArrayReader;
///Writes message number on the byte stream
-(void) write:(PGByteArrayWriter*) byteArrayWriter;

///Indicates if the message is privileged
-(BOOL) isPrivileged;
///Indicates if the message can be sent to server on any available connection
///this is obsolete and can be removed.
-(BOOL) isGlobal;
///Indicates if the message resend time need to be picked up from global configuration 
-(BOOL) isBlocked;
@end

///Generic class representing server string information. It contains the literal Id present in either static language pack or the
///dynamic language pack sent by server to client. It also contains the all replaceable parameters in the literal
@interface PGStringEx : NSObject
{
	int mLiteralId;
	NSMutableArray* mParameterValues;
	bool mIsLanguagePackElement;
};
	
@property (nonatomic) int literalId;
@property (nonatomic, retain) NSMutableArray *parameterValues;
@property (nonatomic) bool isLanguagePackElement;

- (id) initWithLiterlID:(int) lId
		 parameterArray:(NSMutableArray*) parameterArray
			isLPElement:(bool)isLPElement;
- (NSString*) ToString;
@end
