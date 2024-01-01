/******************************************************************************/
/**
 ** \file PGConnectionManagerProtocols.h
 **
 **	Interface class for ConnectionManager, exposing only the required functionality to game clients
 **	Provides interface for adding and removing of peers, setting the max number of peers per connection
 **	Querying about the peer and socket connectivity and its domain info. 
 **	Peers connected on the current socket. **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 *******************************************************************************/

#import <Foundation/Foundation.h>


// Domain Ids
#define DOMAIN_REAL	0
#define DOMAIN_PLAY	1
#define DOMAIN_SOCIAL 2
#define DOMAIN_NG_POKERCRM 3

// Connection status
#define	SOCKET_NOT_CONNECTED 0
#define	SOCKET_CONNECTED 1
#define SOCKET_INTERNET_DELAYS 2
#define SOCKET_SPEED 3
#define SOCKET_PGHANDSHAKE_SUCCESS 4

@protocol PGConnectionManaging

///This function verifies if the socket already exists for the specified domainID.
///In case it does exists it allocates this socket to the specified peerID
///In case the socket doesn't exist for the given domain ID, it creates a new socket.
///Before allocating the socket to the peer, function verifies the max no. of peers supported by a single socket.
-(void) addPeer:(int) peerID
		 forDomain:(int) domainID;

///Removes the peer from the socket. In case peer count for a socket comes down to 0, then socket is closed.
-(void) removePeer:(int) peerID
	  forDomain:(int) domainID;

///This function allows individual products to specifies the no. of peers that a single socket can support.
-(void) setNumPeersOnSingleConnection:(int) numberOfPeers;

///Specifies the state of the socket.
-(void) getPeerConnectionState:(int) peerID
						  data:(NSMutableDictionary*) stateInformation;

//TODO: Suyash - uncomment these functions when required.
//-(BOOL) isPeerConnected:(int) peerID;
//-(BOOL) isSocketConnected:(int) peerID;
//-(int) getDomainOfPeer:(int) peerID;
//-(void) getPeersOnCurrentSocket:(NSArray*) peerIDs;

@end



/*!
 * BRIEF CLASS DESCRITPION:
 * -----------------------
 *	Interface for sending of messages from PG client 
 *  
 * DETAILED CLASS DESCRIPTION:
 * --------------------------
 *	Interface for sending message to the server as PGSerializable to a particular receiver on server
 *
 *
 * REMARKS:
 * -------
 * 
 * 
 * ALSO SEE:
 * --------
 *	ServerMessageSender
 *
 */

#import "MessageBaseClasses.h"

@protocol PGServerMessageSending

///Method to send message to specific receiver ID on the server.
-(void) sendMessageToServer:(PGSerializable*) message
				 receiverID:(int) receiverID;

///Method to send message to receiver ID '0' on the server with DomainID.
-(void) sendMessageToServer:(PGSerializable*) message
				 receiverID:(int) receiverID
				   onDomain:(int) domainId;

///Method to send message to server on specific socket.
-(void) sendMessageToServer:(PGSerializable*) message
				 receiverID:(int) receiverID
				   onSocket:(int) socketID;

///Method to send handshake message to server. Receiver ID should be always 0(Lobby)
-(void) sendHandShakeMessageToServer:(PGSerializable*) message
						  receiverID:(int) receiverID 
							onSocket:(int) socketID;

//This method is used for russian app
- (BOOL)isMessageSentToServer:(PGSerializable*) message
                   receiverID:(int) receiverID
                     onDomain:(int) domainId;

@end


#pragma mark -
#pragma mark Protocol to be implemented by the client of this framework.

@protocol PGMessageFactory

-(PGSerializable*) messageObjectForClassID:(int) classID;

@end

#pragma mark -

@protocol PGMessageFactoryRegistration

- (void)registerFactory:(id<PGMessageFactory>)factory;
#if TARGET_MAC
#else
- (NSMutableArray *) factory;
#endif
@end


#define PGSocketConnectedNotificationName  @"PGPokerSocketConnectedNotificationName"
#define PGSocketDisConnectedNotificationName  @"PGPokerSocketDisConnectedNotificationName"
#define PGSocketInvalidSSLCertificates @"PGSocketInvalidSSLCertificates"
