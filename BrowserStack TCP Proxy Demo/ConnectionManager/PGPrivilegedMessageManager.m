/******************************************************************************/
/**
 ** PGPrivilegedMessageManager.h
 **
 **	Caches the message in a queue if it is privileged
 **	Removes the message from the queue if server acknowledges of its reception
 **	Sends queued messages whenever called up to do so, like in case of subscription change
 **	Provides an interface to query all pending queued messages
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 ** Author : Suyash Motarwar
 \******************************************************************************/
#import "PGPrivilegedMessageManager.h"
#import "PGConnectionManager.h"
#import "PGMessageSenderReceiver.h"

@implementation PGMobPrivilegedMessageInfo

@synthesize message = mMessage, numberOfTimesMessageSent = mNumberOfTimesMessageSent;
@synthesize secondsToWaitBeforeResendingMessage = mSecondsToWaitBeforeResendingMessage;
@synthesize lastMessageSendTime = mLastMessageSendTime, receiverID = mReceiverID, domainID = mDomainID;

-(void)dealloc
{
	  
    [mMessage release];
    [mLastMessageSendTime release];
    [super dealloc];
}

-(id)init
{
	  
	self = [super init];
	return self;
}

@end


static PGMobPrivilegedMessageManager *sManager = nil;

#pragma mark Private methods
@interface PGMobPrivilegedMessageManager (PGPrivilegedMessageManagerPrivate)
-(void) killTimer;
@end


@implementation PGMobPrivilegedMessageManager

- (id) init
{
	  
	self = [super init];
	if (self != nil) {
		mPendingMessages = [[NSMutableArray alloc] init];
		mPrivilegedMessageNumber = 1;
		
		mPrivilegedMessageSendTimer = [[PGMobTimer scheduledTimerWithTimeInterval:1
																	 target:self
																   selector:@selector(reSendQuedMesssages:)
																   userInfo:nil repeats:YES] retain];
		
	}
	return self;
}

- (void) dealloc
{
	  

	[self killTimer];
	[mPendingMessages release];
	[super dealloc];
}

-(void) cacheIfPrivilegedMessage:(PGSerializable*) message
					  receiverID:(int) receiverID
						domainID:(int) domainID{
		
	if( [message isKindOfClass:[PGPrivilegedSerializable class] ]) {

		PGPrivilegedSerializable* privilegedMessage = (PGPrivilegedSerializable*)message;
		//Check if the message is already in the queue.
		BOOL messageAlreadyCached = [self isMessageAlreadyCached: [privilegedMessage messageNumber] ];
		if ( [privilegedMessage isPrivileged] && messageAlreadyCached == NO ) {
			
			//Assign the unique number for each privileged message.
			[privilegedMessage setMessageNumber:mPrivilegedMessageNumber];
			mPrivilegedMessageNumber++;
			
			PGMobPrivilegedMessageInfo* messageInfo = [[PGMobPrivilegedMessageInfo alloc] init];
			//[messageInfo autorelease];
			
			[messageInfo setMessage:privilegedMessage];
			[messageInfo setReceiverID:receiverID];
			[messageInfo setDomainID:domainID];
		
			[messageInfo setLastMessageSendTime:[NSDate date]];
			[messageInfo setSecondsToWaitBeforeResendingMessage:60];//TODO: Suyash - this should be read from configuration.
			[messageInfo setNumberOfTimesMessageSent:1]; //After cacheing, the message will be sent by the caller of this method.
						
			// If message is with the block status then send the message after an interval of time
			if( [privilegedMessage isBlocked])
			{
				[messageInfo setSecondsToWaitBeforeResendingMessage:40];//TODO: Suyash - this should be read from configuration.
				[messageInfo setNumberOfTimesMessageSent:1]; 
			}
			
			[mPendingMessages addObject:messageInfo];
			[messageInfo release];
		}
	}
	
}

-(void) reSendQuedMesssages: (NSTimer *)aTimer {
	
	if([mPendingMessages count] == 0)
		return;
	
	NSMutableArray* messagesToBeRemoved = [NSMutableArray array];
	
	NSDate* currentTime = [NSDate date];
	
	PGMobPrivilegedMessageInfo* messageInfo = nil;
	for(messageInfo in mPendingMessages) {
		
		NSTimeInterval secondsSinceLastTry = [currentTime timeIntervalSinceDate:[messageInfo lastMessageSendTime] ];
		//int secondsSinceLastTry = currentTime - [messageInfo lastMessageSendTime];
		if (secondsSinceLastTry > [messageInfo secondsToWaitBeforeResendingMessage]) {
			
			//If its blocked message or number of times to send the message limit is crossed
			//then remove the message from the privilged queue and post the failure
			if ([[messageInfo message] isBlocked] || [messageInfo numberOfTimesMessageSent] >= 4) { //TODO: Suyash - This value should be referred from configuration.
				//TODO: suyash - Post the message sending failure notification.
				
				NSString *logMessage = [NSString stringWithFormat:@"Failed to send privileged message - %@", [[messageInfo message] description]];	
				NSLog(logMessage);

				[messagesToBeRemoved addObject:messageInfo];
			}
			else {
				
				[messageInfo setNumberOfTimesMessageSent:[messageInfo numberOfTimesMessageSent] + 1];
				[messageInfo setLastMessageSendTime:[NSDate date]];
				//Send the message to server.
				if ([messageInfo domainID] == -1) { //This is regular flow
					[[[PGMobConnectionManager sharedManager] messageSenderReceiver ] sendMessageToServer:[messageInfo message]
																						   receiverID:[messageInfo receiverID]];
				} else { // This is domain specific flow
					[[[PGMobConnectionManager sharedManager] messageSenderReceiver ] sendMessageToServer:[messageInfo message]
																						   receiverID:[messageInfo receiverID]
																							 onDomain:[messageInfo domainID]];
				}
			}
		}
	}
	
	[mPendingMessages removeObjectsInArray:messagesToBeRemoved];
}

-(void) sendQueuedMessages {
	
	PGMobPrivilegedMessageInfo* messageInfo = nil;
	for(messageInfo in mPendingMessages) {
		if ([messageInfo domainID] == -1) { //This is regular flow
			[[[PGMobConnectionManager sharedManager] messageSenderReceiver ] sendMessageToServer:[messageInfo message]
																				   receiverID:[messageInfo receiverID]];
		} else { // This is domain specific flow
			[[[PGMobConnectionManager sharedManager] messageSenderReceiver ] sendMessageToServer:[messageInfo message] 
																				   receiverID:[messageInfo receiverID]
																					 onDomain:[messageInfo domainID]];
		}
	}
}


-(BOOL) isMessageAlreadyCached:(int) messageNumber {
	
	PGMobPrivilegedMessageInfo* messageInfo = nil;
	for(messageInfo in mPendingMessages) {
		
		if ([[messageInfo message] messageNumber] == messageNumber ) {
			return YES;
		}
	}
	
	return NO;
}


-(void) removeAcknowledgedMessage:(int) messageNumber
{
	PGMobPrivilegedMessageInfo* messageInfo = nil;
	for(messageInfo in mPendingMessages) {
		
		if ([[messageInfo message] messageNumber] == messageNumber ) {
			[mPendingMessages removeObject:messageInfo];
			return;
		}
	}	
}

- (void)killTimer{
    if(mPrivilegedMessageSendTimer) {
        [mPrivilegedMessageSendTimer invalidate];
        [mPrivilegedMessageSendTimer release];
        mPrivilegedMessageSendTimer = nil;
    }
}


- (void) clearCachedMessagesForReceiverID:(int) receiverID{
	NSMutableArray *messagesToBeRemoved = [NSMutableArray new];
	for(PGMobPrivilegedMessageInfo* messageInfo in mPendingMessages) {
		if ([messageInfo receiverID] == receiverID ) {
			[messagesToBeRemoved addObject:messageInfo];
		}
	}
	if ([messagesToBeRemoved count] > 0) {
		[mPendingMessages removeObjectsInArray:messagesToBeRemoved];
	}
	[messagesToBeRemoved release];
}

-(NSMutableArray*)pendingMessages
{
	return mPendingMessages;
}

-(void) activate {
    mPrivilegedMessageNumber = 1;//(int) [mPendingMessages count];
}

-(void) deactivate {
    [mPendingMessages removeAllObjects];
}

#pragma mark class methods
+ (PGMobPrivilegedMessageManager*)sharedManager{
	
	if (sManager == nil) {
		sManager = [[super allocWithZone:NULL] init];
	}
	
	return sManager;
}

#pragma mark Overrides for singleton
+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedManager];
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


- (id)retain
{
    return self;
}


- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}


- (oneway void)release
{
	//do nothing
}


- (id)autorelease
{
    return self;
}

@end
