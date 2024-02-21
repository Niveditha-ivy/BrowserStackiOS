/******************************************************************************/
/**
 ** \file PGConnectivityController.m
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
 ** Author: Suyash Motarwar
 *******************************************************************************/


#import "PGConnectivityController_iOS.h"
#import "PGConnectionManagerAccessor.h"
#import "CommonMessages.h"

#define PGSocketConnectedNotificationName  @"PGPokerSocketConnectedNotificationName"
#define ARA_FILENAME @"ara_lang_pack"
#define GRA_FILENAME @"gra_lang_pack"

static PGConnectivityController_iOS* sConnectivityController;
static int currentCSIndex = 0;

@interface PGConnectivityController_iOS ()

- (void)killReconnectSocketTimer;
- (void)initiateReconnectTimer;
- (void)handleReconnectSocketTimer: (NSTimer *)aTimer ;
- (void)sendHandShakeMessage: (NSNumber*) socketID;
- (void)killInitialSocketConnectionTimer;
- (void)killDisconnectionHandshakeResetTimer;
- (void)handleDisconnectionHandshakeResetTimer: (NSTimer *)aTimer;
//- (NSString *) macaddress;
@end


//TODO: Suyash - Cache the last port in user defaults
//TODO: Suyash - Show the health page after 2 minutes of connection retries
//TODO: Suyash - After 2 minutes of disconnect, send the handshake Init

@implementation PGConnectivityController_iOS

@synthesize sessionKey = mSessionKey;
@synthesize encodedSSOKey = mEncodedSSOKey;

- (id) init
{
    NSLog(@"BrowserStackLog : In PGConnectivityController_iOS init Method");
	self = [super init];
	if (self != nil) {
		
		mMessageSender = [PGConnectionManagerAccessor messageSender];
		id<PGMessageFactoryRegistration> masterMessageFactory = [PGConnectionManagerAccessor messageFactory];
				
//		PGARAMessageFactory* araMsgFactory = [[PGARAMessageFactory alloc] init];
//		[masterMessageFactory registerFactory: araMsgFactory];
//		[araMsgFactory release];

		
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(onSocketConnection:) 
													 name:(NSString *)PGSocketConnectedNotificationName 
												   object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(onSocketDisconnection:) 
													 name:(NSString *)PGSocketDisConnectedNotificationName 
												   object:nil];
		
//		[[NSNotificationCenter defaultCenter] addObserver:self 
//												  selector:@selector(handleLoginSuccessUserProfile:) 
//													  name:@"PGLoginSuccessUserProfileNotification" 
//													object:nil];		
				
		mFirstConnection = YES;
        mSocialFirstConnection = YES;
        mNonGamingFirstConnection = YES;
		mInitiateReconnectTimer = YES;
	}
	return self;
}

-(void) showLoginScreenAndLogoutUser
{
    [self showLoginViewControllerSilently];
    [self doSilentLogout];
}

-(void) showLoginViewControllerSilently
{
    if([[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(showLoginViewControllerSilently)]) {
        [[[UIApplication sharedApplication] delegate] performSelector:@selector(showLoginViewControllerSilently)];
    }
}

-(void) doSilentLogout
{
    if([[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(doSilentLogout)]) {
        [[[UIApplication sharedApplication] delegate] performSelector:@selector(doSilentLogout)];
    }
}

-(void) activate {
    
}
-(void) deactivate {
    mFirstConnection = YES;
//    [mSessionKey release];
    mSessionKey = nil;
    
    mNonGamingFirstConnection = YES;
//    [mNonGamingSessionKey release];
    mNonGamingSessionKey = nil;
}

- (void) dealloc
{
	[self killDisconnectionHandshakeResetTimer];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
//	[[PGNotificationManager sharedManager] removeObserver:self];
//	[mEncodedSSOKey release];
//	[mServerIP release];
//	[mSessionKey release];
//    [mSocialSessionKey release];
//    [mNonGamingSessionKey release];
//	[self killReconnectSocketTimer];
	[self killInitialSocketConnectionTimer];
	
//	[super dealloc];
}

//Todo,Satya, shoule be moved to App
- (void) showConnectionSplashScreen
{

}

- (void) initiateConnection:(NSString* )serverIP
               proxyHost:(NSString *) proxyHost proxyPort:(NSUInteger) proxyPost
{
    NSLog(@"BrowserStackLog : In initiateConnection with serverIP - %@", serverIP);
	mServerIP = [serverIP retain];
	
	PGMobConnectionManager* connectionManager = [PGMobConnectionManager sharedManager];
	
    connectionManager.certificatesValidationEnabled = NO;
	[connectionManager setDomainURL:mServerIP domain:-1];
    NSLog(@"BrowserStackLog : mServerIP - %@, Calling addPeer method", mServerIP);

    [connectionManager addPeer:0 forDomain:-1 proxyHost:proxyHost proxyPort:proxyPost];
	
	
	//Start initial connection timer
//	[self killInitialSocketConnectionTimer];
//	mInitialSocketConnectionTimer = [[PGMobTimer scheduledTimerWithTimeInterval:5
//																	  target:self
//																	selector:@selector(handleInitialSocketConnectionTimer:)
//																	userInfo:nil repeats:YES] retain];
	
	mSocketConnectionStartTime = [[NSDate date] timeIntervalSince1970];
}

- (void)sendCRMNotifServHandshake:(NSNumber *)socketID {
//    PGSHandShake* hs = [[PGSHandShake alloc] init];
//    [hs setFrontendId:@"pp"];
//    [hs setARABuildNumber:9999];//Some big no.
//    [hs setGRABuildNumber:9999];//Some big no.
//    [hs setProductId:@"POKERCRM"];
//    [hs setPassword:@""];
//
//    NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
//    [hs setType:HANDSHAKE_INIT_CONNECTION];
//
//    PGSUserProfile* userProfile = [[PGAccountProfile sharedInstance] accountProfile];
//    if(userProfile) {
//        [hs setEncProfile:[userProfile encProfile]];
//        if (!mNonGamingFirstConnection) {
//            [hs setType:HANDSHAKE_RELOGIN];
//            [hs setSessionKey:mNonGamingSessionKey];
//        }
//        [hs setLoginId:[userProfile loginId]];
//        [attributes setObject:[userProfile accountName] forKey:@"ACCOUNT_NAME"];
//        [attributes setObject:[[PGAccountProfile sharedInstance] gTID] forKey:@"GTID"];
//        [attributes setObject:[[PGAccountProfile sharedInstance] gTID] forKey:@"SSO_KEY"];
//    }
//
//    [attributes setObject:@"IN" forKey:@"CID"];
//    [attributes setObject:@"NS Default" forKey:@"CONNECTION_NAME"];
//    [attributes setObject:@"POKER" forKey:@"NS_INVOKER_PRODUCT"];
//    [attributes setObject:[[PGConnectionLocale sharedInstance] getServerSupportedLocale] forKey:@"LOCALE"];
//    [attributes setObject:[[PGConnectionLocale sharedInstance] getClientSupportedLocale] forKey:@"SL"];
//    NSString *appVersion = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    [attributes setObject:appVersion forKey:@"APP_VERSION"];
//
//    PGSExtendedAttribs* extendedAttributes = [[PGSExtendedAttribs alloc] init];
//    [extendedAttributes setExtendedAttribs:attributes];
//
//    NSMutableArray* messageVector = [NSMutableArray array];
//    [messageVector addObject:extendedAttributes];
//    [extendedAttributes release];
//
//    [hs setMessageVector:messageVector];
//
//    [mMessageSender sendHandShakeMessageToServer:hs
//                                      receiverID:0
//                                        onSocket:[socketID intValue]];
//    [hs release];
}
-(void)sendSocialDomainHandShake:(NSNumber*) socketID{
    
    //    NSLog(@"sendSocialDomainHandShake on Socket:%d", [socketID intValue]);
    
//    PGSHandShake* hs = [[PGSHandShake alloc] init];
//    [hs setFrontendId:@"pp"];
//    [hs setARABuildNumber:9999];//Some big no.
//    [hs setGRABuildNumber:9999];//Some big no.
//    [hs setProductId:@"NOTIFICATIONSERVERSERVICE"];
//    [hs setPassword:@""];
//
//
//    NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
//    [hs setType:HANDSHAKE_INIT_CONNECTION];
//
//    PGSUserProfile* userProfile = [[PGAccountProfile sharedInstance] accountProfile];
//    if( userProfile )
//    {
//        [hs setEncProfile:[userProfile encProfile]];
//        if (!mSocialFirstConnection) {
//            [hs setType:HANDSHAKE_RELOGIN];
//            [hs setSessionKey:mSocialSessionKey];
//        }
//        [hs setLoginId:[userProfile loginId]];
//        [attributes setObject:[userProfile loginId] forKey:@"ACCOUNT_NAME"];
//        [attributes setObject:[[PGAccountProfile sharedInstance] gTID] forKey:@"GTID"];
//        [attributes setObject:[[PGAccountProfile sharedInstance] gTID] forKey:@"SSO_KEY"];
//    }
//
//
//    [attributes setObject:@"MC" forKey:@"CID"];
//    [attributes setObject:@"NS Default" forKey:@"CONNECTION_NAME"];
//    [attributes setObject:@"POKER" forKey:@"NS_INVOKER_PRODUCT"];
//
//    [attributes setObject:[[PGConnectionLocale sharedInstance] getServerSupportedLocale] forKey:@"LOCALE"];
//    [attributes setObject:[[PGConnectionLocale sharedInstance] getClientSupportedLocale] forKey:@"SL"];
//    [attributes setObject:[[PGFEConfiguration sharedInstance] getSysIniValueForKey:@"BRAND_ID"] forKey:@"BRAND_ID"];
//    [attributes setObject:[[PGMobConnectionManager sharedManager] getIPForSocketId:[socketID intValue]] forKey:@"ServerIP"];
//
//    PGSExtendedAttribs* extendedAttributes = [[PGSExtendedAttribs alloc] init];
//    [extendedAttributes setExtendedAttribs:attributes];
//
//    NSMutableArray* messageVector = [NSMutableArray array];
//    [messageVector addObject:extendedAttributes];
//    [extendedAttributes release];
//
//    [hs setMessageVector:messageVector];
//
//    [mMessageSender sendHandShakeMessageToServer:hs
//                                      receiverID:0
//                                        onSocket:[socketID intValue]];
//    [hs autorelease];
    
}
- (void)onSocketConnection: (NSNotification *) aNotif
{
    NSLog(@"BrowserStackLog : In socketConnected");
    NSTimeInterval timeStamp = (([NSDate date].timeIntervalSince1970) * 1000);
    NSString *timeStampString = [NSString stringWithFormat:@"%.0f", timeStamp];
//    PGSUserProfile* userProfile = [[PGAccountProfile sharedInstance] accountProfile];
    
    NSNumber* socketID = [[aNotif userInfo] objectForKey:@"SocketID"];
    
    PGMobSocket *theSocket = [[aNotif userInfo] objectForKey:@"RepresentedObject"];
    
    [self killDisconnectionHandshakeResetTimer];
	
    NSLog(@"BrowserStackLog : Sending HandShake Message....");
	[self sendHandShakeMessage:socketID];
}

- (NSMutableArray*) getPeersOnSocket:(NSNumber*) socketID
{
	//Get peers on the given socket.
	NSMutableArray* peersOnSocket = [NSMutableArray array];
	NSMutableDictionary* peerIDToSocketMap = [[PGMobConnectionManager sharedManager] peerIDToSocketMap];
	
	PGMobSocket* socketForPeer = nil;
	for(id key in peerIDToSocketMap)
	{				
		socketForPeer = [peerIDToSocketMap objectForKey:key];
		if ([socketID intValue] == [socketForPeer socketID]) {
			[peersOnSocket addObject:key];
		}
	}
	
	return peersOnSocket;
}

- (void)onSocketDisconnection: (NSNotification *)aNotif
{
	NSNumber* socketID = [[aNotif userInfo] objectForKey:@"SocketID"];
	
    NSTimeInterval timeStamp = (([NSDate date].timeIntervalSince1970) * 1000);
    NSString *timeStampString = [NSString stringWithFormat:@"%.0f", timeStamp];

    
    PGMobSocket *theSocket = [[aNotif userInfo] objectForKey:@"RepresentedObject"];

	NSMutableArray* peersOnSocket = [self getPeersOnSocket:socketID];
	
	
	for(id peerID in peersOnSocket)
	{	
		NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
		[dict setObject:peerID forKey:@"PeerID"];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"PeerDisconnected" //TODO: Suyash - Do not hardcode the notification name.
															object:self
														  userInfo:dict];
		[dict release];
	}
	
    
	//Initiate reconnection timer
	if (mInitiateReconnectTimer)
	{
		[self initiateReconnectTimer];
		mInitiateReconnectTimer = NO;
	}
}

- (void)sendHandShakeMessage: (NSNumber*) socketID
{
    NSLog(@"BrowserStackLog : In sendHandShakeMessage....");
    PGSHandShake* hs = [[PGSHandShake alloc] init];
    [hs setFrontendId:@"pp"];
    [hs setARABuildNumber:9999];//Some big no.
    
    
    
    [hs setGRABuildNumber:9999];//Some big no.
    [hs setProductId:@"POKER"];
    
    NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
    
    [hs setType:1];
    
    
    
    [attributes setObject:@"0" forKey:@"STATIC_MD5"];
    
    [attributes setObject:@"446987de28525fe534610469ffed92ca" forKey:@"ARA_INI_MD5"];
    [attributes setObject:@"c2ee7e35968e440469f5f5e1abae1618" forKey:@"GRA_INI_MD5"];
    [attributes setObject:@"2f12ebb277e71399fc38347c33f1a1dc" forKey:@"SYS_INI_MD5"];
    [attributes setObject:@"IN" forKey:@"CID"];
    [attributes setObject:@"1" forKey:@"ARA_PROTOCOL_VERSION"];
    [attributes setObject:@"1" forKey:@"GRA_PROTOCOL_VERSION"];
    [attributes setObject:@"en_LV" forKey:@"LOCALE"];
    [attributes setObject:@"en_US" forKey:@"SL"];
    
    [attributes setObject:@"0001-0676-0000-0000-0000-0000" forKey:@"CPU_SERIAL_NO"];
    [attributes setObject:@"1750F12B-F248-4BE1-97A3-A3A9E49DA0FB" forKey:@"MAC_ADDRESS"];
    [attributes setObject:@"3103059156" forKey:@"VOLUME_SERIAL_NO"];
    [attributes setObject:@"IL" forKey:@"LAUNCH_TYPE"];
    [attributes setObject:@"PARTYPOKER" forKey:@"BRAND_ID"];
    
    
    [attributes setObject:@"India Standard Time" forKey:@"USER_TIME_ZONE_ID"];
    
    [attributes setObject:@"real.partygaming.com.e7new.com" forKey:@"ServerIP"];
    [attributes setObject:@"VC Default" forKey:@"CONNECTION_NAME"];
    
    NSString *channelId = @"IN";
    
    [attributes setObject:channelId forKey:@"CONTAINER_CHANNEL_ID"];
    
    [attributes setObject:[NSString stringWithFormat:@"%d", -1] forKey:@"FX_SNAPSHOT_ID"];
    [attributes setObject:@"FALSE" forKey:@"ADS_LAST_KNOWN_STATE"];
    
    
    NSString *araMD5sum = [[NSUserDefaults standardUserDefaults] objectForKey:@"araen_usMD5sum"];
    [attributes setObject:araMD5sum?araMD5sum:@"" forKey:@"PG_LANGPACK_EN_MD5"];
    NSString *graMD5sum = [[NSUserDefaults standardUserDefaults] objectForKey:@"graen_usMD5sum"];
    [attributes setObject:graMD5sum?graMD5sum:@"" forKey:@"PRODUCT_LANGPACK_EN_MD5"];
    NSString *debugAraGra = [NSString stringWithFormat:@"send the MD5 Sum to server for ara = %@ and gra = %@",araMD5sum,graMD5sum];
    
    PGSExtendedAttribs* extendedAttributes = [[PGSExtendedAttribs alloc] init];
    [extendedAttributes setExtendedAttribs:attributes];
    
    NSMutableArray* messageVector = [NSMutableArray array];
    [messageVector addObject:extendedAttributes];
    [extendedAttributes release];
    
    [hs setMessageVector:messageVector];
    
    [mMessageSender sendHandShakeMessageToServer:hs
                                      receiverID:0
                                        onSocket:[socketID intValue]];
    [hs autorelease];
}


-(void)closeConnections
{
	NSMutableArray* sockets = [[PGMobConnectionManager sharedManager] sockets];
	PGMobSocket* socket = nil;
	for(socket in sockets)
	{
		//Send logout message on specific socket
		PGSLogout *logout = [PGSLogout new];
		[mMessageSender sendMessageToServer:logout receiverID:0 onSocket:[socket socketID]];
		[logout release];
	}
	[[PGMobConnectionManager sharedManager]closeAllConnections:YES];
}


- (void)resetNonGamingConnection
{
    [[PGMobConnectionManager sharedManager] reconnectSocketForDomain:DOMAIN_NG_POKERCRM];
}


-(void)handleDomainMapping:(NSNotification *)pNotification{

	NSDictionary* messages = [pNotification userInfo];
	
	PGSDomainMapping* messageDomainMapping = [messages objectForKey:@"RepresentedObject"];
    NSMutableDictionary* dict = [messageDomainMapping domainMap];
    
    for (id key in dict) {
        NSString* ip = [dict objectForKey:key];
        int domainID = [key intValue];
        [[PGMobConnectionManager sharedManager] setDomainURL:ip domain:domainID];
    }
    
    //TODO: Temp hack until non gaming domain is being supplied by server.
    
    NSString *nonGamingServerIp = [dict objectForKey:[NSString stringWithFormat:@"%d", DOMAIN_NG_POKERCRM]];
    if(!nonGamingServerIp) {
        [[PGMobConnectionManager sharedManager] setDomainURL:[dict objectForKey:[NSString stringWithFormat:@"%d", DOMAIN_REAL]] domain:DOMAIN_NG_POKERCRM];
    }
    
    
    
}





-(void)handleRequestTerminateLoggedOnOtherMachine:(NSNotification *)aNotif {

	mInitiateReconnectTimer = NO;
	
	//Disconnect all the socket to avoid any further communication from the client to server.
	NSMutableArray* sockets = [[PGMobConnectionManager sharedManager] sockets];
	PGMobSocket* socket = nil;
	for (socket in sockets) {		
		[socket disconnect];
	}
	
	[self killReconnectSocketTimer];
	
	[[PGMobConnectionManager sharedManager]closeAllConnections:NO];
	
}




-(void)handleDirectConnectAdvice: (NSNotification *)notification
{
	NSDictionary* messages = [notification userInfo];
	
	PGSDirectConnectAdvice *directConnectAdvice = [messages objectForKey:@"RepresentedObject"];
	
	//Clean up all the sockets before making new connection
	[self closeConnections];
	
	//Initiate a new connection to frontal ip
	[self initiateConnection:[directConnectAdvice directAddress]];
	
}

-(void)handleSSoKeyMsg:(NSNotification *)notification
{
	NSDictionary* messages = [notification userInfo];
	
	PGSSSOKeyMessage* ssoKeyMesg = [messages objectForKey:@"RepresentedObject"];
	
	[self setEncodedSSOKey:[ssoKeyMesg encodedSSOKey]];
	
}

-(void)handleClientIdleModeStarted:(NSNotification*) aNotif{
	
	mInitiateReconnectTimer = NO;
}

-(void)handleClientIdleModeEnded: (NSNotification *) aNotif {
    mInitiateReconnectTimer = YES;
}

#pragma mark -
#pragma mark reconnect methods
- (void)killReconnectSocketTimer{
//	[mReconnectSocketTimer invalidate];
//	[mReconnectSocketTimer release];
//	mReconnectSocketTimer = nil;
}

- (void)killDisconnectionHandshakeResetTimer
{
//	if (mDisconnectionHandshakeResetTimer) {
//        [mDisconnectionHandshakeResetTimer invalidate];
//		[mDisconnectionHandshakeResetTimer release];
//		mDisconnectionHandshakeResetTimer = nil;
//	}
}

-(void) initiateReconnectTimer
{		
	[self killReconnectSocketTimer];
	
	//call the reconnect routine immediate
	[self handleReconnectSocketTimer:nil];
	
	//start the timer to reconnect the socket, if its not connected already.
}

-(void) handleReconnectSocketTimer: (NSTimer *)aTimer 
{
	BOOL areAllSocketsConnected = YES;
	
	NSMutableArray* sockets = [[PGMobConnectionManager sharedManager] sockets];
	PGMobSocket* socket = nil;
	for (socket in sockets) 
	{		
		if ([socket socketState] == SOCKET_NOT_CONNECTED)
		{
			areAllSocketsConnected = NO;			
			[socket reconnect];
		}		
	}		
	
	if (areAllSocketsConnected) {
		[self killReconnectSocketTimer];
		mInitiateReconnectTimer = YES;
	}
	
	
	
}

-(void) handleDisconnectionHandshakeResetTimer: (NSTimer *)aTimer 
{
	mFirstConnection = YES;
    mSocialFirstConnection = YES;
    mNonGamingFirstConnection = YES;
	mDisconnetionForMoreThan2Minutes = YES;
}

-(void) resetDisconnectionParams
{
    [self handleDisconnectionHandshakeResetTimer:nil];
}

#pragma mark -
#pragma mark Initial Connection methods
- (void)killInitialSocketConnectionTimer{
//	[mInitialSocketConnectionTimer invalidate];
//	[mInitialSocketConnectionTimer release];
//	mInitialSocketConnectionTimer = nil;
}



#pragma mark -
#pragma Non Gaming Domain related

- (void)initiateNonGamingDomainConnection{
    [[PGMobConnectionManager sharedManager] addPeer:-500 forDomain:DOMAIN_NG_POKERCRM];
}



#pragma mark -
#pragma NS Social related
-(void)handleLoginSuccessInitSocialConnection:(NSNotification*)notif {
    NSLog(@"## init social socket connection");
    [[PGMobConnectionManager sharedManager] addPeer:-400 forDomain:DOMAIN_SOCIAL];
}

#pragma mark publicMethods
+ (PGConnectivityController_iOS *)sharedInstance{
    NSLog(@"BrowserStackLog : In PGConnectivityController_iOS shared instance");
	if (sConnectivityController == nil) {
		sConnectivityController = [[PGConnectivityController_iOS alloc] init];
        NSLog(@"BrowserStackLog : In PGConnectivityController_iOS shared instance created");
	}
	return sConnectivityController;
}

@end
