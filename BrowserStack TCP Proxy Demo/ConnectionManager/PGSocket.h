/******************************************************************************/
/**
 ** \file PGSocket.h
 **
 **  PGSocket is responsible for creating SSL connection with specified server IP and port. It caches the messages on its queue 
 **  and ensures the sequence of messages sent to server.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 *******************************************************************************/
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//TODO: Suyash add disconnection/reconnection handlers.
//TODO: Suyash Add support for fallback to 443 port in case 2147 is not supported by the network.
@class PGMobSocket;


@protocol PGSocketDelegate
@optional
-(void) socketConnected:(PGMobSocket *)socket;
-(void) socketDisconnected:(PGMobSocket *) socket;
/// Method returns the stream of byte with complete frame information and the message object
-(void) receiveBytesFromServer:(PGMobSocket *) socket
					byteStream:(NSData*) bytestream;
@end

@interface PGMobSocket : NSObject <NSStreamDelegate>{

    NSInputStream    *mInputStream;
    NSOutputStream    *mOutputStream;
        
    NSMutableData* mByteStreamFromServer;
    
    NSMutableArray* mOutMessageQueue;
    
    NSString *mServerIP;
    NSString *mServerPort;
    NSString *mproxyHost;
    NSInteger mproxyPort;
    
    id<PGSocketDelegate> delegate;
    
    int mSocketState;
    int    mSocketID;
    int mDomainID;
    int mNumberOfSubscribedPeers;
    int mSocketIdleTime;
    
    NSData* mHandShakeMessageByteStream;
    
    BOOL mIsLeopardOS;
    BOOL mCertificatesValidationEnabled;
    BOOL mCertificatesValidationDone;
    NSMutableArray* mCertificatesList;
    
}

@property(nonatomic, assign) id<PGSocketDelegate> delegate;
@property (nonatomic, retain) NSString *serverIP;
@property (nonatomic, retain) NSString *serverPort;
@property (nonatomic, retain) NSInputStream *InputStream;
@property (nonatomic, retain) NSOutputStream *OutputStream;
@property (nonatomic) int socketID;
@property (nonatomic) int numberOfSubscribedPeers;
@property (nonatomic) int domainID;
@property (nonatomic) int socketState;
@property (nonatomic) int socketIdleTime;
@property (nonatomic, assign) BOOL certificatesValidationEnabled;
@property (nonatomic, retain) NSMutableArray* certificatesList;

///Initiates SSL connection with pre-specified server IP and Port.
-(BOOL) connect:(NSInputStream* ) inputStream
   outputStream:(NSOutputStream* ) outputStream
   proxyHost:(NSString* ) proxyHost
   proxyPort:(NSUInteger) proxyPort;
///Disconnects the SSL connection with server
-(BOOL) disconnect;
///disconnects and connects the existing socket.
-(BOOL) reconnect;

/// Method tries to flush the bytestream immediately
/// In case there are other messages pending to be flushed then it queues the message on the outgoing message queue.
/// Method honours the sequence of call and flushes the object in same order as the call to this method.
-(void) sendDataToServer:(NSData*) byteStream;

///This is a special message as this function doesn not mandate that the socket state should be SOCKET_PGHANDSHAKE_SUCCESS.
-(void) sendHandShakeDataToServer:(NSData*) byteStream;
@end
