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
 \******************************************************************************/

#import "MessageBaseClasses.h"
#import "PGTimer.h"

@interface PGMobPrivilegedMessageInfo : NSObject {
	
	PGPrivilegedSerializable* mMessage;
	int	mNumberOfTimesMessageSent;
	int mSecondsToWaitBeforeResendingMessage;
	NSDate* mLastMessageSendTime;
	int mReceiverID;	
	int mDomainID;
}

@property (nonatomic, retain) PGPrivilegedSerializable* message;
@property (nonatomic) int numberOfTimesMessageSent;
@property (nonatomic) int secondsToWaitBeforeResendingMessage;
@property (nonatomic, retain) NSDate* lastMessageSendTime;
@property (nonatomic) int receiverID;
@property (nonatomic) int domainID;

@end




@interface PGMobPrivilegedMessageManager : NSObject {

	NSMutableArray* mPendingMessages;
	int mPrivilegedMessageNumber;
	
	PGMobTimer* mPrivilegedMessageSendTimer;
}

///This method checks if the message is privileged and caches accordingly.
-(void) cacheIfPrivilegedMessage:(PGSerializable*) message
					  receiverID:(int) receiverID
						domainID:(int) domainID;

///This method checks if the given message number is already cachec in privileged message queue.
-(BOOL) isMessageAlreadyCached:(int) messageNumber;

///This method removes the message with specified number from the privileged queue.
-(void) removeAcknowledgedMessage:(int) messageNumber;

///This method flushes out all the messages in Privileged queue, it doesn't increase the sent count.
///This is the specific requirement for PGSLogin/PPSJoinTable messsages.
-(void) sendQueuedMessages;

///This method clears all the cached messages for a particular receiver id
- (void) clearCachedMessagesForReceiverID:(int) receiverID;

-(NSMutableArray*)pendingMessages;

+(PGMobPrivilegedMessageManager*) sharedManager;

#if TARGET_MAC
#else

-(void) activate;
-(void) deactivate;

#endif
@end

