/************************************************************/
/** PGTimer.h 
 ** 
 ** This file contains implementation for PGTimer is a wrapper on NSTimer 
 ** that ensures that there are no retain cycles between the timer object and the target.
 ** The class is designed to be used on the same lines as NSTimer. 
 **
 ** Copyright (c) 2011 PartyGaming, Inc. All rights reserved.
 **
 **************************************************************/


#import "PGTimer.h"

/// Proxy target for the NSTimer
@interface PGMobProxyTimerTarget : NSObject
{
	PGMobTimer *mPGTimer; // Weak reference
	id mTarget;		   // Weak reference	
	SEL mSelector;
}
/// Method to initalize the Proxy Target object.
- (PGMobProxyTimerTarget *)initWithTarget: (id)target
							  selector: (SEL)selector 
							   pgTimer: (PGMobTimer *)pgTimer;

@end

#pragma mark -

@implementation PGMobTimer

@synthesize timer = mTimer;

- (id) initWithTimeInterval: (NSTimeInterval)seconds 
					 target: (id)target 
				   selector: (SEL)selector 
				   userInfo: (id)userInfo 
					repeats: (BOOL)repeats
					  modes: (NSArray *)modes{
	  

	self = [super init];
	if (self != nil) {
		mProxyTarget = [[PGMobProxyTimerTarget alloc] initWithTarget:target
														 selector:selector 
														  pgTimer:self];
		
		if (modes == nil) {
			mTimer = [[NSTimer scheduledTimerWithTimeInterval:seconds 
													   target:mProxyTarget 
													 selector:@selector(timeFireAction:) 
													 userInfo:userInfo 
													  repeats:repeats] retain];
		} else {
			mTimer = [[NSTimer timerWithTimeInterval:seconds
											  target:mProxyTarget
											selector:@selector(timeFireAction:)
											userInfo:userInfo
											 repeats:repeats] retain];
			for (NSString *mode in modes) {
				[[NSRunLoop currentRunLoop] addTimer:mTimer forMode:mode];
			}
		}

		
	}
	return self;
}

- (id) initWithTimeIntervalByBlockingMainThread: (NSTimeInterval)seconds
                     target: (id)target
                   selector: (SEL)selector
                   userInfo: (id)userInfo
                    repeats: (BOOL)repeats
                      modes: (NSArray *)modes{
      
    
    self = [super init];
    if (self != nil) {
        mProxyTarget = [[PGMobProxyTimerTarget alloc] initWithTarget:target
                                                         selector:selector
                                                          pgTimer:self];
        
        if (modes == nil) {
            mTimer = [[NSTimer scheduledTimerWithTimeInterval:seconds
                                                       target:mProxyTarget
                                                     selector:@selector(timeFireActionByBlockingMainThread:)
                                                     userInfo:userInfo
                                                      repeats:repeats] retain];
        } else {
            mTimer = [[NSTimer timerWithTimeInterval:seconds
                                              target:mProxyTarget
                                            selector:@selector(timeFireActionByBlockingMainThread:)
                                            userInfo:userInfo
                                             repeats:repeats] retain];
            for (NSString *mode in modes) {
                [[NSRunLoop currentRunLoop] addTimer:mTimer forMode:mode];
            }
        }
        
        
    }
    return self;
}

- (void) dealloc
{

	[mTimer invalidate];
	[mTimer release];
	[mProxyTarget release];
	[super dealloc];
}

#pragma mark -

// Method to invalidate the timer
- (void)invalidate{
	[mTimer invalidate];
}

// Convenience constructor
+ (PGMobTimer *)scheduledTimerWithTimeInterval: (NSTimeInterval)seconds
									 target: (id)target 
								   selector: (SEL)selector 
								   userInfo: (id)userInfo 
									repeats: (BOOL)repeats{
	PGMobTimer *aTimer = [[PGMobTimer alloc] initWithTimeInterval:seconds
													target:target 
												  selector:selector 
												  userInfo:userInfo 
												   repeats:repeats
													  modes:nil];
	return [aTimer autorelease];
}

/// Timer scheduled on the current run loop in specific modes
+ (PGMobTimer *)timerWithTimeInterval:(NSTimeInterval)seconds
							target:(id)target 
						  selector:(SEL)selector 
						  userInfo:(id)userInfo 
						   repeats:(BOOL)repeats
							modes:(NSArray *)modes {
	PGMobTimer *aTimer = [[PGMobTimer alloc] initWithTimeInterval:seconds
													 target:target
												   selector:selector
												   userInfo:userInfo
													repeats:repeats
												   modes:modes];
	return [aTimer autorelease];
}

// Convenience constructor
+ (PGMobTimer *)scheduledTimerWithTimeIntervalByBlockingMainThread: (NSTimeInterval)seconds
                                                         target: (id)target
                                                       selector: (SEL)selector
                                                       userInfo: (id)userInfo
                                                        repeats: (BOOL)repeats{
    PGMobTimer *aTimer = [[PGMobTimer alloc] initWithTimeIntervalByBlockingMainThread:seconds
                                                                         target:target
                                                                       selector:selector
                                                                       userInfo:userInfo
                                                                        repeats:repeats
                                                                          modes:nil];
    return [aTimer autorelease];
}

/// Timer scheduled on the current run loop in specific modes
+ (PGMobTimer *)timerWithTimeIntervalByBlockingMainThread:(NSTimeInterval)seconds
                            target:(id)target
                          selector:(SEL)selector
                          userInfo:(id)userInfo
                           repeats:(BOOL)repeats
                             modes:(NSArray *)modes {
    PGMobTimer *aTimer = [[PGMobTimer alloc] initWithTimeIntervalByBlockingMainThread:seconds
                                                     target:target
                                                   selector:selector
                                                   userInfo:userInfo
                                                    repeats:repeats
                                                      modes:modes];
    return [aTimer autorelease];
}

@end

#pragma mark -

@implementation PGMobProxyTimerTarget

- (PGMobProxyTimerTarget *)initWithTarget: (id)target 
							  selector: (SEL)selector 
							   pgTimer: (PGMobTimer *)pgTimer{
	  

	self = [super init];
	if (self != nil) {
		mTarget = target;
		mSelector = selector;
		mPGTimer = pgTimer;
	}
	return self;
}

-(void)dealloc
{
	  
	[super dealloc];
}

- (void)timeFireAction: (NSTimer *)aTimer{
    if ([mTarget respondsToSelector:mSelector]) { // Note:
        [mTarget performSelector:mSelector withObject:mPGTimer];
    }//one time updateMultiDayBannerTimerText method not found .
	
}

-(void)timeFireActionByBlockingMainThread:(NSTimer *) aTimer
{
#if TARGET_MAC
    [mTarget performSelectorOnMainThread:mSelector withObject:mPGTimer waitUntilDone:YES modes:[NSArray arrayWithObjects:NSDefaultRunLoopMode, NSModalPanelRunLoopMode, NSEventTrackingRunLoopMode, NSRunLoopCommonModes, nil]];
#endif
}

@end


