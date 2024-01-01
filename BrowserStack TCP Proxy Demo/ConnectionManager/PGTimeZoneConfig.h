/************************************************************/ 
/** \file PGTimeZoneConfig.h 
 ** 
 ** This file contains interface for PGStandardTimeZoneInfo, which will provide
 ** interface for getting the system local standard time zone name.
 **
 **
 ** Copyright (c) 2011 PartyGaming, Inc. All rights reserved.
 **
 **************************************************************/

#import <Foundation/Foundation.h>
@interface PGTimeZoneConfig : NSObject {

	NSDictionary *mTimeZoneInfo;
	
}

- (NSString *)localTimeZoneStandardName;
- (NSString *)standardTimeZoneNameWithTimeZoneIdentifier:(NSString *)timeZoneID;

@end
