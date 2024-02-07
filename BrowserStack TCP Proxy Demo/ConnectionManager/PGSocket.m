/******************************************************************************/
/**
 ** \file PGSocket.m
 **
 **  PGSocket is responsible for creating SSL connection with specified server IP and port. It caches the messages on its queue 
 **  and ensures the sequence of messages sent to server.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 ** Author : Suyash Sharadrao Motarwar on 16/02/11.
 *******************************************************************************/

#import "PGSocket.h"
#import "PGConnectionManagerProtocols.h"
#import <Security/Security.h>

static int sSocketUniqueID = 1;

@implementation PGMobSocket

@synthesize serverIP = mServerIP, serverPort = mServerPort, delegate, socketID = mSocketID, numberOfSubscribedPeers = mNumberOfSubscribedPeers, domainID = mDomainID, InputStream = mInputStream, OutputStream = mOutputStream;
@synthesize socketState = mSocketState, socketIdleTime = mSocketIdleTime;
@synthesize certificatesList = mCertificatesList;
@synthesize certificatesValidationEnabled = mCertificatesValidationEnabled;

# pragma mark -
# pragma mark Private functions

- (void)closeStreams{
    NSLog(@"BrowserStackLog : closeStreams %@", NSThread.callStackSymbols);
	if (mInputStream != nil && mOutputStream != nil)
	{
		mSocketState = SOCKET_NOT_CONNECTED;
		mSocketIdleTime = 0;
        NSLog(@"BrowserStackLog : Reached closeStreams");
		[mInputStream close];
		[mOutputStream close];
		
		[mInputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [mOutputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

#if TARGET_MAC
		[mInputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSModalPanelRunLoopMode];
		[mInputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSEventTrackingRunLoopMode];
		[mOutputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSModalPanelRunLoopMode];
		[mOutputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSEventTrackingRunLoopMode];
#endif
        
		[mInputStream setDelegate:nil];
		[mOutputStream setDelegate:nil];
		[mInputStream release];
		[mOutputStream release];
		mInputStream = nil;
		mOutputStream = nil;
		[mByteStreamFromServer setLength:0];
	//	if (delegate)
//		{
//			[delegate socketDisconnected:self];
//			
//		}
	}
	
}

-(int) ReadTwoByteInt:(int) bytestreamoffset{
	
	int nVal=0;
	
	uint8_t vByte2;
	NSRange range;
	range.location = bytestreamoffset;
	range.length=1;
	[mByteStreamFromServer getBytes:(void*) &vByte2 range:range];
	
	uint8_t vByte1;
	range.location = bytestreamoffset+1;
	range.length=1;
	[mByteStreamFromServer getBytes:(void*) &vByte1 range:range];
	
	nVal = vByte2;
	nVal = nVal << 8; 
	
	nVal = nVal+vByte1;
	
	return nVal;
}

-(int)  ReadThreeByteInt:(int) bytestreamoffset{
	
	int nVal=0;
	
	uint8_t vByte3;
	NSRange range;
	range.location = bytestreamoffset;
	range.length=1;
	[mByteStreamFromServer getBytes:(void*) &vByte3 range:range];
	
	uint8_t vByte2;
	range.location = bytestreamoffset+1;
	range.length=1;
	[mByteStreamFromServer getBytes:(void*) &vByte2 range:range];
	
	uint8_t vByte1;
	range.location = bytestreamoffset+2;
	range.length=1;
	[mByteStreamFromServer getBytes:(void*) &vByte1 range:range];
	
	nVal = vByte3;
	nVal = nVal << 8; 
	
	nVal = nVal + vByte2;
	nVal = nVal << 8; 
	
	nVal = nVal+vByte1;
	
	return nVal;
}

-(int) ReadFourByteInt:(int) bytestreamoffset{
	
	int nVal=0;
	
	uint8_t vByte4;
	NSRange range;
	range.location = bytestreamoffset;
	range.length=1;
	[mByteStreamFromServer getBytes:(void*) &vByte4 range:range];
	
	uint8_t vByte3;
	range.location = bytestreamoffset+1;
	range.length=1;
	[mByteStreamFromServer getBytes:(void*) &vByte3 range:range];
	
	uint8_t vByte2;
	range.location = bytestreamoffset+2;
	range.length=1;
	[mByteStreamFromServer getBytes:(void*) &vByte2 range:range];
	
	uint8_t vByte1;
	range.location = bytestreamoffset+3;
	range.length=1;
	[mByteStreamFromServer getBytes:(void*) &vByte1 range:range];
	
	nVal = vByte4;
	nVal = nVal << 8;
	
	nVal = nVal + vByte3;
	nVal = nVal << 8; 
	
	nVal = nVal + vByte2;
	nVal = nVal << 8; 
	
	nVal = nVal+vByte1;
	
	return nVal;
	
}

-(void) ReadDataOnSocket:(NSInputStream *) stream{
	NSAutoreleasePool *aPool = [[NSAutoreleasePool alloc] init];
	mSocketIdleTime = 0;
	uint8_t buf[1024];
	// If available then read the data from the socket
	if([mByteStreamFromServer length] < 1)
	{
		int nRcvd = [stream read:buf maxLength:1];
		
		if(nRcvd <= 0 ) 
		{
			NSLog(@"Error reading data on socket - header byte");
			return; // some error on socket
		}
		
		[mByteStreamFromServer appendBytes:&buf length:1];
	}
	
	uint8_t headerByte;
	NSRange range;
	range.location = 0;
	range.length=1;
	[mByteStreamFromServer getBytes:(void*) &headerByte range:range];
	
	int lengthOfLength = ((headerByte & 12) >> 2) + 1;
	
	while([mByteStreamFromServer length] < (lengthOfLength)+1/*header byte*/)
	{
		int nRcvd = [stream read:buf maxLength:MIN(sizeof(buf), (lengthOfLength) )];
		if(nRcvd <= 0)
		{
			NSLog(@"Error reading data on socket");
			return;
		}
		[mByteStreamFromServer appendBytes:&buf length:nRcvd];
	}
	
	uint8_t lengthBytes[4];
	int length = 0;
	switch(lengthOfLength) 
	{
		case 1:
			range.location = 1;
			range.length=1;
			[mByteStreamFromServer getBytes:(void*) &lengthBytes range:range];
			length = lengthBytes[0];
			break;
		case 2:
			length = [self ReadTwoByteInt:1];
			break;
		case 3:			
			length = [self ReadThreeByteInt:1];
			break;
		case 4:
			length = [self ReadFourByteInt:1];
			break;
	}
	
	uint8_t version = (uint8_t)((headerByte >> 4) & 7);
	bool receiverIdExists = (headerByte & 2) != 0;
	
	int neededLength = 3 + length; //3 <- classId field length				
	
	int unCompressedSize = 0;
	if(version == 1 || version == 3) 
		unCompressedSize = 2;
	else if(version ==4)
		unCompressedSize = 4;
	
	neededLength = neededLength + unCompressedSize;
	
	if(receiverIdExists) 
		neededLength += 4;
	
	while([mByteStreamFromServer length] < neededLength +1/*header byte*/+lengthOfLength )
	{
		int nRcvd = [stream read:buf maxLength:MIN(sizeof(buf), neededLength +1/*header byte*/+lengthOfLength - [mByteStreamFromServer length])];
		if(nRcvd <= 0)
		{
			NSLog(@"Error reading data on socket - seems big packet");
			return;
		}
		[mByteStreamFromServer appendBytes:&buf length:nRcvd];
	}
	
	//int classId = [self ReadThreeByteInt:1/*header byte*/+lengthOfLength+unCompressedSize];
	//NSString *logMessage = [NSString stringWithFormat:@"Message receive - class ID = %d", classId];	
	//PGDEBUG(logMessage);


	//If the control reaches here it means logical packet is read
	//Make a copy of this packet and pass on the data to generic message handle.
	NSMutableData* byteStreamFromServer = [[mByteStreamFromServer copy] autorelease];
	[mByteStreamFromServer setLength:0];
	
	
	if (delegate != nil) 
	{
		[ delegate receiveBytesFromServer:self byteStream:byteStreamFromServer];
	}
	
	[aPool release];
	
	//Do not add any code here. In case the message handler shows up the modal dialog, 
	//this code would not get executed until the modal dialog is dismissed.
}

-(void) validateServerCertificates:(NSStream *)aStream
{
	NSString* sslPeerName = mServerIP;
    NSString *ipAddress = [mServerIP stringByReplacingOccurrencesOfString:@"." withString:@""];
    if([ipAddress longLongValue] > 0)
    {
        sslPeerName = NULL;
    }
	
	//By default on Mac, the name validation starts with SAN(Subject alernative names). if its not present in the certificate, it will fall back to Common name validation
	
	//For Fr clients, this behavior is leading to a problem in establishing connection with the frontal server, as the name validation is getting failed becuase of
	//server peer name(fullhouse.partypoker.fr) and the SAN(play.partypoker.fr) in the frontal certificate are different.
	//To make it happen, changing the peer name to "play.partypoker.fr"
	if([sslPeerName isEqualToString:@"fullhouse.partypoker.fr"])
	{
		sslPeerName = @"play.partypoker.fr";
	}
	
    SecPolicyRef policy = SecPolicyCreateSSL(YES, (CFStringRef)sslPeerName);
	SecTrustRef trust = NULL;
	CFArrayRef streamCertificates = (CFArrayRef)[aStream propertyForKey:(NSString *) kCFStreamPropertySSLPeerCertificates];
    //rdar://18277509 NSStream propertyForKey:kCFStreamPropertySSLPeerCertificates returns nil certificates
    if(streamCertificates)
    {
        SecTrustCreateWithCertificates(streamCertificates,
                                       policy,
                                       &trust);
        SecTrustSetAnchorCertificates(trust,
                                      (CFArrayRef) mCertificatesList);
        SecTrustResultType trustResultType = kSecTrustResultInvalid;
        OSStatus status = SecTrustEvaluate(trust, &trustResultType);
        if (status == errSecSuccess)
        {
            if(trustResultType != kSecTrustResultProceed && trustResultType != kSecTrustResultUnspecified)//invalid certificates
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)PGSocketInvalidSSLCertificates
                                                                    object:nil];
            }
        }
        else //if there was any failure in creating a trust object
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)PGSocketInvalidSSLCertificates
                                                                object:nil];
        }
    }
    if (trust) {
        CFRelease(trust);
    }
    if (policy) {
        CFRelease(policy);
    }
}


#pragma mark NSStream Delegate implementation

// both input and output streams will trigger these.
- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode{
    NSLog(@"BrowserStackLog : stream NSStream Delegate implementation \n");
    switch(eventCode) 
	{
        case NSStreamEventHasSpaceAvailable:
        {
            NSLog(@"BrowserStackLog : stream NSStreamEventHasSpaceAvailable \n");
			if(NO)
			{
				if(!mIsLeopardOS)
				{
					if(!mCertificatesValidationDone)
					{
						[self validateServerCertificates:stream];
						mCertificatesValidationDone = TRUE;
					}
				}
			}
			[self sendDataToServer:nil];
			break;			
		}
			
		case NSStreamEventHasBytesAvailable:
        {
            NSLog(@"BrowserStackLog : stream NSStreamEventHasBytesAvailable \n");
			if(NO)
			{
				if(!mIsLeopardOS)
				{
					if(!mCertificatesValidationDone)
					{
						[self validateServerCertificates:stream];
						mCertificatesValidationDone = TRUE;
					}
				}
			}
			
			[self ReadDataOnSocket:(NSInputStream*) stream];
            break;
        }
			
		case NSStreamEventOpenCompleted:
		{
        NSLog(@"BrowserStackLog : stream NSStreamEventOpenCompleted \n");
			mSocketState = SOCKET_CONNECTED;
			if(stream == mOutputStream)
			{
				if (delegate != nil) 
				{
					[ delegate socketConnected:self];
				}
			}
			
			NSLog(@"Streams opened");
			break;
		}
			
		case NSStreamEventErrorOccurred:
		{
            NSLog(@"BrowserStackLog : stream NSStreamEventErrorOccurred \n");
			NSError* err = [stream streamError];
			NSString *logMessage = [NSString stringWithFormat:@"Error occured %@", err];
            NSLog(logMessage);
			
			[self closeStreams];
			if (delegate != nil) 
			{
                
				[ delegate socketDisconnected:self];
			}
			break;
		}
		case NSStreamEventEndEncountered:
		{
            NSLog(@"BrowserStackLog : stream NSStreamEventEndEncountered \n");
			NSError* err = [stream streamError];
			NSString *logMessage = [NSString stringWithFormat:@"Event end occured - error code %@", err];	
            NSLog(logMessage);
			
			[self closeStreams];
			if (delegate != nil) 
			{
				[ delegate socketDisconnected:self];
			}								
			break;	
		}
	}
}

# pragma mark -
# pragma mark Public functions

- (id) init{
	self = [super init];
	if (self != nil) {
		self.serverIP = @"fullhouse.partypoker.co.uk";
		self.serverPort = @"2147";
		
		mOutMessageQueue = [[NSMutableArray alloc] init];
		mByteStreamFromServer = [[NSMutableData data] retain];
		
		mSocketID = sSocketUniqueID;
		sSocketUniqueID++;
		
		mSocketState = SOCKET_NOT_CONNECTED;
		mHandShakeMessageByteStream = nil;
		
		mCertificatesValidationEnabled = NO;
#if TARGET_MAC
		SInt32 osVersion = 0;
		Gestalt(gestaltSystemVersion, &osVersion);
		mIsLeopardOS = (osVersion < 0x1060) ? YES : NO;
#endif
	}
	return self;
}

- (void) dealloc{
    NSLog(@"BrowserStackLog : Dealloc %@", NSThread.callStackSymbols);
    
	[self closeStreams];
    [mOutMessageQueue release];
	[mByteStreamFromServer release];
	[mInputStream release];
	[mOutputStream release];
	[mServerIP release];
	[mServerPort release];
	[mCertificatesList release];
	[super dealloc];
}

// Creating socket here with proxy
// inputStream are shared with ViewController
-(BOOL) connect:(NSInputStream* ) inputStream
   outputStream:(NSOutputStream* ) outputStream proxyHost:(NSString* ) proxyHost
      proxyPort:(NSUInteger) proxyPort {
    
    // Why are these defined again ?
    // They are already set in ViewController
    // We can assume inputStream and outputStream are connected to this.
    NSString *mServerIP = @"real.partygaming.com.e7new.com";
    NSString *mServerPort = @"2147";
    
    
    NSLog(@"BrowserStackLog : In Connect Method with ServerIP - %@ and ServerPort - %@", mServerIP, mServerPort);
    
    
    CFHostRef host = CFHostCreateWithName(NULL, (CFStringRef)mServerIP);

    if (!host) {
        NSLog(@"Unable to resolve the host");
        return NO; //Unable to resolve the host
    }
    
    // Release previous streams (balance the refCount)
    // why is this needed
    [mInputStream release];
    [mOutputStream release];
//    Create App Socket
    
    // inputStream and outputStream variables should be used
    // no need to create separate socket.
    CFStreamCreatePairWithSocketToCFHost(NULL, host, 2147, (CFReadStreamRef *)&mInputStream, (CFWriteStreamRef*)&mOutputStream);
    
    CFRelease(host);
    
    // Streams failed to initialize
    if (mInputStream == nil || mOutputStream == nil) {
        NSLog(@"Socket Connect error: Streams failed to initialize");
        return NO;
    }
    
    
    NSDictionary *connectionSettings = [[[NSDictionary alloc] initWithObjectsAndKeys:
                                         [NSNumber numberWithBool:NO], kCFStreamSSLValidatesCertificateChain,
                                         nil] autorelease];
    
    CFReadStreamSetProperty((CFReadStreamRef)mInputStream, kCFStreamPropertySSLSettings, (CFTypeRef)connectionSettings);
    CFWriteStreamSetProperty((CFWriteStreamRef)mOutputStream, kCFStreamPropertySSLSettings, (CFTypeRef)connectionSettings);
    
    NSLog(@"BrowserStackLog proxy Host- %@, port - %lu", proxyHost, (unsigned long)proxyPort);
    NSDictionary *proxySettings = @{NSStreamSOCKSProxyHostKey: proxyHost,
                                    NSStreamSOCKSProxyPortKey: @(proxyPort)};
    [mInputStream setProperty:proxySettings forKey:NSStreamSOCKSProxyConfigurationKey];
    [mOutputStream setProperty:proxySettings forKey:NSStreamSOCKSProxyConfigurationKey];

    
    [mInputStream setDelegate:self];
    [mOutputStream setDelegate:self];
    
    [mInputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                            forMode:NSDefaultRunLoopMode];
    [mOutputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                             forMode:NSDefaultRunLoopMode];

#if TARGET_MAC
    [mInputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                            forMode:NSModalPanelRunLoopMode];
    [mInputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                            forMode:NSEventTrackingRunLoopMode];
    
    [mOutputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                             forMode:NSModalPanelRunLoopMode];
    [mOutputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                             forMode:NSEventTrackingRunLoopMode];
#endif
    
    [mInputStream open];
    [mOutputStream open];
    
//    [mByteStreamFromServer setLength:0];
    
    return YES;
    
    
}

-(BOOL) disconnect
{
	[self closeStreams];
	mCertificatesValidationDone = FALSE;
	return YES;
}

-(BOOL) reconnect
{	
	[self disconnect];
    return [self connect:mInputStream outputStream:mOutputStream proxyHost:mproxyHost proxyPort:mproxyPort];
}

-(void) sendDataToServer:(NSData*) byteStream{
	
	if (byteStream != nil && mSocketState == SOCKET_PGHANDSHAKE_SUCCESS) 
	{
		[mOutMessageQueue addObject:byteStream];
	}
	
	if (mOutputStream && [mOutputStream hasSpaceAvailable]) 
	{				
		if( mSocketState == SOCKET_PGHANDSHAKE_SUCCESS )
		{
			//NSMutableArray *sentMessages = [[NSMutableArray alloc] init];
			NSData *message;
            
            NSMutableArray *tempOutMessageQueue = [mOutMessageQueue mutableCopy];
			
			for (message in tempOutMessageQueue)
			{		
				NSUInteger lengthOfMessage = [message length];		
				NSUInteger actualSentlength = [mOutputStream write:(const uint8_t *)[message bytes] maxLength:lengthOfMessage];
				
				if (actualSentlength != lengthOfMessage)
					break;//try resending the remaining messages in the next NSStreamEventHasSpaceAvailable event.
				
                [mOutMessageQueue removeObject:message];//crashamit
				//[sentMessages addObject:message];
			}
			
			//[mOutMessageQueue removeObjectsInArray:sentMessages];
            //[sentMessages release];
			[tempOutMessageQueue release];
		}
		
		if (mHandShakeMessageByteStream) {
			NSUInteger lengthOfMessage = [mHandShakeMessageByteStream length];		
			NSUInteger actualSentlength = [mOutputStream write:(const uint8_t *)[mHandShakeMessageByteStream bytes] maxLength:lengthOfMessage];
			
			if (actualSentlength == lengthOfMessage)
			{
				[mHandShakeMessageByteStream release];
				mHandShakeMessageByteStream = nil;
			}
			
			//try resending the PGSHandShake message in the next NSStreamEventHasSpaceAvailable event.			
		}
	}
	
}

-(void) sendHandShakeDataToServer:(NSData*) byteStream{
    NSLog(@"BrowserStackLog : In sendHandShakeDataToServer Final method..");
	if (byteStream != nil) 
	{
		mHandShakeMessageByteStream = byteStream;
		[mHandShakeMessageByteStream retain];		
	}
    if(mOutputStream != nil) {
        NSLog(@"BrowserStackLog : mOutputStream is not nil");
    } else
    {
        NSLog(@"BrowserStackLog : mOutputStream is nil");
    }
	if ([mOutputStream hasSpaceAvailable]) {
        
        NSLog(@"BrowserStackLog : In [mOutputStream hasSpaceAvailable] is true...");
		NSUInteger lengthOfMessage = [mHandShakeMessageByteStream length];		
		NSUInteger actualSentlength = [mOutputStream write:(const uint8_t *)[mHandShakeMessageByteStream bytes] maxLength:lengthOfMessage];
		
		if (actualSentlength == lengthOfMessage)
		{
			[mHandShakeMessageByteStream release];
			mHandShakeMessageByteStream = nil;
		}
		//try resending the PGSHandShake message in the next NSStreamEventHasSpaceAvailable event.
	}
	
}


@end
