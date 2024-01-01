/******************************************************************************/
/**
 ** \file PGMessageFactory.h
 **
 **	Primary responsibility of this class is to create PG mesages for a given class ID. 
 ** This class implements protocol to register message factories.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 *******************************************************************************/


#import "PGConnectionManagerProtocols.h"

@interface PGMessageFactory : NSObject<PGMessageFactory, PGMessageFactoryRegistration> {
	
	NSMutableArray *mFactories;

}

+ (PGMessageFactory *)sharedInstance;

@end
