/******************************************************************************/
/**
 ** \file PGConnectionManager.h
 **
 **	This class manages all the sockets. Primary responsibility of this class is to provide communication channel with server.
 ** It provides the functionality of registering peers on to domain specific socket and manages the peer messaging on the same socket.
 ** It maintains the map of available domains and URLs and also provides the client of this class to specify maximum no. of peers to be 
 ** supported on single socket connection.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 *******************************************************************************/

#import "PGConnectionManagerProtocols.h"
#import "PGSocket.h"
#import "PGMessageSenderReceiver.h"

@interface PGMobConnectionManager : NSObject <PGConnectionManaging, PGSocketDelegate> {

	///Map of domain ID vs. server IP.
	NSMutableDictionary* mDomainIDToURLMap;
	
	///Map of peer ID vs. socket pointers
	NSMutableDictionary* mPeerIDToSocketMap;
	
	///Map of socket pointers vs. num peers.
	NSMutableArray* mSockets;
	
	int	mNumPeersPerConnection;
	
	PGMobMessageSenderReceiver* mMessageSenderReceiver;
	
	//Current socket
	PGMobSocket* mCurrentSocket;
	BOOL mCertificatesValidationEnabled;
	
	NSMutableArray* mCertificatesList;
}

@property (nonatomic, assign) BOOL certificatesValidationEnabled;
@property (nonatomic, retain) PGMobMessageSenderReceiver* messageSenderReceiver;
@property (nonatomic, retain) NSMutableArray* sockets;
@property (nonatomic, retain) NSMutableDictionary* peerIDToSocketMap;
@property (nonatomic, retain) PGMobSocket* socket;
@property (readonly)PGMobSocket *currentSocket;

+ (PGMobConnectionManager*)sharedManager;

///This function specified URL corresponding to play/real domain.
-(void) setDomainURL:(NSString*) serverIP
			  domain:(int) domainID;

-(void) addPeer:(int) peerID
      forDomain:(int) domainID
    inputStream:(NSInputStream* ) inputStream
   outputStream:(NSOutputStream* ) outputStream
   proxyHost:(NSString* ) proxyHost
   proxyPort:(NSUInteger) proxyPort;


-(void) removePeer:(int) peerID
		 forDomain:(int) domainID;

///This function allows individual products to specifies the no. of peers that a single socket can support.
-(void) setNumPeersOnSingleConnection:(int) numberOfPeers;

-(NSString*) getDomainURL:(int) domainID;

///This function the socket corresponding to the receiverID and sends the bytestream to the server.
///It ensures that any message is sent to server only after PGhandshake is successfully performed with server.
-(BOOL) sendBytesToServer:(NSData*) data
			   receiverID:(int) receiverID;

///This function sends the message to server on the specified socket.
///It ensures that any message is sent to server only after PGhandshake is successfully performed with server.
-(BOOL) sendBytesToServer:(NSData*) data
			   receiverID:(int) receiverID 
				 onSocket:(int) socketID;

-(BOOL) sendHandShakeBytesToServer:(NSData*) data
						receiverID:(int) receiverID
						  onSocket:(int) socketID;

///Closes all socket connection, it sends the logout message to server. However does not explicitly disconnects the socket.
-(void) closeAllConnections:(BOOL) sendLogout;

///This function retains all the socket objects in the memory however it closes the physical socket connection.
-(void) disconnectAllSockets;

///This function reconnects all the existing socket objects in memory.
-(void) reconnectAllSockets;

///This function used for reconnect particular socket for a domain
- (void) reconnectSocketForDomain:(int) domainID;

-(void) handleHandShakeReceived:(int) responseID
					   domainID:(int) domainID;

///Get the domain ID corresponding to the socket ID provided.
-(int) getDomainIDForSocket:(int) socketID;

///Get the available socket ID corresponding to the domain ID provided.
-(int) getSocketIdForDomain:(int) domainID;

///Get Domain for peer ID
-(int) getDomainIDForPeer:(int) peerID;

///remove the socket, if no peers are referering it.
-(void) removeSocketIfUnUsed:(int) socketID;

-(NSString*) getIPForSocketId:(int) socketID;
@end
