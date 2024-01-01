/**
 ** \file PGMessageSenderReceiver.m
 **
 **	Primary responsibility of this class is to send and receive messages to/from server. 
 ** This component abstracts the byte stream communication protocol and presents the client with object C objects.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 ** Author : Suyash Motarwar
 *******************************************************************************/

#import "PGMessageSenderReceiver.h"
#import "PGByteArrayReader.h"
#import "PGMessageFrame.h"
#import "PGConnectionManager.h"
#import "PGMessageFactory.h"
#import "PGPrivilegedMessageManager.h"
//#import "PGPrivilegedMessageManager.h"

#define PGServerMessageNotificationName  @"PGServerMessageNotificationName"

static BOOL kPrintNSLog = YES;
@implementation PGMobMessageSenderReceiver


- (id) init
{
	self = [super init];
	if (self != nil) {
		self = [self initWithConnectionManager:nil];
	}
	return self;
}

-(id) initWithConnectionManager:(PGMobConnectionManager*) connectionManager;
{
	  

	self = [super init];
	if (self != nil) {
		mConnectionManager = [connectionManager retain];
	}
	return self;
}

- (void) dealloc
{
	  

	[mConnectionManager release];
	[super dealloc];
}

-(void) receiveMessageFromServer:(NSData*) byteStream
						socketID:(int) socketID {
	
	PGByteArrayReader* byteArrayReader = [[PGByteArrayReader alloc] initWithByteArray:(uint8_t*)[byteStream bytes]
																				length:[byteStream length]] ;
	[byteArrayReader setDelegate:self];
	
	PGMobMessageFrame* messageFrame = [[PGMobMessageFrame alloc] init];
	[messageFrame read:byteArrayReader];
    int receiverId = [messageFrame ReceiverId];

	PGPrivilegedSerializable* messageObject = (PGPrivilegedSerializable*) [byteArrayReader getObjectForClassID:[messageFrame ClassId]];
    [byteArrayReader release];
    [messageFrame release];
	
	if( messageObject ) {
		if( [messageObject messageNumber] > 0) {
			if( [[PGMobPrivilegedMessageManager sharedManager] isMessageAlreadyCached:[messageObject messageNumber]] ) {
				//In case response to privileged message is received for the first time then the original request message 
				//must be in the privileged queue, remove this message from the queue and process the response.
				[[PGMobPrivilegedMessageManager sharedManager] removeAcknowledgedMessage:[messageObject messageNumber]];
			}
			else {
				//This condition applies in remote scenario as described below
				//Privileged message is sent to server
				//Client is waiting for the response and doesn't receive the response in stipulated time.
				//Client resends the message to server
				//While client is re-sending the message, server in the background responds to original request.
				//Server receives the message again and responds again to same request. 
				//So effectively, fot the same client request server has sent the response twice.

				//Ignore the current message as it is already processed.
//				PGERROR(@"Received the already processed message.");
				return;
			}
		}
		
		if( [messageObject isCompositeMessage] == NO)
		{
			NSMutableDictionary* messages = [[NSMutableDictionary alloc] init];
			[messages setObject:[NSNumber numberWithInt:receiverId] forKey:@"ReceiverID"];
			[messages setObject:NSStringFromClass([messageObject class]) forKey:@"MessageName"];
			[messages setObject:messageObject forKey:@"RepresentedObject"];
			[messages setObject:[NSNumber numberWithInt:socketID] forKey:@"SocketID"];
			
			if(kPrintNSLog)NSLog(@"Message Received from Server = %@", [messageObject description] );
			[[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)PGServerMessageNotificationName
																object:self
															  userInfo:messages];
            [messages release];
			
			
			NSString *logMessage = [NSString stringWithFormat:@"Message Received from Server = %@", [messageObject description]];	
			if(kPrintNSLog)NSLog(@"%@",logMessage);
			//PGDEBUG(logMessage);

		}
		else
		{			
			if(kPrintNSLog)NSLog(@"Composite Message Received from Server Start = %@", [messageObject description] );
			
			NSMutableArray* messages = [messageObject messages];
			if( messages )
			{
				for(id object in messages)
				{
					PGSerializable* msg = (PGSerializable*) object;
					if( msg )
					{
						NSMutableDictionary* messages = [[NSMutableDictionary alloc] init];
						[messages setObject:[NSNumber numberWithInt:receiverId] forKey:@"ReceiverID"];
						[messages setObject:NSStringFromClass([msg class]) forKey:@"MessageName"];
						[messages setObject:msg forKey:@"RepresentedObject"];
						[messages setObject:[NSNumber numberWithInt:socketID] forKey:@"SocketID"];
                        // break here
					if(kPrintNSLog)NSLog(@"Message Received from Server = %@", [msg description] );
						
						[[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)PGServerMessageNotificationName
																			object:self
																		  userInfo:messages];
                        [messages release];

					}
				}
			}
			if(kPrintNSLog)NSLog(@"Composite Message Received from Server End = %@", [messageObject description] );
			NSString *logMessage = [NSString stringWithFormat:@"Composite Message Received from Server = %@", [messageObject description]];	
			//PGDEBUG(logMessage);
			
		}
		
	}
}

-(NSData*) convertMessageToByteStream:(PGSerializable*) message
						   receiverID:(int) receiverID{
    NSLog(@"BrowserStackLog : In convertMessageToByteStream");
	
	[message setTopLevelMessage:YES];
	
	PGByteArrayWriter* byteArrayOfObject = [[PGByteArrayWriter alloc] init];
	
	//Write frame of the object
	[byteArrayOfObject putObject:message];
	
	PGByteArrayWriter* byteArrayOfFrame = [[PGByteArrayWriter alloc] init];
	[byteArrayOfFrame autorelease];
	PGMobMessageFrame* outMessageFrame = [[PGMobMessageFrame alloc] initWithLength:[byteArrayOfObject getSize]
																	  classId:[message classID] 
																   receiverId:receiverID];
	
	[outMessageFrame write:byteArrayOfFrame];
    [outMessageFrame release];
	[byteArrayOfFrame write:[byteArrayOfObject bytes]
					 length:[byteArrayOfObject getSize]];
    
    [byteArrayOfObject release];
	
	NSData* byteStream = [NSData dataWithBytes:[byteArrayOfFrame bytes]
										length:[byteArrayOfFrame getSize]] ;
	
	return byteStream;
	
}

-(void) sendMessageToServer:(PGSerializable*) message
				 receiverID:(int) receiverID{
	
	[[PGMobPrivilegedMessageManager sharedManager] cacheIfPrivilegedMessage:message receiverID:receiverID domainID:-1];
	NSData* byteStream = [self convertMessageToByteStream:message 
											   receiverID: receiverID];
	
	NSString *logMessage = [NSString stringWithFormat:@"Sent message to server - %@", [message description]];
	if(kPrintNSLog)NSLog(@"%@",logMessage);

//	PGDEBUG(logMessage);

	[mConnectionManager sendBytesToServer:byteStream receiverID:receiverID];
	
}

///Method to send message to receiver ID on the server with DomainID.
-(void) sendMessageToServer:(PGSerializable*) message
				 receiverID:(int) receiverID
				   onDomain:(int) domainId {
	
	int socketId = [mConnectionManager getSocketIdForDomain:domainId];
	if (socketId < 0) {
		if (domainId == 0) {
			[mConnectionManager addPeer:-100 forDomain:domainId];
		} else if (domainId == 1) {
			[mConnectionManager addPeer:-200 forDomain:domainId];
		}
		
		[[PGMobPrivilegedMessageManager sharedManager] cacheIfPrivilegedMessage:message
																  receiverID:receiverID 
																	domainID:domainId];
		return;
	}
	
	[[PGMobPrivilegedMessageManager sharedManager] cacheIfPrivilegedMessage:message
															  receiverID:receiverID 
																domainID:domainId];

	NSData* byteStream = [self convertMessageToByteStream:message 
											   receiverID:receiverID];
	
	int messageNumber = [((PGPrivilegedSerializable*) message) messageNumber];
	NSString *logMessage = [NSString stringWithFormat:@"Sent message to server - %@, Message No. - %d, Socket ID - %d", [message description], messageNumber, socketId];
	if(kPrintNSLog)NSLog(@"%@",logMessage);
	//PGERROR(logMessage);
	
	[mConnectionManager sendBytesToServer:byteStream receiverID:receiverID onSocket:socketId];
	
}

- (BOOL)isMessageSentToServer:(PGSerializable*) message
                 receiverID:(int) receiverID
                   onDomain:(int) domainId {
    
    int socketId = [mConnectionManager getSocketIdForDomain:domainId];
    if (socketId < 0) {
        if (domainId == 0) {
            [mConnectionManager addPeer:-100 forDomain:domainId];
        } else if (domainId == 1) {
            [mConnectionManager addPeer:-200 forDomain:domainId];
        }
        
        [[PGMobPrivilegedMessageManager sharedManager] cacheIfPrivilegedMessage:message
                                                                  receiverID:receiverID
                                                                    domainID:domainId];
        return NO;
    }
    
    [[PGMobPrivilegedMessageManager sharedManager] cacheIfPrivilegedMessage:message
                                                              receiverID:receiverID
                                                                domainID:domainId];
    
    NSData* byteStream = [self convertMessageToByteStream:message
                                               receiverID:receiverID];
    
    int messageNumber = [((PGPrivilegedSerializable*) message) messageNumber];
    NSString *logMessage = [NSString stringWithFormat:@"Sent message to server - %@, Message No. - %d, Socket ID - %d", [message description], messageNumber, socketId];
    if(kPrintNSLog)NSLog(@"%@",logMessage);
    //PGERROR(logMessage);
    
    return [mConnectionManager sendBytesToServer:byteStream receiverID:receiverID onSocket:socketId];
}

-(void) sendMessageToServer:(PGSerializable*) message
				 receiverID:(int) receiverID
				   onSocket:(int) socketID {
	
	[[PGMobPrivilegedMessageManager sharedManager] cacheIfPrivilegedMessage:message receiverID:receiverID domainID:-1];
	
	NSData* byteStream = [self convertMessageToByteStream:message 
											   receiverID: receiverID];

	int messageNumber = [((PGPrivilegedSerializable*) message) messageNumber];
	NSString *logMessage = [NSString stringWithFormat:@"Sent message to server - %@, Message No. - %d, Socket ID - %d", [message description], messageNumber, socketID];	
	//PGERROR(logMessage);

	[mConnectionManager sendBytesToServer:byteStream receiverID:receiverID onSocket:socketID];
	
}

-(void) sendHandShakeMessageToServer:(PGSerializable*) message
						  receiverID:(int) receiverID 
							onSocket:(int) socketID {
    NSLog(@"BrowserStackLog : In sendHandShakeMessageToServer");
	
	[[PGMobPrivilegedMessageManager sharedManager] cacheIfPrivilegedMessage:message receiverID:receiverID domainID:-1];
	
	NSData* byteStream = [self convertMessageToByteStream:message 
											   receiverID: receiverID];

	NSString *logMessage = [NSString stringWithFormat:@"BrowserStackLog : Sent Handshake message to server - %@", [message description]];
//	PGDEBUG(logMessage);

	[mConnectionManager sendHandShakeBytesToServer:byteStream receiverID:receiverID onSocket:socketID];
	
}



-(id) createMessageObject:(PGByteArrayReader*) sender
				  classID:(int) classID
{
	return [[PGMessageFactory sharedInstance] messageObjectForClassID:classID];
}

@end
