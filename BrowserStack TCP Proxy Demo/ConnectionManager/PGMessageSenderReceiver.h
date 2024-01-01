/******************************************************************************/
/**
 ** \file PGMessageSenderReceiver.h
 **
 **	Primary responsibility of this class is to send and receive messages to/from server. 
 ** This component abstracts the byte stream communication protocol and presents the client with object C objects.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 *******************************************************************************/


#import "PGConnectionManagerProtocols.h"
#import "PGByteArrayReader.h"

@class PGMobMessageSenderReceiver;
@class PGMobConnectionManager;


@interface PGMobMessageSenderReceiver : NSObject <PGServerMessageSending, PGByteArrayReaderDelegate>{
	
	PGMobConnectionManager* mConnectionManager;
}

-(id) initWithConnectionManager:(PGMobConnectionManager*) connectionManager;
-(void) receiveMessageFromServer:(NSData*) byteStream
						socketID:(int) socketID ;

@end
