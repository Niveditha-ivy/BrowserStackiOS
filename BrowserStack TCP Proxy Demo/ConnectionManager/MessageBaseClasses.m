/******************************************************************************/
/**
 ** \file MessageBaseClasses.m
 **
 **  This file contains all the base classes for client server messaging framework.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 ** Author : Suyash Sharadrao Motarwar
 *******************************************************************************/

#import "MessageBaseClasses.h"
#import "PGByteArrayReader.h"
#import "PGByteArrayWriter.h"
#import "Constants.h"

@implementation PGSerializable

@synthesize topLevelMessage = mTopLevelMessage;
@synthesize classID = mClassID;
@synthesize lengthStartPosition = mLengthStartPosition;

- (id) init
{
	  

	self = [super init];
	if (self != nil) {
		mTopLevelMessage = FALSE;
	}
	return self;
}

-(void) read:(PGByteArrayReader*) byteArrayReader
{
}

-(void) writeLength:(PGByteArrayWriter*) byteArrayWriter {
    if( mTopLevelMessage == NO) {
        int dataEndPosition = [byteArrayWriter getCurrentPointer];
        [byteArrayWriter putLength:self.lengthStartPosition length:dataEndPosition-self.lengthStartPosition-1];
    }
}

-(void) write:(PGByteArrayWriter*) byteArrayWriter
{
    if(ENABLE_SRLZR_BW_COMPATIBILTY) {
        //Put the class ID in the message only if its not top level message.
        if( mTopLevelMessage == NO) {
            [byteArrayWriter putInt:mClassID];
            self.lengthStartPosition = [byteArrayWriter getCurrentPointer];
            int dataStartPosition = self.lengthStartPosition + 1;
            [byteArrayWriter setCurrentPointer:dataStartPosition];
        }
    } else {
        //Put the class ID in the message only if its not top level message.
        if( mTopLevelMessage == NO)
            [byteArrayWriter putInt:mClassID];
    }
    
}

-(BOOL) isCompositeMessage
{
	return NO;
}

-(NSMutableArray*) messages
{
	return nil;
}

-(void)dealloc
{
	  
//	[super dealloc];
}

@end



@implementation PGPrivilegedSerializable

@synthesize messageNumber = mMessageNumber;

- (id) init
{
	  

	self = [super init];
	if (self != nil) {
		mMessageNumber = 0;
	}
	return self;
}

-(void) read:(PGByteArrayReader*) byteArrayReader
{
	[super read:byteArrayReader];
	mMessageNumber = [byteArrayReader getInt];
}

-(void) write:(PGByteArrayWriter*) byteArrayWriter
{
	[super write:byteArrayWriter];
	[byteArrayWriter putInt:mMessageNumber];
}
-(BOOL) isPrivileged{
	return false;
}
-(BOOL) isGlobal{
	return false;
}
-(BOOL) isBlocked{
	return false;
}

-(void)dealloc
{
	  
//	[super dealloc];
}

@end


@implementation PGStringEx

@synthesize literalId = mLiteralId, parameterValues = mParameterValues, isLanguagePackElement = mIsLanguagePackElement;

- (id) init
{
	  

	self = [super init];
	if (self != nil) {
		mLiteralId = 0;
		mParameterValues = [[NSMutableArray alloc] init];
		mIsLanguagePackElement = false;
	}
	return self;
}


- (id) initWithLiterlID:(int) lId
		 parameterArray:(NSMutableArray*) parameterArray
			isLPElement:(bool)isLPElement
{
	  

	self = [super init];
	if (self != nil) {
		mLiteralId = lId;
//		[mParameterValues release];
		mParameterValues = parameterArray;
//		[mParameterValues retain];
		mIsLanguagePackElement = isLPElement;
	}
	return self;
}

- (void) dealloc
{
	  

//	[mParameterValues release];
//	[super dealloc];
}

-(NSString*) ToString
{
	NSString *string = [NSMutableString string];
	NSString *strSeparator = @",";
	string = [string stringByAppendingFormat:@"%d", mLiteralId];
	string = [string stringByAppendingString:strSeparator];
	string = [string stringByAppendingFormat:@"%b", mIsLanguagePackElement];
	
	return string;
}


@end
