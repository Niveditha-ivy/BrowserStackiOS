/******************************************************************************/
/**
 ** \file PGConnectionManagerAccessor.m
 **
 **	Primary responsibility of this class is to provide accessors for connection management/ message sender protocols.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 ** Author : Suyash Motarwar
 *******************************************************************************/

#import "PGConnectionManagerAccessor.h"
#import "PGConnectionManager.h"
#import "PGMessageFactory.h"

@implementation PGConnectionManagerAccessor

+ (id<PGConnectionManaging>) connectionManager{

	return [PGMobConnectionManager sharedManager];
}

+ (id<PGServerMessageSending>) messageSender{
	
	return [(PGMobConnectionManager*)[PGMobConnectionManager sharedManager] messageSenderReceiver];
}

+ (id<PGMessageFactoryRegistration>) messageFactory{
	
	return [PGMessageFactory sharedInstance];
}
@end
