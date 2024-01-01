/************************************************************/ 
/** \file PGTimer.h 
 ** 
 ** This file contains interface for PGTimer is a wrapper on NSTimer 
 ** that ensures that there are no retain cycles between the timer object and the target.
 ** The class is designed to be used on the same lines as NSTimer. 
 **
 ** Copyright (c) 2011 PartyGaming, Inc. All rights reserved.
 **
 **************************************************************/


/// PGTimer is a wrapper on NSTimer that ensures that there are no
/// retain cycles between the timer object and the target.
//#if TARGET_IOS
#import <Foundation/Foundation.h>
//#endif

@interface PGMobTimer : NSObject {
	NSTimer *mTimer;
	id mProxyTarget;
}

/// Method to get scheduled timer.
+ (PGMobTimer *)scheduledTimerWithTimeInterval: (NSTimeInterval)seconds
									 target: (id)target 
								   selector: (SEL)selector 
								   userInfo: (id)userInfo 
									repeats: (BOOL)repeats;

/// Method to get an initialized timer.
+ (PGMobTimer *)timerWithTimeInterval:(NSTimeInterval)seconds
							target:(id)target 
						  selector:(SEL)aSelector 
						  userInfo:(id)userInfo 
						   repeats:(BOOL)repeats
							 modes:(NSArray *)modes;

+ (PGMobTimer *)scheduledTimerWithTimeIntervalByBlockingMainThread: (NSTimeInterval)seconds
                                                         target: (id)target
                                                       selector: (SEL)selector
                                                       userInfo: (id)userInfo
                                                        repeats: (BOOL)repeats;

+ (PGMobTimer *)timerWithTimeIntervalByBlockingMainThread:(NSTimeInterval)seconds
                                                target:(id)target
                                              selector:(SEL)selector
                                              userInfo:(id)userInfo
                                               repeats:(BOOL)repeats
                                                 modes:(NSArray *)modes;

/// Property to access the wrapped NSTimer.
@property (readonly) NSTimer *timer;

/// Method to invalidate the timer.
- (void)invalidate;

@end
