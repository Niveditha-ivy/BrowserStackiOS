/******************************************************************************/
/**
 ** \file PGConnectionManagerAccessor.h
 **
 **	Primary responsibility of this class is to provide accessors for connection management/ message sender protocols.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 *******************************************************************************/

#import "PGConnectionManagerProtocols.h"


@interface PGConnectionManagerAccessor : NSObject 

+ (id<PGConnectionManaging>) connectionManager;
+ (id<PGServerMessageSending>) messageSender; 
+ (id<PGMessageFactoryRegistration>) messageFactory;

@end
