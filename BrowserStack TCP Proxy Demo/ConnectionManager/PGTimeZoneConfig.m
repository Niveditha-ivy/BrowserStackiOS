/******************************************************************************/
/**
 ** PGTimeZoneConfig.m
 **
 ** This file contains interface for PGStandardTimeZoneInfo, which will provide
 ** interface for getting the system local standard time zone name.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 ** Authors:
 **   Apparao Mulpuri 
 **
 *******************************************************************************/


#import "PGTimeZoneConfig.h"


@implementation PGTimeZoneConfig

#pragma mark -
#pragma mark - Initializers
#pragma mark -

- (id)init
{

	if (self = [super init]) 
	{
		mTimeZoneInfo = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"PGTimeZoneConfigurations" ofType:@"plist"]];
	}
						 
	return self;					 
}

- (void) dealloc
{

	[mTimeZoneInfo release];
	[super dealloc];
}


#pragma mark -
#pragma mark - Accessors
#pragma mark -

- (NSString *)localTimeZoneStandardName
{
	NSString *userTimeZoneID = [self standardTimeZoneNameWithTimeZoneIdentifier:[[NSTimeZone localTimeZone] name]];
	if (userTimeZoneID == nil || (userTimeZoneID && [userTimeZoneID length] < 0)) {
		userTimeZoneID = @"Eastern Standard Time";
	}
	
	return userTimeZoneID;
}
						 
- (NSString *)standardTimeZoneNameWithTimeZoneIdentifier:(NSString *)timeZoneID
{
//	NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:timeZoneID];
//    NSString *returnStandardTimeZoneName = @"";
//    
//    returnStandardTimeZoneName = [timeZone localizedName:NSTimeZoneNameStyleStandard locale:[NSLocale currentLocale]];        
                  
	return [mTimeZoneInfo objectForKey:timeZoneID];	
}
						 

@end
