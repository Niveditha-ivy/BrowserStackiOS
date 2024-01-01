/******************************************************************************/
/**
 ** \file PGConnectivityController.h
 **
 **	This class primarily controls connectivity with server, this class has heavy dependency on Connection manager framework.
 ** It mainly performs following tasks
 **	1. Create initial connection with game server.
 **	2. Monitor the sockets, and initiate reconnection if the socket is disconnected.
 **	3. Send the Handshake message to server.
 ** 4. Handle handshake response and set the socket state to "ready to use"
 **	5. Handle the domain mapping
 ** 6. Handles if the same user is logged on from other machine.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 *******************************************************************************/


#import "PGConnectionManagerProtocols.h"
#import "PGConnectionManager.h"

@interface PGConnectivityController_iOS : NSObject {

	id<PGServerMessageSending> mMessageSender;
	
	BOOL	mFirstConnection;
    BOOL    mSocialFirstConnection;
    BOOL    mNonGamingFirstConnection;
	BOOL	mDisconnetionForMoreThan2Minutes;
	NSTimeInterval mSocketConnectionStartTime;
	NSString* mSessionKey;
    NSString* mSocialSessionKey;
    NSString* mNonGamingSessionKey;
	NSString* mEncodedSSOKey;
	
	NSString* mServerIP;
		
	BOOL mHandShakeFailureMessageShown;
	BOOL mHealthPageAlreadyShown;
	BOOL mInitiateReconnectTimer;
}

@property(nonatomic, retain) NSString *sessionKey;
@property(nonatomic, retain) NSString *encodedSSOKey;

+ (PGConnectivityController_iOS *)sharedInstance;

/// This method initiates first connection with game server. 
/// It should not be called for reconnection.
- (void)initiateConnection:(NSString* )serverIP
               inputStream:(NSInputStream* ) inputStream
              outputStream:(NSOutputStream* ) outputStream
              proxyHost:(NSString* ) proxyHost
              proxyPort:(NSUInteger) proxyPost;

- (void)showConnectionSplashScreen;
- (void)closeConnections;

//Social domain related
- (void)initiateNonGamingDomainConnection;
- (void)resetNonGamingConnection;
- (void)closeNonGamingDomainConnection;

- (void)resetDisconnectionParams;

- (void)activate;
- (void)deactivate;


@end
