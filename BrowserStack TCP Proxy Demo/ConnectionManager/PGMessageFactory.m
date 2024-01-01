/******************************************************************************/
/**
 ** \file PGMessageFactory.m
 **
 **	Primary responsibility of this class is to create PG mesages for a given class ID. 
 ** This class implements protocol to register message factories.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 ** Author : Suyash Sharadrao Motarwar on 24/03/11.
 *******************************************************************************/


#import "PGMessageFactory.h"

static PGMessageFactory *sFactory = nil; 

@implementation PGMessageFactory

#pragma mark Overrides for singleton

- (id) init
{
	self = [super init];
	if (self != nil) {
		mFactories = [[NSMutableArray alloc] init];
	}
	return self;
}


+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


//- (id)retain
//{
//    return self;
//}
//
//
//- (NSUInteger)retainCount
//{
//    return NSUIntegerMax;  //denotes an object that cannot be released
//}
//
//
//- (oneway void)release
//{
//	//do nothing
//}
//
//
//- (id)autorelease
//{
//    return self;
//}

#pragma mark -
#pragma mark class method
+ (id)sharedInstance{
	
	if (sFactory == nil) {
		sFactory = [[super allocWithZone:NULL] init];
	}
	
	return sFactory;
}

#pragma mark -
#pragma mark protocol implementation

-(PGSerializable*) messageObjectForClassID:(int) classID{
	id message = nil;
	for(id object in mFactories)
	{
		message = [object messageObjectForClassID:classID];
		if(message)
			break;
	}
	
	if( message == nil)
	{
        NSString *logMessage = [NSString stringWithFormat:@"Invalid class ID - %d", classID];
        //PGERROR(logMessage);
	}

	
	return message;
}

- (void)registerFactory:(id<PGMessageFactory>)factory{
	
	if([(id)factory conformsToProtocol:@protocol(PGMessageFactory)]){
		[mFactories addObject:factory];
	}
}

#if TARGET_MAC
#else
- (NSMutableArray *) factory {
    return mFactories;
}
#endif
@end
