#include "CommonMessages.h"
// CLASSID: 28673
@implementation    PGSPing
@synthesize  clientTime=mClientTime;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_PING;
        mClientTime = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.clientTime = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mClientTime];
}
@end
// CLASSID: 28674
@implementation    PGSRequestPeerConnectivityStatus
@synthesize  peersConnected=mPeersConnected;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTPEERCONNECTIVITYSTATUS;
        mPeersConnected = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mPeersConnected release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.peersConnected = [byteArrayReader getIntArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putIntArray:mPeersConnected];
}
@end
// CLASSID: 28675
@implementation    PGSResponsePeerConnectivityStatus
@synthesize  peerConnStatus=mPeerConnStatus;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEPEERCONNECTIVITYSTATUS;
        mPeerConnStatus = [[NSMutableDictionary alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mPeerConnStatus release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.peerConnStatus = [byteArrayReader getInt2BoolMap];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt2BoolMap:mPeerConnStatus];
}
@end
// CLASSID: 28676
@implementation    PGSHandShake
@synthesize  type=mType;
@synthesize  frontendId=mFrontendId;
@synthesize  ARABuildNumber=mARABuildNumber;
@synthesize  GRABuildNumber=mGRABuildNumber;
@synthesize  sessionKey=mSessionKey;
@synthesize  loginId=mLoginId;
@synthesize  ucid=mUcid;
@synthesize  password=mPassword;
@synthesize  encProfile=mEncProfile;
@synthesize  productId=mProductId;
@synthesize  messageVector=mMessageVector;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_HANDSHAKE;
        mType = 0;
         mFrontendId = [[NSString alloc] init];
         mARABuildNumber = 0;
         mGRABuildNumber = 0;
         mSessionKey = [[NSString alloc] init];
         mLoginId = [[NSString alloc] init];
         mUcid = [[NSString alloc] init];
         mPassword = [[NSString alloc] init];
         mEncProfile = [[NSData alloc] init];
         mProductId = [[NSString alloc] init];
         mMessageVector = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mFrontendId release];
    [mSessionKey release];
    [mLoginId release];
    [mUcid release];
    [mPassword release];
    [mEncProfile release];
    [mProductId release];
    [mMessageVector release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.ARABuildNumber = [byteArrayReader getInt];
    self.GRABuildNumber = [byteArrayReader getInt];
    self.encProfile = [byteArrayReader getByteArray];
    self.frontendId = [byteArrayReader getString];
    self.loginId = [byteArrayReader getString];
    self.messageVector = [byteArrayReader getObjectArray];
    self.password = [byteArrayReader getString];
    self.productId = [byteArrayReader getString];
    self.sessionKey = [byteArrayReader getString];
    self.type = [byteArrayReader getInt];
    self.ucid = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mARABuildNumber];
    [byteArrayWriter putInt:mGRABuildNumber];
    [byteArrayWriter putByteArray:mEncProfile];
    [byteArrayWriter putString:mFrontendId];
    [byteArrayWriter putString:mLoginId];
    [byteArrayWriter putObjectArray:mMessageVector];
    [byteArrayWriter putString:mPassword];
    [byteArrayWriter putString:mProductId];
    [byteArrayWriter putString:mSessionKey];
    [byteArrayWriter putInt:mType];
    [byteArrayWriter putString:mUcid];
}
@end
// CLASSID: 28677
@implementation    PGSHandShakeResponse
@synthesize  responseId=mResponseId;
@synthesize  sessionKey=mSessionKey;
@synthesize  desc=mDesc;
@synthesize  effectiveLanguage=mEffectiveLanguage;
@synthesize  productCurrencyCode=mProductCurrencyCode;
@synthesize  showCaptcha=mShowCaptcha;
@synthesize  serverType=mServerType;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_HANDSHAKERESPONSE;
        mResponseId = 0;
         mSessionKey = [[NSString alloc] init];
         mDesc = [[PGStringEx alloc] init];
         mEffectiveLanguage = [[NSString alloc] init];
         mProductCurrencyCode = [[NSString alloc] init];
         mShowCaptcha = NO;
         mServerType = 0;
     }
    return self;
}
-(void) dealloc{
    [mSessionKey release];
    [mDesc release];
    [mEffectiveLanguage release];
    [mProductCurrencyCode release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.desc = [byteArrayReader getStringEx];
    self.effectiveLanguage = [byteArrayReader getString];
    self.productCurrencyCode = [byteArrayReader getString];
    self.responseId = [byteArrayReader getInt];
    self.serverType = [byteArrayReader getByte];
    self.sessionKey = [byteArrayReader getString];
    self.showCaptcha = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mDesc];
    [byteArrayWriter putString:mEffectiveLanguage];
    [byteArrayWriter putString:mProductCurrencyCode];
    [byteArrayWriter putInt:mResponseId];
    [byteArrayWriter putByte:mServerType];
    [byteArrayWriter putString:mSessionKey];
    [byteArrayWriter putBOOL:mShowCaptcha];
}
@end
// CLASSID: 28678
@implementation    PGSExtendedAttribs
@synthesize  extendedAttribs=mExtendedAttribs;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_EXTENDEDATTRIBS;
        mExtendedAttribs = [[NSMutableDictionary alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mExtendedAttribs release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.extendedAttribs = [byteArrayReader getString2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString2StringMap :mExtendedAttribs];
}
@end
// CLASSID: 28679
@implementation    PGSLogout
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOGOUT;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 28680
@implementation    PGSResponseLogoutSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSELOGOUTSUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 28683
@implementation    PGSServerUtilityRequest
@synthesize  message=mMessage;
@synthesize  channelIdRequired=mChannelIdRequired;
@synthesize  requestType=mRequestType;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SERVERUTILITYREQUEST;
        mMessage = [[PGStringEx alloc] init];
         mChannelIdRequired = NO;
         mRequestType = 0;
     }
    return self;
}
-(void) dealloc{
    [mMessage release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.channelIdRequired = [byteArrayReader getBOOL];
    self.message = [byteArrayReader getStringEx];
    self.requestType = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mChannelIdRequired];
    [byteArrayWriter putStringEx:mMessage];
    [byteArrayWriter putInt:mRequestType];
}
@end
// CLASSID: 28684
@implementation    PGSServerUtilityResponse
@synthesize  message=mMessage;
@synthesize  responseType=mResponseType;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SERVERUTILITYRESPONSE;
        mMessage = [[PGStringEx alloc] init];
         mResponseType = 0;
     }
    return self;
}
-(void) dealloc{
    [mMessage release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.message = [byteArrayReader getStringEx];
    self.responseType = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mMessage];
    [byteArrayWriter putInt:mResponseType];
}
@end
// CLASSID: 28685
@implementation    PGSMessageFloodGuardAlert
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_MESSAGEFLOODGUARDALERT;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 28686
@implementation    PGSMessageDeliveryFailure
@synthesize  failedMsgClassId=mFailedMsgClassId;
@synthesize  failedMsgTargetId=mFailedMsgTargetId;
@synthesize  failureCause=mFailureCause;
@synthesize  failedMsg=mFailedMsg;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_MESSAGEDELIVERYFAILURE;
        mFailedMsgClassId = 0;
         mFailedMsgTargetId = 0;
         mFailureCause = 0;
         mFailedMsg = [[NSData alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mFailedMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.failedMsg = [byteArrayReader getByteArray];
    self.failedMsgClassId = [byteArrayReader getInt];
    self.failedMsgTargetId = [byteArrayReader getInt];
    self.failureCause = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByteArray:mFailedMsg];
    [byteArrayWriter putInt:mFailedMsgClassId];
    [byteArrayWriter putInt:mFailedMsgTargetId];
    [byteArrayWriter putInt:mFailureCause];
}
@end
// CLASSID: 40961
@implementation    PGSChangePassword
@synthesize  currentPassword=mCurrentPassword;
@synthesize  newPassword=mNewPassword;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CHANGEPASSWORD;
        mCurrentPassword = [[NSString alloc] init];
         mNewPassword = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mCurrentPassword release];
    [mNewPassword release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.currentPassword = [byteArrayReader getString];
    self.newPassword = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mCurrentPassword];
    [byteArrayWriter putString:mNewPassword];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 40962
@implementation    PGSForgotPassword
@synthesize  loginId=mLoginId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_FORGOTPASSWORD;
        mLoginId = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mLoginId release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.loginId = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mLoginId];
}
@end
// CLASSID: 40964
@implementation    PGSGetRegistryValue
@synthesize  key=mKey;
@synthesize  isAbsolute=mIsAbsolute;
@synthesize  isEncrypted=mIsEncrypted;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_GETREGISTRYVALUE;
        mKey = [[NSString alloc] init];
         mIsAbsolute = NO;
         mIsEncrypted = NO;
     }
    return self;
}
-(void) dealloc{
    [mKey release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.isAbsolute = [byteArrayReader getBOOL];
    self.isEncrypted = [byteArrayReader getBOOL];
    self.key = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mIsAbsolute];
    [byteArrayWriter putBOOL:mIsEncrypted];
    [byteArrayWriter putString:mKey];
}
@end
// CLASSID: 40965
@implementation    PGSChangeEmail
@synthesize  newEmail=mNewEmail;
@synthesize  conversationId=mConversationId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CHANGEEMAIL;
        mNewEmail = [[NSString alloc] init];
         mConversationId = 0;
     }
    return self;
}
-(void) dealloc{
    [mNewEmail release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.conversationId = [byteArrayReader getInt64];
    self.newEmail = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mConversationId];
    [byteArrayWriter putString:mNewEmail];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 40966
@implementation    PGSInstallDynamicDLLStatus
@synthesize  statusId=mStatusId;
@synthesize  md5OfExistingDLL=mMd5OfExistingDLL;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_INSTALLDYNAMICDLLSTATUS;
        mStatusId = 0;
         mMd5OfExistingDLL = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMd5OfExistingDLL release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.md5OfExistingDLL = [byteArrayReader getString];
    self.statusId = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mMd5OfExistingDLL];
    [byteArrayWriter putInt:mStatusId];
}
@end
// CLASSID: 40967
@implementation    PGSSelectedScreenName
@synthesize  screeName=mScreeName;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SELECTEDSCREENNAME;
        mScreeName = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mScreeName release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.screeName = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mScreeName];
}
@end
// CLASSID: 40968
@implementation    PGSTakeScreenShot
@synthesize  screenShotDestinationUrl=mScreenShotDestinationUrl;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_TAKESCREENSHOT;
        mScreenShotDestinationUrl = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mScreenShotDestinationUrl release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.screenShotDestinationUrl = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mScreenShotDestinationUrl];
}
@end
// CLASSID: 40969
@implementation    PGSSubscriptionRequest
@synthesize  operationCode=mOperationCode;
@synthesize  oldSubscribedDomain=mOldSubscribedDomain;
@synthesize  regInProgress=mRegInProgress;
@synthesize  loginInProgress=mLoginInProgress;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SUBSCRIPTIONREQUEST;
        mOperationCode = 0;
         mOldSubscribedDomain = 0;
         mRegInProgress = NO;
         mLoginInProgress = NO;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.loginInProgress = [byteArrayReader getBOOL];
    self.oldSubscribedDomain = [byteArrayReader getInt];
    self.operationCode = [byteArrayReader getInt];
    self.regInProgress = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mLoginInProgress];
    [byteArrayWriter putInt:mOldSubscribedDomain];
    [byteArrayWriter putInt:mOperationCode];
    [byteArrayWriter putBOOL:mRegInProgress];
}
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 40970
@implementation    PGSTimeSyncRequest
@synthesize  requestSentTickCount=mRequestSentTickCount;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_TIMESYNCREQUEST;
        mRequestSentTickCount = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.requestSentTickCount = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mRequestSentTickCount];
}
@end
// CLASSID: 40971
@implementation    PGSValidateEmail
@synthesize  code=mCode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_VALIDATEEMAIL;
        mCode = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mCode release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.code = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mCode];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 40972
@implementation    PGSWordVerificationRequest
@synthesize  challengeImageBytes=mChallengeImageBytes;
@synthesize  requestTimeoutAt=mRequestTimeoutAt;
@synthesize  captchaSource=mCaptchaSource;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_WORDVERIFICATIONREQUEST;
        mChallengeImageBytes = [[NSData alloc] init];
         mRequestTimeoutAt = 0;
         mCaptchaSource = 0;
     }
    return self;
}
-(void) dealloc{
    [mChallengeImageBytes release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.captchaSource = [byteArrayReader getByte];
    self.challengeImageBytes = [byteArrayReader getByteArray];
    self.requestTimeoutAt = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByte:mCaptchaSource];
    [byteArrayWriter putByteArray:mChallengeImageBytes];
    [byteArrayWriter putInt:mRequestTimeoutAt];
}
@end
// CLASSID: 40974
@implementation    PGSDynamicMsgNotProcessed
@synthesize  dynamicMsgBytes=mDynamicMsgBytes;
@synthesize  reason=mReason;
@synthesize  installDynamicDLLStatus=mInstallDynamicDLLStatus;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DYNAMICMSGNOTPROCESSED;
        mDynamicMsgBytes = [[NSData alloc] init];
         mReason = 0;
         mInstallDynamicDLLStatus = [[PGSInstallDynamicDLLStatus alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mDynamicMsgBytes release];
    [mInstallDynamicDLLStatus release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.dynamicMsgBytes = [byteArrayReader getByteArray];
    self.installDynamicDLLStatus = [byteArrayReader getObject];
    self.reason = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByteArray:mDynamicMsgBytes];
    [byteArrayWriter putObject:mInstallDynamicDLLStatus];
    [byteArrayWriter putInt:mReason];
}
@end
// CLASSID: 40975
@implementation    PGSGenInfo
@synthesize  typeOfInfo=mTypeOfInfo;
@synthesize  info=mInfo;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_GENINFO;
        mTypeOfInfo = 0;
         mInfo = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mInfo release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.info = [byteArrayReader getObjectArray];
    self.typeOfInfo = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putObjectArray:mInfo];
    [byteArrayWriter putInt:mTypeOfInfo];
}
@end
// CLASSID: 40976
@implementation    PGSDebugInfo
@synthesize  type=mType;
@synthesize  message=mMessage;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DEBUGINFO;
        mType = 0;
         mMessage = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMessage release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.message = [byteArrayReader getString];
    self.type = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mMessage];
    [byteArrayWriter putInt:mType];
}
@end
// CLASSID: 40977
@implementation    PGSUpdateUserPropSettings
@synthesize  propertySettings=mPropertySettings;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_UPDATEUSERPROPSETTINGS;
        mPropertySettings = [[NSMutableDictionary alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mPropertySettings release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.propertySettings = [byteArrayReader getString2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString2StringMap :mPropertySettings];
}
@end
// CLASSID: 40978
@implementation    PGSShowURL
@synthesize  url=mUrl;
@synthesize  actionType=mActionType;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SHOWURL;
        mUrl = [[NSString alloc] init];
         mActionType = 0;
     }
    return self;
}
-(void) dealloc{
    [mUrl release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.actionType = [byteArrayReader getByte];
    self.url = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByte:mActionType];
    [byteArrayWriter putString:mUrl];
}
@end
// CLASSID: 40980
@implementation    PGSGameServerProperties
@synthesize  peerId=mPeerId;
@synthesize  ipAddress=mIpAddress;
@synthesize  portNumber=mPortNumber;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_GAMESERVERPROPERTIES;
        mPeerId = 0;
         mIpAddress = [[NSString alloc] init];
         mPortNumber = 0;
     }
    return self;
}
-(void) dealloc{
    [mIpAddress release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.ipAddress = [byteArrayReader getString];
    self.peerId = [byteArrayReader getInt];
    self.portNumber = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mIpAddress];
    [byteArrayWriter putInt:mPeerId];
    [byteArrayWriter putInt:mPortNumber];
}
@end
// CLASSID: 40981
@implementation    PGSServerTime
@synthesize  clientTickCount=mClientTickCount;
@synthesize  serverClock=mServerClock;
@synthesize  timeEST=mTimeEST;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SERVERTIME;
        mClientTickCount = 0;
         mServerClock = 0;
         mTimeEST = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.clientTickCount = [byteArrayReader getInt64];
    self.serverClock = [byteArrayReader getInt64];
    self.timeEST = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mClientTickCount];
    [byteArrayWriter putInt64:mServerClock];
    [byteArrayWriter putInt64:mTimeEST];
}
@end
// CLASSID: 40982
@implementation    PGSKeyValuePair
@synthesize  key=mKey;
@synthesize  value=mValue;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_KEYVALUEPAIR;
        mKey = [[NSString alloc] init];
         mValue = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mKey release];
    [mValue release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.key = [byteArrayReader getString];
    self.value = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mKey];
    [byteArrayWriter putString:mValue];
}
@end
// CLASSID: 40983
@implementation    PGSPopUpInfoEx
@synthesize  infoType=mInfoType;
@synthesize  popUpMsg=mPopUpMsg;
@synthesize  interval=mInterval;
@synthesize  appearance=mAppearance;
@synthesize  contentType=mContentType;
@synthesize  icon=mIcon;
@synthesize  buttons=mButtons;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_POPUPINFOEX;
        mInfoType = 0;
         mPopUpMsg = [[NSString alloc] init];
         mInterval = 0;
         mAppearance = 0;
         mContentType = 0;
         mIcon = 0;
         mButtons = 0;
     }
    return self;
}
-(void) dealloc{
    [mPopUpMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.appearance = [byteArrayReader getInt];
    self.buttons = [byteArrayReader getInt];
    self.contentType = [byteArrayReader getInt];
    self.icon = [byteArrayReader getInt];
    self.infoType = [byteArrayReader getInt];
    self.interval = [byteArrayReader getInt];
    self.popUpMsg = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mAppearance];
    [byteArrayWriter putInt:mButtons];
    [byteArrayWriter putInt:mContentType];
    [byteArrayWriter putInt:mIcon];
    [byteArrayWriter putInt:mInfoType];
    [byteArrayWriter putInt:mInterval];
    [byteArrayWriter putString:mPopUpMsg];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 40984
@implementation    PGSPopUpInfoExResponse
@synthesize  infoType=mInfoType;
@synthesize  buttonPressed=mButtonPressed;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_POPUPINFOEXRESPONSE;
        mInfoType = 0;
         mButtonPressed = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.buttonPressed = [byteArrayReader getInt];
    self.infoType = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mButtonPressed];
    [byteArrayWriter putInt:mInfoType];
}
@end
// CLASSID: 40985
@implementation    PGSClientConfig
@synthesize  iniFileType=mIniFileType;
@synthesize  shouldRestart=mShouldRestart;
@synthesize  config=mConfig;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CLIENTCONFIG;
        mIniFileType = 0;
         mShouldRestart = 0;
         mConfig = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mConfig release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.config = [byteArrayReader getString];
    self.iniFileType = [byteArrayReader getByte];
    self.shouldRestart = [byteArrayReader getByte];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mConfig];
    [byteArrayWriter putByte:mIniFileType];
    [byteArrayWriter putByte:mShouldRestart];
}
@end
// CLASSID: 40987
@implementation    PGSUserPropertySettings
@synthesize  propertySettings=mPropertySettings;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_USERPROPERTYSETTINGS;
        mPropertySettings = [[NSMutableDictionary alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mPropertySettings release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.propertySettings = [byteArrayReader getString2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString2StringMap :mPropertySettings];
}
@end
// CLASSID: 40988
@implementation    PGSInstallLowLevelHook
@synthesize  sourceUrl=mSourceUrl;
@synthesize  md5sumOfLowLevelHook=mMd5sumOfLowLevelHook;
@synthesize  installationMode=mInstallationMode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_INSTALLLOWLEVELHOOK;
        mSourceUrl = [[NSString alloc] init];
         mMd5sumOfLowLevelHook = [[NSString alloc] init];
         mInstallationMode = 0;
     }
    return self;
}
-(void) dealloc{
    [mSourceUrl release];
    [mMd5sumOfLowLevelHook release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.installationMode = [byteArrayReader getInt];
    self.md5sumOfLowLevelHook = [byteArrayReader getString];
    self.sourceUrl = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mInstallationMode];
    [byteArrayWriter putString:mMd5sumOfLowLevelHook];
    [byteArrayWriter putString:mSourceUrl];
}
@end
// CLASSID: 40989
@implementation    PGSRegProfile
@synthesize  profile=mProfile;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REGPROFILE;
        mProfile = [[NSData alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mProfile release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.profile = [byteArrayReader getByteArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByteArray:mProfile];
}
@end
// CLASSID: 40990
@implementation    PGSDynamicDLLRequest
@synthesize  reason=mReason;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DYNAMICDLLREQUEST;
        mReason = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.reason = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mReason];
}
@end
// CLASSID: 40991
@implementation    PGSInstallDynamicDLL
@synthesize  sourceUrl=mSourceUrl;
@synthesize  md5sumOfDynamicDLL=mMd5sumOfDynamicDLL;
@synthesize  installationMode=mInstallationMode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_INSTALLDYNAMICDLL;
        mSourceUrl = [[NSString alloc] init];
         mMd5sumOfDynamicDLL = [[NSString alloc] init];
         mInstallationMode = 0;
     }
    return self;
}
-(void) dealloc{
    [mSourceUrl release];
    [mMd5sumOfDynamicDLL release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.installationMode = [byteArrayReader getInt];
    self.md5sumOfDynamicDLL = [byteArrayReader getString];
    self.sourceUrl = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mInstallationMode];
    [byteArrayWriter putString:mMd5sumOfDynamicDLL];
    [byteArrayWriter putString:mSourceUrl];
}
@end
// CLASSID: 40992
@implementation    PGSShowScreenResponse
@synthesize  screenType=mScreenType;
@synthesize  selectedOption=mSelectedOption;
@synthesize  isMandatory=mIsMandatory;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SHOWSCREENRESPONSE;
        mScreenType = 0;
         mSelectedOption = 0;
         mIsMandatory = NO;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.isMandatory = [byteArrayReader getBOOL];
    self.screenType = [byteArrayReader getInt];
    self.selectedOption = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mIsMandatory];
    [byteArrayWriter putInt:mScreenType];
    [byteArrayWriter putInt:mSelectedOption];
}
@end
// CLASSID: 40994
@implementation    PGSPanelMessage
@synthesize  panelArea=mPanelArea;
@synthesize  message=mMessage;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_PANELMESSAGE;
        mPanelArea = 0;
         mMessage = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMessage release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.message = [byteArrayReader getString];
    self.panelArea = [byteArrayReader getByte];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mMessage];
    [byteArrayWriter putByte:mPanelArea];
}
@end
// CLASSID: 40995
@implementation    PGSUserPersonalInfo
@synthesize  accountName=mAccountName;
@synthesize  title=mTitle;
@synthesize  firstName=mFirstName;
@synthesize  lastName=mLastName;
@synthesize  dob=mDob;
@synthesize  phoneNumber=mPhoneNumber;
@synthesize  address=mAddress;
@synthesize  city=mCity;
@synthesize  state=mState;
@synthesize  zipCode=mZipCode;
@synthesize  country=mCountry;
@synthesize  cityOfBirth=mCityOfBirth;
@synthesize  stateOfBirth=mStateOfBirth;
@synthesize  countryOfBirth=mCountryOfBirth;
@synthesize  mobileNumber=mMobileNumber;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_USERPERSONALINFO;
        mAccountName = [[NSString alloc] init];
         mTitle = [[NSString alloc] init];
         mFirstName = [[NSString alloc] init];
         mLastName = [[NSString alloc] init];
         mDob = [[NSString alloc] init];
         mPhoneNumber = [[NSString alloc] init];
         mAddress = [[NSString alloc] init];
         mCity = [[NSString alloc] init];
         mState = [[NSString alloc] init];
         mZipCode = [[NSString alloc] init];
         mCountry = [[NSString alloc] init];
         mCityOfBirth = [[NSString alloc] init];
         mStateOfBirth = [[NSString alloc] init];
         mCountryOfBirth = [[NSString alloc] init];
         mMobileNumber = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mAccountName release];
    [mTitle release];
    [mFirstName release];
    [mLastName release];
    [mDob release];
    [mPhoneNumber release];
    [mAddress release];
    [mCity release];
    [mState release];
    [mZipCode release];
    [mCountry release];
    [mCityOfBirth release];
    [mStateOfBirth release];
    [mCountryOfBirth release];
    [mMobileNumber release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountName = [byteArrayReader getString];
    self.address = [byteArrayReader getString];
    self.city = [byteArrayReader getString];
    self.cityOfBirth = [byteArrayReader getString];
    self.country = [byteArrayReader getString];
    self.countryOfBirth = [byteArrayReader getString];
    self.dob = [byteArrayReader getString];
    self.firstName = [byteArrayReader getString];
    self.lastName = [byteArrayReader getString];
    self.mobileNumber = [byteArrayReader getString];
    self.phoneNumber = [byteArrayReader getString];
    self.state = [byteArrayReader getString];
    self.stateOfBirth = [byteArrayReader getString];
    self.title = [byteArrayReader getString];
    self.zipCode = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mAccountName];
    [byteArrayWriter putString:mAddress];
    [byteArrayWriter putString:mCity];
    [byteArrayWriter putString:mCityOfBirth];
    [byteArrayWriter putString:mCountry];
    [byteArrayWriter putString:mCountryOfBirth];
    [byteArrayWriter putString:mDob];
    [byteArrayWriter putString:mFirstName];
    [byteArrayWriter putString:mLastName];
    [byteArrayWriter putString:mMobileNumber];
    [byteArrayWriter putString:mPhoneNumber];
    [byteArrayWriter putString:mState];
    [byteArrayWriter putString:mStateOfBirth];
    [byteArrayWriter putString:mTitle];
    [byteArrayWriter putString:mZipCode];
}
@end
// CLASSID: 40996
@implementation    PGSSystemConfigDetails
@synthesize  configDetails=mConfigDetails;
@synthesize  macAddress=mMacAddress;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SYSTEMCONFIGDETAILS;
        mConfigDetails = [[NSMutableArray alloc] init];
         mMacAddress = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mConfigDetails release];
    [mMacAddress release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.configDetails = [byteArrayReader getObjectArray];
    self.macAddress = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putObjectArray:mConfigDetails];
    [byteArrayWriter putString:mMacAddress];
}
@end
// CLASSID: 40997
@implementation    PGSDynamicStringEx
@synthesize  literalId=mLiteralId;
@synthesize  literalValue=mLiteralValue;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DYNAMICSTRINGEX;
        mLiteralId = 0;
         mLiteralValue = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mLiteralValue release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.literalId = [byteArrayReader getInt];
    self.literalValue = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mLiteralId];
    [byteArrayWriter putString:mLiteralValue];
}
@end
// CLASSID: 40998
@implementation    PGSPopUpInfoExML
@synthesize  infoType=mInfoType;
@synthesize  interval=mInterval;
@synthesize  appearance=mAppearance;
@synthesize  contentType=mContentType;
@synthesize  icon=mIcon;
@synthesize  buttons=mButtons;
@synthesize  popupTemplate=mPopupTemplate;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_POPUPINFOEXML;
        mInfoType = 0;
         mInterval = 0;
         mAppearance = 0;
         mContentType = 0;
         mIcon = 0;
         mButtons = 0;
         mPopupTemplate = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mPopupTemplate release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.appearance = [byteArrayReader getInt];
    self.buttons = [byteArrayReader getInt];
    self.contentType = [byteArrayReader getInt];
    self.icon = [byteArrayReader getInt];
    self.infoType = [byteArrayReader getInt];
    self.interval = [byteArrayReader getInt];
    self.popupTemplate = [byteArrayReader getStringExArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mAppearance];
    [byteArrayWriter putInt:mButtons];
    [byteArrayWriter putInt:mContentType];
    [byteArrayWriter putInt:mIcon];
    [byteArrayWriter putInt:mInfoType];
    [byteArrayWriter putInt:mInterval];
    [byteArrayWriter putStringExArray:mPopupTemplate];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 40999
@implementation    PGSShowScreen
@synthesize  screenType=mScreenType;
@synthesize  alertMessageToShow=mAlertMessageToShow;
@synthesize  alertMessageType=mAlertMessageType;
@synthesize  titleMessage=mTitleMessage;
@synthesize  isMandatory=mIsMandatory;
@synthesize  failureMessage=mFailureMessage;
@synthesize  cancelMessage=mCancelMessage;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SHOWSCREEN;
        mScreenType = 0;
         mAlertMessageToShow = [[PGStringEx alloc] init];
         mAlertMessageType = 0;
         mTitleMessage = [[PGStringEx alloc] init];
         mIsMandatory = NO;
         mFailureMessage = [[PGStringEx alloc] init];
         mCancelMessage = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mAlertMessageToShow release];
    [mTitleMessage release];
    [mFailureMessage release];
    [mCancelMessage release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.alertMessageToShow = [byteArrayReader getStringEx];
    self.alertMessageType = [byteArrayReader getInt];
    self.cancelMessage = [byteArrayReader getStringEx];
    self.failureMessage = [byteArrayReader getStringEx];
    self.isMandatory = [byteArrayReader getBOOL];
    self.screenType = [byteArrayReader getInt];
    self.titleMessage = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mAlertMessageToShow];
    [byteArrayWriter putInt:mAlertMessageType];
    [byteArrayWriter putStringEx:mCancelMessage];
    [byteArrayWriter putStringEx:mFailureMessage];
    [byteArrayWriter putBOOL:mIsMandatory];
    [byteArrayWriter putInt:mScreenType];
    [byteArrayWriter putStringEx:mTitleMessage];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 41000
@implementation    PGSPopUpInfo
@synthesize  infoType=mInfoType;
@synthesize  popUpMsg=mPopUpMsg;
@synthesize  interval=mInterval;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_POPUPINFO;
        mInfoType = 0;
         mPopUpMsg = [[PGStringEx alloc] init];
         mInterval = 0;
     }
    return self;
}
-(void) dealloc{
    [mPopUpMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.infoType = [byteArrayReader getInt];
    self.interval = [byteArrayReader getInt];
    self.popUpMsg = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mInfoType];
    [byteArrayWriter putInt:mInterval];
    [byteArrayWriter putStringEx:mPopUpMsg];
}
@end
// CLASSID: 41001
@implementation    PGSPromptLogin
@synthesize  alertMessageToShow=mAlertMessageToShow;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_PROMPTLOGIN;
        mAlertMessageToShow = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mAlertMessageToShow release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.alertMessageToShow = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mAlertMessageToShow];
}
@end
// CLASSID: 41002
@implementation    PGSOldUpgradeInfo
@synthesize  upgradeType=mUpgradeType;
@synthesize  upgradeURL=mUpgradeURL;
@synthesize  upgradeMsg=mUpgradeMsg;
@synthesize  minorBuildNumber=mMinorBuildNumber;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_OLDUPGRADEINFO;
        mUpgradeType = 0;
         mUpgradeURL = [[NSString alloc] init];
         mUpgradeMsg = [[PGStringEx alloc] init];
         mMinorBuildNumber = 0;
     }
    return self;
}
-(void) dealloc{
    [mUpgradeURL release];
    [mUpgradeMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.minorBuildNumber = [byteArrayReader getInt];
    self.upgradeMsg = [byteArrayReader getStringEx];
    self.upgradeType = [byteArrayReader getInt];
    self.upgradeURL = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mMinorBuildNumber];
    [byteArrayWriter putStringEx:mUpgradeMsg];
    [byteArrayWriter putInt:mUpgradeType];
    [byteArrayWriter putString:mUpgradeURL];
}
@end
// CLASSID: 41003
@implementation    PGSPromptScreenName
@synthesize  requestId=mRequestId;
@synthesize  suggestedScreenName=mSuggestedScreenName;
@synthesize  desc=mDesc;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_PROMPTSCREENNAME;
        mRequestId = 0;
         mSuggestedScreenName = [[NSString alloc] init];
         mDesc = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mSuggestedScreenName release];
    [mDesc release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.desc = [byteArrayReader getStringEx];
    self.requestId = [byteArrayReader getInt];
    self.suggestedScreenName = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mDesc];
    [byteArrayWriter putInt:mRequestId];
    [byteArrayWriter putString:mSuggestedScreenName];
}
@end
// CLASSID: 41005
@implementation    PGSDownloadAndExecute
@synthesize  silent=mSilent;
@synthesize  url=mUrl;
@synthesize  context=mContext;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DOWNLOADANDEXECUTE;
        mSilent = NO;
         mUrl = [[NSString alloc] init];
         mContext = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mUrl release];
    [mContext release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.context = [byteArrayReader getStringEx];
    self.silent = [byteArrayReader getBOOL];
    self.url = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mContext];
    [byteArrayWriter putBOOL:mSilent];
    [byteArrayWriter putString:mUrl];
}
@end
// CLASSID: 41006
@implementation    PGSUpgradeInfo
@synthesize  upgradeType=mUpgradeType;
@synthesize  upgradeURL=mUpgradeURL;
@synthesize  upgradeMsg=mUpgradeMsg;
@synthesize  minorBuildNumber=mMinorBuildNumber;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_UPGRADEINFO;
        mUpgradeType = 0;
         mUpgradeURL = [[NSMutableArray alloc] init];
         mUpgradeMsg = [[PGStringEx alloc] init];
         mMinorBuildNumber = 0;
     }
    return self;
}
-(void) dealloc{
    [mUpgradeURL release];
    [mUpgradeMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.minorBuildNumber = [byteArrayReader getInt];
    self.upgradeMsg = [byteArrayReader getStringEx];
    self.upgradeType = [byteArrayReader getInt];
    self.upgradeURL = [byteArrayReader getStringArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mMinorBuildNumber];
    [byteArrayWriter putStringEx:mUpgradeMsg];
    [byteArrayWriter putInt:mUpgradeType];
    [byteArrayWriter putStringArray:mUpgradeURL];
}
@end
// CLASSID: 41007
@implementation    PGSUserAvatarInfo
@synthesize  avatarId=mAvatarId;
@synthesize  isCustomEnabled=mIsCustomEnabled;
@synthesize  avatarMD5Sum=mAvatarMD5Sum;
@synthesize  firstUploadedInCycle=mFirstUploadedInCycle;
@synthesize  uploadsRemaining=mUploadsRemaining;
@synthesize  avatarDetails=mAvatarDetails;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_USERAVATARINFO;
        mAvatarId = 0;
         mIsCustomEnabled = NO;
         mAvatarMD5Sum = [[NSString alloc] init];
         mFirstUploadedInCycle = 0;
         mUploadsRemaining = 0;
         mAvatarDetails = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mAvatarMD5Sum release];
    [mAvatarDetails release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.avatarId = [byteArrayReader getInt];
    self.avatarMD5Sum = [byteArrayReader getString];
    self.avatarDetails = [byteArrayReader getObjectArray];
    self.firstUploadedInCycle = [byteArrayReader getInt64];
    self.isCustomEnabled = [byteArrayReader getBOOL];
    self.uploadsRemaining = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mAvatarId];
    [byteArrayWriter putString:mAvatarMD5Sum];
    [byteArrayWriter putObjectArray:mAvatarDetails];
    [byteArrayWriter putInt64:mFirstUploadedInCycle];
    [byteArrayWriter putBOOL:mIsCustomEnabled];
    [byteArrayWriter putInt:mUploadsRemaining];
}
@end
// CLASSID: 41008
@implementation    PGSUserProfile
@synthesize  loginId=mLoginId;
@synthesize  accountName=mAccountName;
@synthesize  screenName=mScreenName;
@synthesize  webMasterId=mWebMasterId;
@synthesize  referer=mReferer;
@synthesize  mailId=mMailId;
@synthesize  firstName=mFirstName;
@synthesize  lastName=mLastName;
@synthesize  sex=mSex;
@synthesize  mailingAddress=mMailingAddress;
@synthesize  bonusCode=mBonusCode;
@synthesize  IsValidated=mIsValidated;
@synthesize  frontendId=mFrontendId;
@synthesize  city=mCity;
@synthesize  canShowPersonalInfo=mCanShowPersonalInfo;
@synthesize  userInfo=mUserInfo;
@synthesize  hearFrom=mHearFrom;
@synthesize  showCity=mShowCity;
@synthesize  encProfile=mEncProfile;
@synthesize  channelId=mChannelId;
@synthesize  sessionLanguageId=mSessionLanguageId;
@synthesize  accountLanguageId=mAccountLanguageId;
@synthesize  accountCurrencyCode=mAccountCurrencyCode;
@synthesize  locale=mLocale;
@synthesize  brandId=mBrandId;
@synthesize  isPMCEnabled=mIsPMCEnabled;
@synthesize  accountStatus=mAccountStatus;
@synthesize  isPointsEnabled=mIsPointsEnabled;
@synthesize  partyPointsCategory=mPartyPointsCategory;
@synthesize  avatarInfo=mAvatarInfo;
@synthesize  userTimeZoneId=mUserTimeZoneId;
@synthesize  vipStatus=mVipStatus;
@synthesize  suspiciousLocationLoginStatus=mSuspiciousLocationLoginStatus;
@synthesize  documentValidationStatus=mDocumentValidationStatus;
@synthesize  daysPassedAfterRealAccountCreation=mDaysPassedAfterRealAccountCreation;
@synthesize  invID=mInvID;
@synthesize  promoID=mPromoID;
@synthesize  playerJurisdiction=mPlayerJurisdiction;
@synthesize  kycStatus=mKycStatus;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_USERPROFILE;
        mLoginId = [[NSString alloc] init];
         mAccountName = [[NSString alloc] init];
         mScreenName = [[NSString alloc] init];
         mWebMasterId = 0;
         mReferer = [[NSString alloc] init];
         mMailId = [[NSString alloc] init];
         mFirstName = [[NSString alloc] init];
         mLastName = [[NSString alloc] init];
         mSex = [[NSString alloc] init];
         mMailingAddress = [[NSString alloc] init];
         mBonusCode = [[NSString alloc] init];
         mIsValidated = NO;
         mFrontendId = [[NSString alloc] init];
         mCity = [[NSString alloc] init];
         mCanShowPersonalInfo = NO;
         mUserInfo = [[PGSUserPersonalInfo alloc] init];
         mHearFrom = [[NSString alloc] init];
         mShowCity = NO;
         mEncProfile = [[NSData alloc] init];
         mChannelId = [[NSString alloc] init];
         mSessionLanguageId = [[NSString alloc] init];
         mAccountLanguageId = [[NSString alloc] init];
         mAccountCurrencyCode = [[NSString alloc] init];
         mLocale = [[NSString alloc] init];
         mBrandId = [[NSString alloc] init];
         mIsPMCEnabled = NO;
         mAccountStatus = 0;
         mIsPointsEnabled = NO;
         mPartyPointsCategory = [[NSString alloc] init];
         mAvatarInfo = [[PGSUserAvatarInfo alloc] init];
         mUserTimeZoneId = [[NSString alloc] init];
         mVipStatus = [[NSString alloc] init];
         mSuspiciousLocationLoginStatus = NO;
         mDocumentValidationStatus = [[NSString alloc] init];
         mDaysPassedAfterRealAccountCreation = 0;
         mInvID = [[NSString alloc] init];
         mPromoID = [[NSString alloc] init];
         mPlayerJurisdiction = [[NSString alloc] init];
         mKycStatus = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mLoginId release];
    [mAccountName release];
    [mScreenName release];
    [mReferer release];
    [mMailId release];
    [mFirstName release];
    [mLastName release];
    [mSex release];
    [mMailingAddress release];
    [mBonusCode release];
    [mFrontendId release];
    [mCity release];
    [mUserInfo release];
    [mHearFrom release];
    [mEncProfile release];
    [mChannelId release];
    [mSessionLanguageId release];
    [mAccountLanguageId release];
    [mAccountCurrencyCode release];
    [mLocale release];
    [mBrandId release];
    [mPartyPointsCategory release];
    [mAvatarInfo release];
    [mUserTimeZoneId release];
    [mVipStatus release];
    [mDocumentValidationStatus release];
    [mInvID release];
    [mPromoID release];
    [mPlayerJurisdiction release];
    [mKycStatus release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.IsValidated = [byteArrayReader getBOOL];
    self.accountCurrencyCode = [byteArrayReader getString];
    self.accountLanguageId = [byteArrayReader getString];
    self.accountName = [byteArrayReader getString];
    self.accountStatus = [byteArrayReader getByte];
    self.avatarInfo = [byteArrayReader getObject];
    self.bonusCode = [byteArrayReader getString];
    self.brandId = [byteArrayReader getString];
    self.canShowPersonalInfo = [byteArrayReader getBOOL];
    self.channelId = [byteArrayReader getString];
    self.city = [byteArrayReader getString];
    self.daysPassedAfterRealAccountCreation = [byteArrayReader getInt];
    self.documentValidationStatus = [byteArrayReader getString];
    self.encProfile = [byteArrayReader getByteArray];
    self.firstName = [byteArrayReader getString];
    self.frontendId = [byteArrayReader getString];
    self.hearFrom = [byteArrayReader getString];
    self.isPMCEnabled = [byteArrayReader getBOOL];
    self.isPointsEnabled = [byteArrayReader getBOOL];
    self.lastName = [byteArrayReader getString];
    self.locale = [byteArrayReader getString];
    self.loginId = [byteArrayReader getString];
    self.mailId = [byteArrayReader getString];
    self.mailingAddress = [byteArrayReader getString];
    self.partyPointsCategory = [byteArrayReader getString];
    self.referer = [byteArrayReader getString];
    self.screenName = [byteArrayReader getString];
    self.sessionLanguageId = [byteArrayReader getString];
    self.sex = [byteArrayReader getString];
    self.showCity = [byteArrayReader getBOOL];
    self.suspiciousLocationLoginStatus = [byteArrayReader getBOOL];
    self.userInfo = [byteArrayReader getObject];
    self.userTimeZoneId = [byteArrayReader getString];
    self.vipStatus = [byteArrayReader getString];
    self.webMasterId = [byteArrayReader getInt];
    self.invID = [byteArrayReader getString];
    self.promoID = [byteArrayReader getString];
    self.playerJurisdiction = [byteArrayReader getString];
    self.kycStatus = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mIsValidated];
    [byteArrayWriter putString:mAccountCurrencyCode];
    [byteArrayWriter putString:mAccountLanguageId];
    [byteArrayWriter putString:mAccountName];
    [byteArrayWriter putByte:mAccountStatus];
    [byteArrayWriter putObject:mAvatarInfo];
    [byteArrayWriter putString:mBonusCode];
    [byteArrayWriter putString:mBrandId];
    [byteArrayWriter putBOOL:mCanShowPersonalInfo];
    [byteArrayWriter putString:mChannelId];
    [byteArrayWriter putString:mCity];
    [byteArrayWriter putInt:mDaysPassedAfterRealAccountCreation];
    [byteArrayWriter putString:mDocumentValidationStatus];
    [byteArrayWriter putByteArray:mEncProfile];
    [byteArrayWriter putString:mFirstName];
    [byteArrayWriter putString:mFrontendId];
    [byteArrayWriter putString:mHearFrom];
    [byteArrayWriter putBOOL:mIsPMCEnabled];
    [byteArrayWriter putBOOL:mIsPointsEnabled];
    [byteArrayWriter putString:mLastName];
    [byteArrayWriter putString:mLocale];
    [byteArrayWriter putString:mLoginId];
    [byteArrayWriter putString:mMailId];
    [byteArrayWriter putString:mMailingAddress];
    [byteArrayWriter putString:mPartyPointsCategory];
    [byteArrayWriter putString:mReferer];
    [byteArrayWriter putString:mScreenName];
    [byteArrayWriter putString:mSessionLanguageId];
    [byteArrayWriter putString:mSex];
    [byteArrayWriter putBOOL:mShowCity];
    [byteArrayWriter putBOOL:mSuspiciousLocationLoginStatus];
    [byteArrayWriter putObject:mUserInfo];
    [byteArrayWriter putString:mUserTimeZoneId];
    [byteArrayWriter putString:mVipStatus];
    [byteArrayWriter putInt:mWebMasterId];
    [byteArrayWriter putString:mInvID];
    [byteArrayWriter putString:mPromoID];
    [byteArrayWriter putString:mPlayerJurisdiction];
    [byteArrayWriter putString:mKycStatus];
}
@end
// CLASSID: 41009
@implementation    PGSLoginResponse
@synthesize  responseId=mResponseId;
@synthesize  userProfile=mUserProfile;
@synthesize  isRealMoneyAccountActivated=mIsRealMoneyAccountActivated;
@synthesize  desc=mDesc;
@synthesize  keyM1=mKeyM1;
@synthesize  accountName=mAccountName;
@synthesize  failedLoginAttemptCount=mFailedLoginAttemptCount;
@synthesize  showCaptcha=mShowCaptcha;
@synthesize  conversationId=mConversationId;
@synthesize  screenName=mScreenName;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOGINRESPONSE;
        mResponseId = 0;
         mUserProfile = [[PGSUserProfile alloc] init];
         mIsRealMoneyAccountActivated = NO;
         mDesc = [[PGStringEx alloc] init];
         mKeyM1 = [[NSString alloc] init];
         mAccountName = [[NSString alloc] init];
         mFailedLoginAttemptCount = 0;
         mShowCaptcha = NO;
         mConversationId = 0;
         mScreenName = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mUserProfile release];
    [mDesc release];
    [mKeyM1 release];
    [mAccountName release];
    [mScreenName release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountName = [byteArrayReader getString];
    self.conversationId = [byteArrayReader getInt64];
    self.desc = [byteArrayReader getStringEx];
    self.failedLoginAttemptCount = [byteArrayReader getByte];
    self.isRealMoneyAccountActivated = [byteArrayReader getBOOL];
    self.keyM1 = [byteArrayReader getString];
    self.responseId = [byteArrayReader getInt];
    self.screenName = [byteArrayReader getString];
    self.showCaptcha = [byteArrayReader getBOOL];
    self.userProfile = [byteArrayReader getObject];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mAccountName];
    [byteArrayWriter putInt64:mConversationId];
    [byteArrayWriter putStringEx:mDesc];
    [byteArrayWriter putByte:mFailedLoginAttemptCount];
    [byteArrayWriter putBOOL:mIsRealMoneyAccountActivated];
    [byteArrayWriter putString:mKeyM1];
    [byteArrayWriter putInt:mResponseId];
    [byteArrayWriter putString:mScreenName];
    [byteArrayWriter putBOOL:mShowCaptcha];
    [byteArrayWriter putObject:mUserProfile];
}
@end
// CLASSID: 41010
@implementation    PGSRegistration
@synthesize  profile=mProfile;
@synthesize  password=mPassword;
@synthesize  isEmailOptin=mIsEmailOptin;
@synthesize  isFirstRequest=mIsFirstRequest;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REGISTRATION;
        mProfile = [[PGSUserProfile alloc] init];
         mPassword = [[NSString alloc] init];
         mIsEmailOptin = NO;
         mIsFirstRequest = NO;
     }
    return self;
}
-(void) dealloc{
    [mProfile release];
    [mPassword release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.isEmailOptin = [byteArrayReader getBOOL];
    self.isFirstRequest = [byteArrayReader getBOOL];
    self.password = [byteArrayReader getString];
    self.profile = [byteArrayReader getObject];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mIsEmailOptin];
    [byteArrayWriter putBOOL:mIsFirstRequest];
    [byteArrayWriter putString:mPassword];
    [byteArrayWriter putObject:mProfile];
}
-(BOOL) isBlocked { return YES;};
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 41011
@implementation    PGSSendProfile
@synthesize  responseId=mResponseId;
@synthesize  userProfile=mUserProfile;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SENDPROFILE;
        mResponseId = 0;
         mUserProfile = [[PGSUserProfile alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mUserProfile release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.responseId = [byteArrayReader getInt];
    self.userProfile = [byteArrayReader getObject];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mResponseId];
    [byteArrayWriter putObject:mUserProfile];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 41012
@implementation    PGSUserInfo
@synthesize  profile=mProfile;
@synthesize  opcode=mOpcode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_USERINFO;
        mProfile = [[PGSUserProfile alloc] init];
         mOpcode = 0;
     }
    return self;
}
-(void) dealloc{
    [mProfile release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.opcode = [byteArrayReader getInt];
    self.profile = [byteArrayReader getObject];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mOpcode];
    [byteArrayWriter putObject:mProfile];
}
@end
// CLASSID: 41013
@implementation    PGSGetPAMArticleContentFiles
@synthesize  articleLanguageIds=mArticleLanguageIds;
@synthesize  isPersonal=mIsPersonal;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_GETPAMARTICLECONTENTFILES;
        mArticleLanguageIds = [[NSMutableDictionary alloc] init];
         mIsPersonal = NO;
     }
    return self;
}
-(void) dealloc{
    [mArticleLanguageIds release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.articleLanguageIds = [byteArrayReader getInt2StringMap ];
    self.isPersonal = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt2StringMap :mArticleLanguageIds];
    [byteArrayWriter putBOOL:mIsPersonal];
}
@end
// CLASSID: 41014
@implementation    PGSSaveFile
@synthesize  fileContent=mFileContent;
@synthesize  fileName=mFileName;
@synthesize  location=mLocation;
@synthesize  languageId=mLanguageId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SAVEFILE;
        mFileContent = [[NSData alloc] init];
         mFileName = [[NSString alloc] init];
         mLocation = [[NSString alloc] init];
         mLanguageId = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mFileContent release];
    [mFileName release];
    [mLocation release];
    [mLanguageId release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.fileContent = [byteArrayReader getByteArray];
    self.fileName = [byteArrayReader getString];
    self.languageId = [byteArrayReader getString];
    self.location = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByteArray:mFileContent];
    [byteArrayWriter putString:mFileName];
    [byteArrayWriter putString:mLanguageId];
    [byteArrayWriter putString:mLocation];
}
@end
// CLASSID: 41015
@implementation    PGSLanguagePackUpdate
@synthesize  upgradeURL=mUpgradeURL;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LANGUAGEPACKUPDATE;
        mUpgradeURL = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mUpgradeURL release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.upgradeURL = [byteArrayReader getStringArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringArray:mUpgradeURL];
}
@end
// CLASSID: 41016
@implementation    PGSDynamicLanguagePackUpdate
@synthesize  literalsMap=mLiteralsMap;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DYNAMICLANGUAGEPACKUPDATE;
        mLiteralsMap = [[NSMutableDictionary alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mLiteralsMap release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.literalsMap = [byteArrayReader getInt2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt2StringMap :mLiteralsMap];
}
@end
// CLASSID: 41017
@implementation    PGSClientMD5Sum
@synthesize  sumType=mSumType;
@synthesize  checkSumList=mCheckSumList;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CLIENTMD5SUM;
        mSumType = 0;
         mCheckSumList = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mCheckSumList release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.checkSumList = [byteArrayReader getStringArray];
    self.sumType = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringArray:mCheckSumList];
    [byteArrayWriter putInt:mSumType];
}
@end
// CLASSID: 41018
@implementation    PGSCurrencyDetailsRequest
@synthesize  currencyCodes=mCurrencyCodes;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CURRENCYDETAILSREQUEST;
        mCurrencyCodes = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mCurrencyCodes release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.currencyCodes = [byteArrayReader getStringArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringArray:mCurrencyCodes];
}
@end
// CLASSID: 41019
@implementation    PGSFXRateRequest
@synthesize  fromCurrencyCode=mFromCurrencyCode;
@synthesize  toCurrencyCode=mToCurrencyCode;
@synthesize  snapshotId=mSnapshotId;
@synthesize  markupType=mMarkupType;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_FXRATEREQUEST;
        mFromCurrencyCode = [[NSString alloc] init];
         mToCurrencyCode = [[NSString alloc] init];
         mSnapshotId = 0;
         mMarkupType = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mFromCurrencyCode release];
    [mToCurrencyCode release];
    [mMarkupType release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.fromCurrencyCode = [byteArrayReader getString];
    self.markupType = [byteArrayReader getString];
    self.snapshotId = [byteArrayReader getInt64];
    self.toCurrencyCode = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mFromCurrencyCode];
    [byteArrayWriter putString:mMarkupType];
    [byteArrayWriter putInt64:mSnapshotId];
    [byteArrayWriter putString:mToCurrencyCode];
}
@end
// CLASSID: 41020
@implementation    PGSCurrencyDetailsList
@synthesize  currencies=mCurrencies;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CURRENCYDETAILSLIST;
        mCurrencies = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mCurrencies release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.currencies = [byteArrayReader getObjectArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putObjectArray:mCurrencies];
}
@end
// CLASSID: 41021
@implementation    PGSFXRateDetails
@synthesize  snapshotId=mSnapshotId;
@synthesize  markupType=mMarkupType;
@synthesize  fromCurrencyCode=mFromCurrencyCode;
@synthesize  toCurrencyCode=mToCurrencyCode;
@synthesize  conversionFactor4Client=mConversionFactor4Client;
@synthesize  reverseConversionFactor4Client=mReverseConversionFactor4Client;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_FXRATEDETAILS;
        mSnapshotId = 0;
         mMarkupType = [[NSString alloc] init];
         mFromCurrencyCode = [[NSString alloc] init];
         mToCurrencyCode = [[NSString alloc] init];
         mConversionFactor4Client = 0;
         mReverseConversionFactor4Client = 0;
     }
    return self;
}
-(void) dealloc{
    [mMarkupType release];
    [mFromCurrencyCode release];
    [mToCurrencyCode release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.conversionFactor4Client = [byteArrayReader getInt64];
    self.fromCurrencyCode = [byteArrayReader getString];
    self.markupType = [byteArrayReader getString];
    self.reverseConversionFactor4Client = [byteArrayReader getInt64];
    self.snapshotId = [byteArrayReader getInt64];
    self.toCurrencyCode = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mConversionFactor4Client];
    [byteArrayWriter putString:mFromCurrencyCode];
    [byteArrayWriter putString:mMarkupType];
    [byteArrayWriter putInt64:mReverseConversionFactor4Client];
    [byteArrayWriter putInt64:mSnapshotId];
    [byteArrayWriter putString:mToCurrencyCode];
}
@end
// CLASSID: 41022
@implementation    PGSFXRateSnapshot
@synthesize  snapshotId=mSnapshotId;
@synthesize  fxRates=mFxRates;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_FXRATESNAPSHOT;
        mSnapshotId = 0;
         mFxRates = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mFxRates release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.fxRates = [byteArrayReader getObjectArray];
    self.snapshotId = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putObjectArray:mFxRates];
    [byteArrayWriter putInt64:mSnapshotId];
}
@end
// CLASSID: 41023
@implementation    PGSCurrencyDetails
@synthesize  code=mCode;
@synthesize  symbol=mSymbol;
@synthesize  name=mName;
@synthesize  defaultFractionDigits=mDefaultFractionDigits;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CURRENCYDETAILS;
        mCode = [[NSString alloc] init];
         mSymbol = [[NSString alloc] init];
         mName = [[NSString alloc] init];
         mDefaultFractionDigits = 0;
     }
    return self;
}
-(void) dealloc{
    [mCode release];
    [mSymbol release];
    [mName release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.code = [byteArrayReader getString];
    self.defaultFractionDigits = [byteArrayReader getInt];
    self.name = [byteArrayReader getString];
    self.symbol = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mCode];
    [byteArrayWriter putInt:mDefaultFractionDigits];
    [byteArrayWriter putString:mName];
    [byteArrayWriter putString:mSymbol];
}
@end
// CLASSID: 41024
@implementation    PGSFXConversionFactor
@synthesize  markupType=mMarkupType;
@synthesize  conversionFactor4Client=mConversionFactor4Client;
@synthesize  reverseConversionFactor4Client=mReverseConversionFactor4Client;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_FXCONVERSIONFACTOR;
        mMarkupType = [[NSString alloc] init];
         mConversionFactor4Client = 0;
         mReverseConversionFactor4Client = 0;
     }
    return self;
}
-(void) dealloc{
    [mMarkupType release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.conversionFactor4Client = [byteArrayReader getInt64];
    self.markupType = [byteArrayReader getString];
    self.reverseConversionFactor4Client = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mConversionFactor4Client];
    [byteArrayWriter putString:mMarkupType];
    [byteArrayWriter putInt64:mReverseConversionFactor4Client];
}
@end
// CLASSID: 41025
@implementation    PGSFXRateData
@synthesize  fromCurrencyCode=mFromCurrencyCode;
@synthesize  toCurrencyCode=mToCurrencyCode;
@synthesize  factors=mFactors;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_FXRATEDATA;
        mFromCurrencyCode = [[NSString alloc] init];
         mToCurrencyCode = [[NSString alloc] init];
         mFactors = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mFromCurrencyCode release];
    [mToCurrencyCode release];
    [mFactors release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.factors = [byteArrayReader getObjectArray];
    self.fromCurrencyCode = [byteArrayReader getString];
    self.toCurrencyCode = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putObjectArray:mFactors];
    [byteArrayWriter putString:mFromCurrencyCode];
    [byteArrayWriter putString:mToCurrencyCode];
}
@end
// CLASSID: 41026
@implementation    PGSCurrencyAmount
@synthesize  currencyCode=mCurrencyCode;
@synthesize  amount=mAmount;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CURRENCYAMOUNT;
        mCurrencyCode = [[NSString alloc] init];
         mAmount = 0;
     }
    return self;
}
-(void) dealloc{
    [mCurrencyCode release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.amount = [byteArrayReader getInt64];
    self.currencyCode = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mAmount];
    [byteArrayWriter putString:mCurrencyCode];
}
@end
// CLASSID: 41027
@implementation    PGSCulturalFormat
@synthesize  locale=mLocale;
@synthesize  numberFormat=mNumberFormat;
@synthesize  currencyFormatSymbol=mCurrencyFormatSymbol;
@synthesize  currencyFormatCode=mCurrencyFormatCode;
@synthesize  currencyFormatName=mCurrencyFormatName;
@synthesize  currencyFormatSymbolCode=mCurrencyFormatSymbolCode;
@synthesize  currencyFormatSymbolName=mCurrencyFormatSymbolName;
@synthesize  currencyFormatCodeName=mCurrencyFormatCodeName;
@synthesize  dateFormatLong=mDateFormatLong;
@synthesize  dateFormatShort=mDateFormatShort;
@synthesize  time24Hours=mTime24Hours;
@synthesize  defaultFormat=mDefaultFormat;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CULTURALFORMAT;
        mLocale = [[NSString alloc] init];
         mNumberFormat = [[NSString alloc] init];
         mCurrencyFormatSymbol = [[NSString alloc] init];
         mCurrencyFormatCode = [[NSString alloc] init];
         mCurrencyFormatName = [[NSString alloc] init];
         mCurrencyFormatSymbolCode = [[NSString alloc] init];
         mCurrencyFormatSymbolName = [[NSString alloc] init];
         mCurrencyFormatCodeName = [[NSString alloc] init];
         mDateFormatLong = [[NSString alloc] init];
         mDateFormatShort = [[NSString alloc] init];
         mTime24Hours = NO;
         mDefaultFormat = NO;
     }
    return self;
}
-(void) dealloc{
    [mLocale release];
    [mNumberFormat release];
    [mCurrencyFormatSymbol release];
    [mCurrencyFormatCode release];
    [mCurrencyFormatName release];
    [mCurrencyFormatSymbolCode release];
    [mCurrencyFormatSymbolName release];
    [mCurrencyFormatCodeName release];
    [mDateFormatLong release];
    [mDateFormatShort release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.currencyFormatCode = [byteArrayReader getString];
    self.currencyFormatCodeName = [byteArrayReader getString];
    self.currencyFormatName = [byteArrayReader getString];
    self.currencyFormatSymbol = [byteArrayReader getString];
    self.currencyFormatSymbolCode = [byteArrayReader getString];
    self.currencyFormatSymbolName = [byteArrayReader getString];
    self.dateFormatLong = [byteArrayReader getString];
    self.dateFormatShort = [byteArrayReader getString];
    self.defaultFormat = [byteArrayReader getBOOL];
    self.locale = [byteArrayReader getString];
    self.numberFormat = [byteArrayReader getString];
    self.time24Hours = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mCurrencyFormatCode];
    [byteArrayWriter putString:mCurrencyFormatCodeName];
    [byteArrayWriter putString:mCurrencyFormatName];
    [byteArrayWriter putString:mCurrencyFormatSymbol];
    [byteArrayWriter putString:mCurrencyFormatSymbolCode];
    [byteArrayWriter putString:mCurrencyFormatSymbolName];
    [byteArrayWriter putString:mDateFormatLong];
    [byteArrayWriter putString:mDateFormatShort];
    [byteArrayWriter putBOOL:mDefaultFormat];
    [byteArrayWriter putString:mLocale];
    [byteArrayWriter putString:mNumberFormat];
    [byteArrayWriter putBOOL:mTime24Hours];
}
@end
// CLASSID: 41028
@implementation    PGSCurrencyRollback
@synthesize  cause=mCause;
@synthesize  accountBalance=mAccountBalance;
@synthesize  currencyList=mCurrencyList;
@synthesize  fallbackCurrency=mFallbackCurrency;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CURRENCYROLLBACK;
        mCause = 0;
         mAccountBalance = 0;
         mCurrencyList = [[NSMutableArray alloc] init];
         mFallbackCurrency = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mCurrencyList release];
    [mFallbackCurrency release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountBalance = [byteArrayReader getInt64];
    self.cause = [byteArrayReader getByte];
    self.currencyList = [byteArrayReader getStringArray];
    self.fallbackCurrency = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mAccountBalance];
    [byteArrayWriter putByte:mCause];
    [byteArrayWriter putStringArray:mCurrencyList];
    [byteArrayWriter putString:mFallbackCurrency];
}
@end
// CLASSID: 41029
@implementation    PGSAccountCurrencyChange
@synthesize  currentCurrencyCode=mCurrentCurrencyCode;
@synthesize  newCurrencyCode=mNewCurrencyCode;
@synthesize  type=mType;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_ACCOUNTCURRENCYCHANGE;
        mCurrentCurrencyCode = [[NSString alloc] init];
         mNewCurrencyCode = [[NSString alloc] init];
         mType = 0;
     }
    return self;
}
-(void) dealloc{
    [mCurrentCurrencyCode release];
    [mNewCurrencyCode release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.currentCurrencyCode = [byteArrayReader getString];
    self.newCurrencyCode = [byteArrayReader getString];
    self.type = [byteArrayReader getByte];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mCurrentCurrencyCode];
    [byteArrayWriter putString:mNewCurrencyCode];
    [byteArrayWriter putByte:mType];
}
@end
// CLASSID: 41030
@implementation    PGSPreliminaryAccountCurrency
@synthesize  currencyCode=mCurrencyCode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_PRELIMINARYACCOUNTCURRENCY;
        mCurrencyCode = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mCurrencyCode release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.currencyCode = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mCurrencyCode];
}
@end
// CLASSID: 41031
@implementation    PGSAdConfigurationMessage
@synthesize  realPlacements=mRealPlacements;
@synthesize  playPlacements=mPlayPlacements;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_ADCONFIGURATIONMESSAGE;
        mRealPlacements = [[NSData alloc] init];
         mPlayPlacements = [[NSData alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mRealPlacements release];
    [mPlayPlacements release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.playPlacements = [byteArrayReader getByteArray];
    self.realPlacements = [byteArrayReader getByteArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByteArray:mPlayPlacements];
    [byteArrayWriter putByteArray:mRealPlacements];
}
@end
// CLASSID: 41032
@implementation    PGSSearchConfigurationMessage
@synthesize  searchBarRequired=mSearchBarRequired;
@synthesize  searchApplicationRequired=mSearchApplicationRequired;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SEARCHCONFIGURATIONMESSAGE;
        mSearchBarRequired = NO;
         mSearchApplicationRequired = NO;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.searchApplicationRequired = [byteArrayReader getBOOL];
    self.searchBarRequired = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mSearchApplicationRequired];
    [byteArrayWriter putBOOL:mSearchBarRequired];
}
@end
// CLASSID: 41033
@implementation    PGSAccountTemplateParam
@synthesize  params=mParams;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_ACCOUNTTEMPLATEPARAM;
        mParams = [[NSMutableDictionary alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mParams release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.params = [byteArrayReader getString2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString2StringMap :mParams];
}
@end
// CLASSID: 41034
@implementation    PGSAcceptPseudoOffer
@synthesize  eventId=mEventId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_ACCEPTPSEUDOOFFER;
        mEventId = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.eventId = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mEventId];
}
@end
// CLASSID: 41035
@implementation    PGSAlertBotDetectionFailure
@synthesize  botAlertType=mBotAlertType;
@synthesize  errorCode=mErrorCode;
@synthesize  reasonsForFailure=mReasonsForFailure;
@synthesize  dllName=mDllName;
@synthesize  md5OfExistingDLL=mMd5OfExistingDLL;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_ALERTBOTDETECTIONFAILURE;
        mBotAlertType = 0;
         mErrorCode = 0;
         mReasonsForFailure = [[NSString alloc] init];
         mDllName = [[NSString alloc] init];
         mMd5OfExistingDLL = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mReasonsForFailure release];
    [mDllName release];
    [mMd5OfExistingDLL release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.botAlertType = [byteArrayReader getInt];
    self.dllName = [byteArrayReader getString];
    self.errorCode = [byteArrayReader getInt];
    self.md5OfExistingDLL = [byteArrayReader getString];
    self.reasonsForFailure = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mBotAlertType];
    [byteArrayWriter putString:mDllName];
    [byteArrayWriter putInt:mErrorCode];
    [byteArrayWriter putString:mMd5OfExistingDLL];
    [byteArrayWriter putString:mReasonsForFailure];
}
@end
// CLASSID: 41036
@implementation    PGSPlayAllowedDays
@synthesize  optionalDaysLeft=mOptionalDaysLeft;
@synthesize  madatoryDaysLeft=mMadatoryDaysLeft;
@synthesize  isMandatory=mIsMandatory;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_PLAYALLOWEDDAYS;
        mOptionalDaysLeft = 0;
         mMadatoryDaysLeft = 0;
         mIsMandatory = NO;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.isMandatory = [byteArrayReader getBOOL];
    self.madatoryDaysLeft = [byteArrayReader getInt64];
    self.optionalDaysLeft = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mIsMandatory];
    [byteArrayWriter putInt64:mMadatoryDaysLeft];
    [byteArrayWriter putInt64:mOptionalDaysLeft];
}
@end
// CLASSID: 41039
@implementation    PGSSocialNetworkRequest
@synthesize  typeId=mTypeId;
@synthesize  users=mUsers;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SOCIALNETWORKREQUEST;
        mTypeId = 0;
         mUsers = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mUsers release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.typeId = [byteArrayReader getInt];
    self.users = [byteArrayReader getStringArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mTypeId];
    [byteArrayWriter putStringArray:mUsers];
}
@end
// CLASSID: 41040
@implementation    PGSSocialNetworkUserDetails
@synthesize  accountName=mAccountName;
@synthesize  screenName=mScreenName;
@synthesize  chipsAmount=mChipsAmount;
@synthesize  leaderboardRank=mLeaderboardRank;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SOCIALNETWORKUSERDETAILS;
        mAccountName = [[NSString alloc] init];
         mScreenName = [[NSString alloc] init];
         mChipsAmount = 0;
         mLeaderboardRank = 0;
     }
    return self;
}
-(void) dealloc{
    [mAccountName release];
    [mScreenName release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountName = [byteArrayReader getString];
    self.chipsAmount = [byteArrayReader getInt64];
    self.leaderboardRank = [byteArrayReader getInt];
    self.screenName = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mAccountName];
    [byteArrayWriter putInt64:mChipsAmount];
    [byteArrayWriter putInt:mLeaderboardRank];
    [byteArrayWriter putString:mScreenName];
}
@end
// CLASSID: 41041
@implementation    PGSLeaderboardDetails
@synthesize  typeId=mTypeId;
@synthesize  leaders=mLeaders;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LEADERBOARDDETAILS;
        mTypeId = 0;
         mLeaders = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mLeaders release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.leaders = [byteArrayReader getObjectArray];
    self.typeId = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putObjectArray:mLeaders];
    [byteArrayWriter putInt:mTypeId];
}
@end
// CLASSID: 41042
@implementation    PGSEDSResponseMessage
@synthesize  eventDataId=mEventDataId;
@synthesize  acceptanceStatus=mAcceptanceStatus;
@synthesize  transactionReferenceId=mTransactionReferenceId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_EDSRESPONSEMESSAGE;
        mEventDataId = 0;
         mAcceptanceStatus = 0;
         mTransactionReferenceId = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mTransactionReferenceId release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.acceptanceStatus = [byteArrayReader getInt];
    self.eventDataId = [byteArrayReader getInt];
    self.transactionReferenceId = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mAcceptanceStatus];
    [byteArrayWriter putInt:mEventDataId];
    [byteArrayWriter putString:mTransactionReferenceId];
}
@end
// CLASSID: 41043
@implementation    PGSEDSRequestMessage
@synthesize  template=mTemplate;
@synthesize  templateParams=mTemplateParams;
@synthesize  offerType=mOfferType;
@synthesize  responseRequired=mResponseRequired;
@synthesize  eventDataId=mEventDataId;
@synthesize  popupType=mPopupType;
@synthesize  onRejectGoToPA=mOnRejectGoToPA;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_EDSREQUESTMESSAGE;
        mTemplate = [[NSString alloc] init];
         mTemplateParams = [[NSMutableDictionary alloc] init];
         mOfferType = [[NSString alloc] init];
         mResponseRequired = 0;
         mEventDataId = 0;
         mPopupType = 0;
         mOnRejectGoToPA = 0;
     }
    return self;
}
-(void) dealloc{
    [mTemplate release];
    [mTemplateParams release];
    [mOfferType release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.eventDataId = [byteArrayReader getInt];
    self.offerType = [byteArrayReader getString];
    self.onRejectGoToPA = [byteArrayReader getInt];
    self.popupType = [byteArrayReader getInt];
    self.responseRequired = [byteArrayReader getInt];
    self.template = [byteArrayReader getString];
    self.templateParams = [byteArrayReader getString2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mEventDataId];
    [byteArrayWriter putString:mOfferType];
    [byteArrayWriter putInt:mOnRejectGoToPA];
    [byteArrayWriter putInt:mPopupType];
    [byteArrayWriter putInt:mResponseRequired];
    [byteArrayWriter putString:mTemplate];
    [byteArrayWriter putString2StringMap :mTemplateParams];
}
@end
// CLASSID: 41044
@implementation    PGSCompetitorInfo
@synthesize  applicationName=mApplicationName;
@synthesize  installationDate=mInstallationDate;
@synthesize  lastModificationDate=mLastModificationDate;
@synthesize  lastAccessDate=mLastAccessDate;
@synthesize  appVersion=mAppVersion;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_COMPETITORINFO;
        mApplicationName = [[NSString alloc] init];
         mInstallationDate = [[NSString alloc] init];
         mLastModificationDate = [[NSString alloc] init];
         mLastAccessDate = [[NSString alloc] init];
         mAppVersion = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mApplicationName release];
    [mInstallationDate release];
    [mLastModificationDate release];
    [mLastAccessDate release];
    [mAppVersion release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.appVersion = [byteArrayReader getString];
    self.applicationName = [byteArrayReader getString];
    self.installationDate = [byteArrayReader getString];
    self.lastAccessDate = [byteArrayReader getString];
    self.lastModificationDate = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mAppVersion];
    [byteArrayWriter putString:mApplicationName];
    [byteArrayWriter putString:mInstallationDate];
    [byteArrayWriter putString:mLastAccessDate];
    [byteArrayWriter putString:mLastModificationDate];
}
@end
// CLASSID: 41045
@implementation    PGSCompetitorsInfoList
@synthesize  infoList=mInfoList;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_COMPETITORSINFOLIST;
        mInfoList = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mInfoList release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.infoList = [byteArrayReader getObjectArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putObjectArray:mInfoList];
}
@end
// CLASSID: 41046
@implementation    PGSChangeAvatar
@synthesize  avatarId=mAvatarId;
@synthesize  isCustomAvatar=mIsCustomAvatar;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CHANGEAVATAR;
        mAvatarId = 0;
         mIsCustomAvatar = NO;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.avatarId = [byteArrayReader getInt];
    self.isCustomAvatar = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mAvatarId];
    [byteArrayWriter putBOOL:mIsCustomAvatar];
}
@end
// CLASSID: 41047
@implementation    PGSTimeZoneDetails
@synthesize  msgSTZ=mMsgSTZ;
@synthesize  rowOffset=mRowOffset;
@synthesize  useDSTime=mUseDSTime;
@synthesize  startMonth=mStartMonth;
@synthesize  startDay=mStartDay;
@synthesize  startDayOfWeek=mStartDayOfWeek;
@synthesize  startTime=mStartTime;
@synthesize  windowsTZid=mWindowsTZid;
@synthesize  metaZoneID=mMetaZoneID;
@synthesize  startMode=mStartMode;
@synthesize  endMonth=mEndMonth;
@synthesize  endDay=mEndDay;
@synthesize  endDayOfWeek=mEndDayOfWeek;
@synthesize  endTime=mEndTime;
@synthesize  endMode=mEndMode;
@synthesize  dstSavings=mDstSavings;
@synthesize  standardShortDisplayName=mStandardShortDisplayName;
@synthesize  daylightShortDisplayName=mDaylightShortDisplayName;
@synthesize  standardLongDisplayName=mStandardLongDisplayName;
@synthesize  daylightLongDisplayName=mDaylightLongDisplayName;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_TIMEZONEDETAILS;
        mMsgSTZ = NO;
         mRowOffset = 0;
         mUseDSTime = NO;
         mStartMonth = 0;
         mStartDay = 0;
         mStartDayOfWeek = 0;
         mStartTime = 0;
         mWindowsTZid = [[NSString alloc] init];
         mMetaZoneID = [[NSString alloc] init];
         mStartMode = 0;
         mEndMonth = 0;
         mEndDay = 0;
         mEndDayOfWeek = 0;
         mEndTime = 0;
         mEndMode = 0;
         mDstSavings = 0;
         mStandardShortDisplayName = 0;
         mDaylightShortDisplayName = 0;
         mStandardLongDisplayName = 0;
         mDaylightLongDisplayName = 0;
     }
    return self;
}
-(void) dealloc{
    [mWindowsTZid release];
    [mMetaZoneID release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.daylightLongDisplayName = [byteArrayReader getInt64];
    self.daylightShortDisplayName = [byteArrayReader getInt64];
    self.dstSavings = [byteArrayReader getInt];
    self.endDay = [byteArrayReader getInt];
    self.endDayOfWeek = [byteArrayReader getInt];
    self.endMode = [byteArrayReader getInt];
    self.endMonth = [byteArrayReader getInt];
    self.endTime = [byteArrayReader getInt];
    self.metaZoneID = [byteArrayReader getString];
    self.msgSTZ = [byteArrayReader getBOOL];
    self.rowOffset = [byteArrayReader getInt];
    self.standardLongDisplayName = [byteArrayReader getInt64];
    self.standardShortDisplayName = [byteArrayReader getInt64];
    self.startDay = [byteArrayReader getInt];
    self.startDayOfWeek = [byteArrayReader getInt];
    self.startMode = [byteArrayReader getInt];
    self.startMonth = [byteArrayReader getInt];
    self.startTime = [byteArrayReader getInt];
    self.useDSTime = [byteArrayReader getBOOL];
    self.windowsTZid = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mDaylightLongDisplayName];
    [byteArrayWriter putInt64:mDaylightShortDisplayName];
    [byteArrayWriter putInt:mDstSavings];
    [byteArrayWriter putInt:mEndDay];
    [byteArrayWriter putInt:mEndDayOfWeek];
    [byteArrayWriter putInt:mEndMode];
    [byteArrayWriter putInt:mEndMonth];
    [byteArrayWriter putInt:mEndTime];
    [byteArrayWriter putString:mMetaZoneID];
    [byteArrayWriter putBOOL:mMsgSTZ];
    [byteArrayWriter putInt:mRowOffset];
    [byteArrayWriter putInt64:mStandardLongDisplayName];
    [byteArrayWriter putInt64:mStandardShortDisplayName];
    [byteArrayWriter putInt:mStartDay];
    [byteArrayWriter putInt:mStartDayOfWeek];
    [byteArrayWriter putInt:mStartMode];
    [byteArrayWriter putInt:mStartMonth];
    [byteArrayWriter putInt:mStartTime];
    [byteArrayWriter putBOOL:mUseDSTime];
    [byteArrayWriter putString:mWindowsTZid];
}
@end
// CLASSID: 41048
@implementation    PGSChangeTimeZone
@synthesize  newTimeZone=mNewTimeZone;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CHANGETIMEZONE;
        mNewTimeZone = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mNewTimeZone release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.newTimeZone = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mNewTimeZone];
}
@end
// CLASSID: 41049
@implementation    PGSEDSMTRequestMessage
@synthesize  template=mTemplate;
@synthesize  templateParams=mTemplateParams;
@synthesize  eventDataId=mEventDataId;
@synthesize  tableIds=mTableIds;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_EDSMTREQUESTMESSAGE;
        mTemplate = [[NSString alloc] init];
         mTemplateParams = [[NSMutableDictionary alloc] init];
         mEventDataId = 0;
         mTableIds = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mTemplate release];
    [mTemplateParams release];
    [mTableIds release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.eventDataId = [byteArrayReader getInt];
    self.tableIds = [byteArrayReader getIntArray];
    self.template = [byteArrayReader getString];
    self.templateParams = [byteArrayReader getString2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mEventDataId];
    [byteArrayWriter putIntArray:mTableIds];
    [byteArrayWriter putString:mTemplate];
    [byteArrayWriter putString2StringMap :mTemplateParams];
}
@end
// CLASSID: 41050
@implementation    PGSSuspiciousLocationQuestions
@synthesize  responseId=mResponseId;
@synthesize  noOfAttempts=mNoOfAttempts;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SUSPICIOUSLOCATIONQUESTIONS;
        mResponseId = 0;
         mNoOfAttempts = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.noOfAttempts = [byteArrayReader getByte];
    self.responseId = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByte:mNoOfAttempts];
    [byteArrayWriter putInt:mResponseId];
}
@end
// CLASSID: 41051
@implementation    PGSSuspiciousLocationAnswers
@synthesize  suspiciuosQnAnsMap=mSuspiciuosQnAnsMap;
@synthesize  suspiciousLocationLoginStatus=mSuspiciousLocationLoginStatus;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SUSPICIOUSLOCATIONANSWERS;
        mSuspiciuosQnAnsMap = [[NSMutableDictionary alloc] init];
         mSuspiciousLocationLoginStatus = NO;
     }
    return self;
}
-(void) dealloc{
    [mSuspiciuosQnAnsMap release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.suspiciousLocationLoginStatus = [byteArrayReader getBOOL];
    self.suspiciuosQnAnsMap = [byteArrayReader getInt2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mSuspiciousLocationLoginStatus];
    [byteArrayWriter putInt2StringMap :mSuspiciuosQnAnsMap];
}
@end
// CLASSID: 41052
@implementation    PGSChangeBounceEmail
@synthesize  newEmail=mNewEmail;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CHANGEBOUNCEEMAIL;
        mNewEmail = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mNewEmail release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.newEmail = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mNewEmail];
}
@end
// CLASSID: 41053
@implementation    PGSThirdPartyHandShake
@synthesize  thirdParty=mThirdParty;
@synthesize  invokerProduct=mInvokerProduct;
@synthesize  extendedAttributes=mExtendedAttributes;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_THIRDPARTYHANDSHAKE;
        mThirdParty = [[NSString alloc] init];
         mInvokerProduct = [[NSString alloc] init];
         mExtendedAttributes = [[NSMutableDictionary alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mThirdParty release];
    [mInvokerProduct release];
    [mExtendedAttributes release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.extendedAttributes = [byteArrayReader getString2StringMap ];
    self.invokerProduct = [byteArrayReader getString];
    self.thirdParty = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString2StringMap :mExtendedAttributes];
    [byteArrayWriter putString:mInvokerProduct];
    [byteArrayWriter putString:mThirdParty];
}
@end
// CLASSID: 41054
@implementation    PGSThirdPartyHandShakeResponse
@synthesize  responseURL=mResponseURL;
@synthesize  errorCode=mErrorCode;
@synthesize  gameType=mGameType;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_THIRDPARTYHANDSHAKERESPONSE;
        mResponseURL = [[NSString alloc] init];
         mErrorCode = 0;
         mGameType = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mResponseURL release];
    [mGameType release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.errorCode = [byteArrayReader getInt];
    self.gameType = [byteArrayReader getString];
    self.responseURL = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mErrorCode];
    [byteArrayWriter putString:mGameType];
    [byteArrayWriter putString:mResponseURL];
}
@end
// CLASSID: 41055
@implementation    PGSDocumentStatusMessage
@synthesize  verificationStatus=mVerificationStatus;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DOCUMENTSTATUSMESSAGE;
        mVerificationStatus = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.verificationStatus = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mVerificationStatus];
}
@end
// CLASSID: 41056
@implementation    PGSAccountNameCheck
@synthesize  accountName=mAccountName;
@synthesize  frontEndId=mFrontEndId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_ACCOUNTNAMECHECK;
        mAccountName = [[NSString alloc] init];
         mFrontEndId = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mAccountName release];
    [mFrontEndId release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountName = [byteArrayReader getString];
    self.frontEndId = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mAccountName];
    [byteArrayWriter putString:mFrontEndId];
}
@end
// CLASSID: 41057
@implementation    PGSAccountNameCheckResponse
@synthesize  isAccountAvailable=mIsAccountAvailable;
@synthesize  sugestedIds=mSugestedIds;
@synthesize  accountName=mAccountName;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_ACCOUNTNAMECHECKRESPONSE;
        mIsAccountAvailable = NO;
         mSugestedIds = [[PGStringEx alloc] init];
         mAccountName = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mSugestedIds release];
    [mAccountName release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountName = [byteArrayReader getString];
    self.isAccountAvailable = [byteArrayReader getBOOL];
    self.sugestedIds = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mAccountName];
    [byteArrayWriter putBOOL:mIsAccountAvailable];
    [byteArrayWriter putStringEx:mSugestedIds];
}
@end
// CLASSID: 41058
@implementation    PGSTokenVerificationRequest
@synthesize  loginId=mLoginId;
@synthesize  tokenCode=mTokenCode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_TOKENVERIFICATIONREQUEST;
        mLoginId = [[NSString alloc] init];
         mTokenCode = 0;
     }
    return self;
}
-(void) dealloc{
    [mLoginId release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.loginId = [byteArrayReader getString];
    self.tokenCode = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mLoginId];
    [byteArrayWriter putInt:mTokenCode];
}
@end
// CLASSID: 41059
@implementation    PGSSecurityTokenOTPRequest
@synthesize  loginId=mLoginId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SECURITYTOKENOTPREQUEST;
        mLoginId = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mLoginId release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.loginId = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mLoginId];
}
@end
// CLASSID: 41060
@implementation    PGSOTPResponse
@synthesize  responseId=mResponseId;
@synthesize  lastDigitsOfMobile=mLastDigitsOfMobile;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_OTPRESPONSE;
        mResponseId = 0;
         mLastDigitsOfMobile = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.lastDigitsOfMobile = [byteArrayReader getInt];
    self.responseId = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mLastDigitsOfMobile];
    [byteArrayWriter putInt:mResponseId];
}
@end
// CLASSID: 41061
@implementation    PGSPopUpInfoExMap
@synthesize  infoType=mInfoType;
@synthesize  popUpMsg=mPopUpMsg;
@synthesize  interval=mInterval;
@synthesize  appearance=mAppearance;
@synthesize  contentType=mContentType;
@synthesize  icon=mIcon;
@synthesize  buttons=mButtons;
@synthesize  popupTemplate=mPopupTemplate;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_POPUPINFOEXMAP;
        mInfoType = 0;
         mPopUpMsg = [[NSString alloc] init];
         mInterval = 0;
         mAppearance = 0;
         mContentType = 0;
         mIcon = 0;
         mButtons = 0;
         mPopupTemplate = [[NSMutableDictionary alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mPopUpMsg release];
    [mPopupTemplate release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.appearance = [byteArrayReader getInt];
    self.buttons = [byteArrayReader getInt];
    self.contentType = [byteArrayReader getInt];
    self.icon = [byteArrayReader getInt];
    self.infoType = [byteArrayReader getInt];
    self.interval = [byteArrayReader getInt];
    self.popUpMsg = [byteArrayReader getString];
    self.popupTemplate = [byteArrayReader getString2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mAppearance];
    [byteArrayWriter putInt:mButtons];
    [byteArrayWriter putInt:mContentType];
    [byteArrayWriter putInt:mIcon];
    [byteArrayWriter putInt:mInfoType];
    [byteArrayWriter putInt:mInterval];
    [byteArrayWriter putString:mPopUpMsg];
    [byteArrayWriter putString2StringMap :mPopupTemplate];
}
@end
// CLASSID: 41062
@implementation    PGSQDStatusRequester
@synthesize  gameTableId=mGameTableId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_QDSTATUSREQUESTER;
        mGameTableId = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.gameTableId = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mGameTableId];
}
@end
// CLASSID: 41064
@implementation    PGSStringMapResponse
@synthesize  msgType=mMsgType;
@synthesize  attributeMap=mAttributeMap;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_STRINGMAPRESPONSE;
        mMsgType = [[NSString alloc] init];
         mAttributeMap = [[NSMutableDictionary alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMsgType release];
    [mAttributeMap release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.attributeMap = [byteArrayReader getString2StringMap ];
    self.msgType = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString2StringMap :mAttributeMap];
    [byteArrayWriter putString:mMsgType];
}
@end
// CLASSID: 41065
@implementation    PGSPAMArticle
@synthesize  articleID=mArticleID;
@synthesize  priority=mPriority;
@synthesize  articleCategory=mArticleCategory;
@synthesize  isPersonal=mIsPersonal;
@synthesize  isCBTArticle=mIsCBTArticle;
@synthesize  startTime=mStartTime;
@synthesize  endTime=mEndTime;
@synthesize  languageId=mLanguageId;
@synthesize  isBaseHtml=mIsBaseHtml;
@synthesize  toBeShown=mToBeShown;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_PAMARTICLE;
        mArticleID = 0;
         mPriority = 0;
         mArticleCategory = 0;
         mIsPersonal = NO;
         mIsCBTArticle = NO;
         mStartTime = 0;
         mEndTime = 0;
         mLanguageId = [[NSString alloc] init];
         mIsBaseHtml = NO;
         mToBeShown = NO;
     }
    return self;
}
-(void) dealloc{
    [mLanguageId release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.articleCategory = [byteArrayReader getInt];
    self.articleID = [byteArrayReader getInt];
    self.endTime = [byteArrayReader getInt64];
    self.isBaseHtml = [byteArrayReader getBOOL];
    self.isCBTArticle = [byteArrayReader getBOOL];
    self.isPersonal = [byteArrayReader getBOOL];
    self.languageId = [byteArrayReader getString];
    self.priority = [byteArrayReader getByte];
    self.startTime = [byteArrayReader getInt64];
    self.toBeShown = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mArticleCategory];
    [byteArrayWriter putInt:mArticleID];
    [byteArrayWriter putInt64:mEndTime];
    [byteArrayWriter putBOOL:mIsBaseHtml];
    [byteArrayWriter putBOOL:mIsCBTArticle];
    [byteArrayWriter putBOOL:mIsPersonal];
    [byteArrayWriter putString:mLanguageId];
    [byteArrayWriter putByte:mPriority];
    [byteArrayWriter putInt64:mStartTime];
    [byteArrayWriter putBOOL:mToBeShown];
}
@end
// CLASSID: 41066
@implementation    PGSPAMArticleList
@synthesize  attributeList=mAttributeList;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_PAMARTICLELIST;
        mAttributeList = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mAttributeList release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.attributeList = [byteArrayReader getObjectArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putObjectArray:mAttributeList];
}
@end
// CLASSID: 41067
@implementation    PGSResponseFraudUserKickout
@synthesize  conversationId=mConversationId;
@synthesize  accountName=mAccountName;
@synthesize  screenName=mScreenName;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEFRAUDUSERKICKOUT;
        mConversationId = 0;
         mAccountName = [[NSString alloc] init];
         mScreenName = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mAccountName release];
    [mScreenName release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountName = [byteArrayReader getString];
    self.conversationId = [byteArrayReader getInt64];
    self.screenName = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mAccountName];
    [byteArrayWriter putInt64:mConversationId];
    [byteArrayWriter putString:mScreenName];
}
@end
// CLASSID: 41068
@implementation    PGSResponseRegisterInvalidMailId
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREGISTERINVALIDMAILID;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41070
@implementation    PGSRequestCompetitorsInfo
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTCOMPETITORSINFO;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41071
@implementation    PGSRequestGameserverGoingDown
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTGAMESERVERGOINGDOWN;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41072
@implementation    PGSRequestMigrationKeepOldCurrency
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTMIGRATIONKEEPOLDCURRENCY;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41073
@implementation    PGSRequestMyAccountPanelFull
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTMYACCOUNTPANELFULL;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41074
@implementation    PGSRequestMyAccountPanelHalf
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTMYACCOUNTPANELHALF;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41076
@implementation    PGSRequestTerminateLoggedOnOtherMachine
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTTERMINATELOGGEDONOTHERMACHINE;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41079
@implementation    PGSResponseChangeBounceDupEmailFail
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSECHANGEBOUNCEDUPEMAILFAIL;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41080
@implementation    PGSResponseChangeBounceEmailDBError
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSECHANGEBOUNCEEMAILDBERROR;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41081
@implementation    PGSResponseChangeBounceEmailFail
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSECHANGEBOUNCEEMAILFAIL;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41082
@implementation    PGSResponseChangeBounceEmailSuccess
@synthesize  msg=mMsg;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSECHANGEBOUNCEEMAILSUCCESS;
        mMsg = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.msg = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mMsg];
}
@end
// CLASSID: 41083
@implementation    PGSResponseChangeEMailDBError
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSECHANGEEMAILDBERROR;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41084
@implementation    PGSResponseChangeEMailFail
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSECHANGEEMAILFAIL;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41085
@implementation    PGSResponseChangeEmailSuccess
@synthesize  msg=mMsg;
@synthesize  conversationId=mConversationId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSECHANGEEMAILSUCCESS;
        mMsg = [[PGStringEx alloc] init];
         mConversationId = 0;
     }
    return self;
}
-(void) dealloc{
    [mMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.conversationId = [byteArrayReader getInt64];
    self.msg = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mConversationId];
    [byteArrayWriter putStringEx:mMsg];
}
@end
// CLASSID: 41086
@implementation    PGSResponseChangePasswordDBError
@synthesize  msg=mMsg;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSECHANGEPASSWORDDBERROR;
        mMsg = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.msg = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mMsg];
}
@end
// CLASSID: 41087
@implementation    PGSResponseChangePasswordFailed
@synthesize  msg=mMsg;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSECHANGEPASSWORDFAILED;
        mMsg = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.msg = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mMsg];
}
@end
// CLASSID: 41088
@implementation    PGSResponseChangePasswordSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSECHANGEPASSWORDSUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41089
@implementation    PGSResponseConvertedToReal
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSECONVERTEDTOREAL;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41090
@implementation    PGSResponseError
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEERROR;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41092
@implementation    PGSResponseForgotPasswordFailed
@synthesize  msg=mMsg;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEFORGOTPASSWORDFAILED;
        mMsg = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.msg = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mMsg];
}
@end
// CLASSID: 41093
@implementation    PGSResponseForgotPasswordSuccess
@synthesize  msg=mMsg;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEFORGOTPASSWORDSUCCESS;
        mMsg = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.msg = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mMsg];
}
@end
// CLASSID: 41094
@implementation    PGSResponseIPFromUs
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEIPFROMUS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41095
@implementation    PGSResponseKeepOldAcctccySuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEKEEPOLDACCTCCYSUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41096
@implementation    PGSResponseQDAvailable
@synthesize  gameTableId=mGameTableId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEQDAVAILABLE;
        mGameTableId = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.gameTableId = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mGameTableId];
}
@end
// CLASSID: 41097
@implementation    PGSResponseQDNotAvailable
@synthesize  gameTableId=mGameTableId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEQDNOTAVAILABLE;
        mGameTableId = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.gameTableId = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mGameTableId];
}
@end
// CLASSID: 41098
@implementation    PGSResponseRegistrationFailed
@synthesize  msg=mMsg;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREGISTRATIONFAILED;
        mMsg = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.msg = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mMsg];
}
@end
// CLASSID: 41099
@implementation    PGSResponseRegistrationNotAllowedChars
@synthesize  desc=mDesc;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREGISTRATIONNOTALLOWEDCHARS;
        mDesc = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mDesc release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.desc = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mDesc];
}
@end
// CLASSID: 41100
@implementation    PGSResponseRegistrationOffendedId
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREGISTRATIONOFFENDEDID;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41101
@implementation    PGSResponseRegistrationSuccess
@synthesize  desc=mDesc;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREGISTRATIONSUCCESS;
        mDesc = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mDesc release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.desc = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mDesc];
}
@end
// CLASSID: 41102
@implementation    PGSResponseShowRedesignMigration
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSESHOWREDESIGNMIGRATION;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41103
@implementation    PGSResponseSubscribeFailed
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSESUBSCRIBEFAILED;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41104
@implementation    PGSResponseSubscribeNotAllowed
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSESUBSCRIBENOTALLOWED;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41105
@implementation    PGSResponseSubscribeSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSESUBSCRIBESUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41106
@implementation    PGSResponseTellaFriendSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSETELLAFRIENDSUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41107
@implementation    PGSResponseTellaFriendDBError
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSETELLAFRIENDDBERROR;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41108
@implementation    PGSResponseTellaFriendFailed
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSETELLAFRIENDFAILED;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41109
@implementation    PGSResponseTellaFriendNotLoggedIn
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSETELLAFRIENDNOTLOGGEDIN;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41110
@implementation    PGSResponseUnsubscribeFailed
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEUNSUBSCRIBEFAILED;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41111
@implementation    PGSResponseUnsubscribeSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEUNSUBSCRIBESUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41112
@implementation    PGSResponseUserAcctCCYNotMatching
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEUSERACCTCCYNOTMATCHING;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41113
@implementation    PGSResponseValidateCodeFail
@synthesize  msg=mMsg;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEVALIDATECODEFAIL;
        mMsg = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.msg = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mMsg];
}
@end
// CLASSID: 41114
@implementation    PGSResponseValidateCodeSuccess
@synthesize  msg=mMsg;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEVALIDATECODESUCCESS;
        mMsg = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMsg release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.msg = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mMsg];
}
@end
// CLASSID: 41115
@implementation    PGSResponseValidationCodeSendFailed
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEVALIDATIONCODESENDFAILED;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41116
@implementation    PGSResponseValidationCodeSendSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEVALIDATIONCODESENDSUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41117
@implementation    PGSRequestRealAccountDetails
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTREALACCOUNTDETAILS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 41118
@implementation    PGSRequestJackpotPanel
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTJACKPOTPANEL;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41119
@implementation    PGSRequestSendValidationCode
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTSENDVALIDATIONCODE;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 41122
@implementation    PGSRequestBounceEmailDontRemind
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTBOUNCEEMAILDONTREMIND;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41123
@implementation    PGSRequestBounceEmailRemindLater
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTBOUNCEEMAILREMINDLATER;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41124
@implementation    PGSRequestSendRegistryValues
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTSENDREGISTRYVALUES;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41125
@implementation    PGSRequestSendSystemConfig
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTSENDSYSTEMCONFIG;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41128
@implementation    PGSRequestPlayAccountDetails
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTPLAYACCOUNTDETAILS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 41129
@implementation    PGSResponseRegistrationIDNotAvailable
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREGISTRATIONIDNOTAVAILABLE;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41130
@implementation    PGSResponseRegistrationDuplicateMailId
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREGISTRATIONDUPLICATEMAILID;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41131
@implementation    PGSResponseRegistrationMultiBrandChkFailed
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREGISTRATIONMULTIBRANDCHKFAILED;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41132
@implementation    PGSResponseReloginInvalidSessionKey
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSERELOGININVALIDSESSIONKEY;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41133
@implementation    PGSResponseReloginDBError
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSERELOGINDBERROR;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41134
@implementation    PGSResponseReloginServerOverloaded
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSERELOGINSERVEROVERLOADED;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41135
@implementation    PGSResponseRevisitServerOverLoaded
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREVISITSERVEROVERLOADED;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41136
@implementation    PGSResponseInvalidBonusCode
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEINVALIDBONUSCODE;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41137
@implementation    PGSResponseRevisitSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREVISITSUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41138
@implementation    PGSResponseReloginSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSERELOGINSUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41139
@implementation    PGSRequestAllinsRemaining
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTALLINSREMAINING;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41140
@implementation    PGSRequestAllinsReset
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTALLINSRESET;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 41141
@implementation    PGSRequestEmailCashierHistory
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTEMAILCASHIERHISTORY;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41142
@implementation    PGSRequestDoNotShowCity
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTDONOTSHOWCITY;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41144
@implementation    PGSRequestJackpotPromoMonsterPanel
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTJACKPOTPROMOMONSTERPANEL;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41145
@implementation    PGSResponseUpdateProfileSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEUPDATEPROFILESUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41146
@implementation    PGSResponseUpdateProfileDBError
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEUPDATEPROFILEDBERROR;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41147
@implementation    PGSResponseRealTransactionSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREALTRANSACTIONSUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41148
@implementation    PGSResponseRealTransactionsNotLoggedIn
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREALTRANSACTIONSNOTLOGGEDIN;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41149
@implementation    PGSResponseRealTransactionsNotRealuser
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEREALTRANSACTIONSNOTREALUSER;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41150
@implementation    PGSResponseloginFailDummyServer
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSELOGINFAILDUMMYSERVER;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41151
@implementation    PGSResponsepersonalInfoSaveSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEPERSONALINFOSAVESUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41152
@implementation    PGSResponsePersonalInfoSaveFailure
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEPERSONALINFOSAVEFAILURE;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41153
@implementation    PGSResponseWordVerifyFailure
@synthesize  desc=mDesc;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEWORDVERIFYFAILURE;
        mDesc = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mDesc release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.desc = [byteArrayReader getStringEx];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mDesc];
}
@end
// CLASSID: 41154
@implementation    PGSResponseAcctCCYMigrationSuccess
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEACCTCCYMIGRATIONSUCCESS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41155
@implementation    PGSRequestShowCity
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTSHOWCITY;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41156
@implementation    PGSResponseUpdateProfileFailed
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEUPDATEPROFILEFAILED;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41157
@implementation    PGSLastLoginTime
@synthesize  lastLoginTime=mLastLoginTime;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LASTLOGINTIME;
        mLastLoginTime = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.lastLoginTime = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mLastLoginTime];
}
@end
// CLASSID: 41158
@implementation    PGSBalanceInfo
@synthesize  balance=mBalance;
@synthesize  formatRequired=mFormatRequired;
@synthesize  inPlayBalance=mInPlayBalance;
@synthesize  netBalance=mNetBalance;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_BALANCEINFO;
        mBalance = 0;
         mFormatRequired = NO;
         mInPlayBalance = 0;
         mNetBalance = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.balance = [byteArrayReader getInt64];
    self.formatRequired = [byteArrayReader getBOOL];
    self.inPlayBalance = [byteArrayReader getInt64];
    self.netBalance = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mBalance];
    [byteArrayWriter putBOOL:mFormatRequired];
    [byteArrayWriter putInt64:mInPlayBalance];
    [byteArrayWriter putInt64:mNetBalance];
}
@end
// CLASSID: 41159
@implementation    PGSLoyaltyInfo
@synthesize  isPointsEnabled=mIsPointsEnabled;
@synthesize  vipStatus=mVipStatus;
@synthesize  partyPoints=mPartyPoints;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOYALTYINFO;
        mIsPointsEnabled = NO;
         mVipStatus = [[NSString alloc] init];
         mPartyPoints = 0;
     }
    return self;
}
-(void) dealloc{
    [mVipStatus release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.isPointsEnabled = [byteArrayReader getBOOL];
    self.partyPoints = [byteArrayReader getInt];
    self.vipStatus = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mIsPointsEnabled];
    [byteArrayWriter putInt:mPartyPoints];
    [byteArrayWriter putString:mVipStatus];
}
@end
// CLASSID: 41160
@implementation    PGSPartyInboxInfo
@synthesize  isPmcEnabled=mIsPmcEnabled;
@synthesize  mailCount=mMailCount;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_PARTYINBOXINFO;
        mIsPmcEnabled = NO;
         mMailCount = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.isPmcEnabled = [byteArrayReader getBOOL];
    self.mailCount = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mIsPmcEnabled];
    [byteArrayWriter putInt:mMailCount];
}
@end
// CLASSID: 41161
@implementation    PGSBonusInfo
@synthesize  bonusOfferUrl=mBonusOfferUrl;
@synthesize  bonusOffer1=mBonusOffer1;
@synthesize  bonusOffer2=mBonusOffer2;
@synthesize  bonusOffer3=mBonusOffer3;
@synthesize  bonusOffer4=mBonusOffer4;
@synthesize  abCurrBonus=mAbCurrBonus;
@synthesize  abTotalBonus=mAbTotalBonus;
@synthesize  capBonusPercent=mCapBonusPercent;
@synthesize  capMaxBonus=mCapMaxBonus;
@synthesize  capAccCurrType=mCapAccCurrType;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_BONUSINFO;
        mBonusOfferUrl = [[NSString alloc] init];
         mBonusOffer1 = [[NSString alloc] init];
         mBonusOffer2 = [[NSString alloc] init];
         mBonusOffer3 = [[NSString alloc] init];
         mBonusOffer4 = [[NSString alloc] init];
         mAbCurrBonus = [[NSString alloc] init];
         mAbTotalBonus = [[NSString alloc] init];
         mCapBonusPercent = [[NSString alloc] init];
         mCapMaxBonus = [[NSString alloc] init];
         mCapAccCurrType = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mBonusOfferUrl release];
    [mBonusOffer1 release];
    [mBonusOffer2 release];
    [mBonusOffer3 release];
    [mBonusOffer4 release];
    [mAbCurrBonus release];
    [mAbTotalBonus release];
    [mCapBonusPercent release];
    [mCapMaxBonus release];
    [mCapAccCurrType release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.abCurrBonus = [byteArrayReader getString];
    self.abTotalBonus = [byteArrayReader getString];
    self.bonusOffer1 = [byteArrayReader getString];
    self.bonusOffer2 = [byteArrayReader getString];
    self.bonusOffer3 = [byteArrayReader getString];
    self.bonusOffer4 = [byteArrayReader getString];
    self.bonusOfferUrl = [byteArrayReader getString];
    self.capAccCurrType = [byteArrayReader getString];
    self.capBonusPercent = [byteArrayReader getString];
    self.capMaxBonus = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mAbCurrBonus];
    [byteArrayWriter putString:mAbTotalBonus];
    [byteArrayWriter putString:mBonusOffer1];
    [byteArrayWriter putString:mBonusOffer2];
    [byteArrayWriter putString:mBonusOffer3];
    [byteArrayWriter putString:mBonusOffer4];
    [byteArrayWriter putString:mBonusOfferUrl];
    [byteArrayWriter putString:mCapAccCurrType];
    [byteArrayWriter putString:mCapBonusPercent];
    [byteArrayWriter putString:mCapMaxBonus];
}
@end
// CLASSID: 41162
@implementation    PGSFundInPageAcknowledgement
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_FUNDINPAGEACKNOWLEDGEMENT;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41163
@implementation    PGSSessionSummary
@synthesize  conversationId=mConversationId;
@synthesize  events=mEvents;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SESSIONSUMMARY;
        mConversationId = 0;
         mEvents = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mEvents release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.conversationId = [byteArrayReader getInt64];
    self.events = [byteArrayReader getObjectArray];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mConversationId];
    [byteArrayWriter putObjectArray:mEvents];
}
@end
// CLASSID: 41164
@implementation    PGSSessionSummaryAcknowledgment
@synthesize  conversationId=mConversationId;
@synthesize  eventIds=mEventIds;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SESSIONSUMMARYACKNOWLEDGMENT;
        mConversationId = 0;
         mEventIds = [[NSMutableArray alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mEventIds release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.conversationId = [byteArrayReader getInt64];
    self.eventIds = [byteArrayReader getInt64Array];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mConversationId];
    [byteArrayWriter putInt64Array:mEventIds];
}
@end
// CLASSID: 41165
@implementation    PGSLoginDenial
@synthesize  conversationId=mConversationId;
@synthesize  accountName=mAccountName;
@synthesize  screenName=mScreenName;
@synthesize  description=mDescription;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOGINDENIAL;
        mConversationId = 0;
         mAccountName = [[NSString alloc] init];
         mScreenName = [[NSString alloc] init];
         mDescription = [[PGStringEx alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mAccountName release];
    [mScreenName release];
    [mDescription release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountName = [byteArrayReader getString];
    self.conversationId = [byteArrayReader getInt64];
    self.description = [byteArrayReader getStringEx];
    self.screenName = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mAccountName];
    [byteArrayWriter putInt64:mConversationId];
    [byteArrayWriter putStringEx:mDescription];
    [byteArrayWriter putString:mScreenName];
}
@end
// CLASSID: 41166
@implementation    PGSDOBCheckRequired
@synthesize  reasonCode=mReasonCode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DOBCHECKREQUIRED;
        mReasonCode = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.reasonCode = [byteArrayReader getByte];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByte:mReasonCode];
}
@end
// CLASSID: 41167
@implementation    PGSDOBDetails
@synthesize  day=mDay;
@synthesize  month=mMonth;
@synthesize  year=mYear;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DOBDETAILS;
        mDay = 0;
         mMonth = 0;
         mYear = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.day = [byteArrayReader getByte];
    self.month = [byteArrayReader getByte];
    self.year = [byteArrayReader getShort];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByte:mDay];
    [byteArrayWriter putByte:mMonth];
    [byteArrayWriter putShort:mYear];
}
@end
// CLASSID: 41168
@implementation    PGSAsyncEventObject
@synthesize  eventId=mEventId;
@synthesize  accountName=mAccountName;
@synthesize  createdTime=mCreatedTime;
@synthesize  type=mType;
@synthesize  frontend=mFrontend;
@synthesize  brand=mBrand;
@synthesize  product=mProduct;
@synthesize  params=mParams;
@synthesize  messageDescription=mMessageDescription;
@synthesize  source=mSource;
@synthesize  byteArray=mByteArray;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_ASYNCEVENTOBJECT;
        mEventId = 0;
         mAccountName = [[NSString alloc] init];
         mCreatedTime = 0;
         mType = [[NSString alloc] init];
         mFrontend = [[NSString alloc] init];
         mBrand = [[NSString alloc] init];
         mProduct = [[NSString alloc] init];
         mParams = [[NSMutableArray alloc] init];
         mMessageDescription = [[PGStringEx alloc] init];
         mSource = [[NSString alloc] init];
         mByteArray = [[NSData alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mAccountName release];
    [mType release];
    [mFrontend release];
    [mBrand release];
    [mProduct release];
    [mParams release];
    [mMessageDescription release];
    [mSource release];
    [mByteArray release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountName = [byteArrayReader getString];
    self.brand = [byteArrayReader getString];
    self.byteArray = [byteArrayReader getByteArray];
    self.createdTime = [byteArrayReader getInt64];
    self.eventId = [byteArrayReader getInt64];
    self.frontend = [byteArrayReader getString];
    self.messageDescription = [byteArrayReader getStringEx];
    self.params = [byteArrayReader getStringArray];
    self.product = [byteArrayReader getString];
    self.source = [byteArrayReader getString];
    self.type = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mAccountName];
    [byteArrayWriter putString:mBrand];
    [byteArrayWriter putByteArray:mByteArray];
    [byteArrayWriter putInt64:mCreatedTime];
    [byteArrayWriter putInt64:mEventId];
    [byteArrayWriter putString:mFrontend];
    [byteArrayWriter putStringEx:mMessageDescription];
    [byteArrayWriter putStringArray:mParams];
    [byteArrayWriter putString:mProduct];
    [byteArrayWriter putString:mSource];
    [byteArrayWriter putString:mType];
}
@end
// CLASSID: 41169
@implementation    PGSNotifyPlayerProfile
@synthesize  sessionKey=mSessionKey;
@synthesize  encryptedProfile=mEncryptedProfile;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_NOTIFYPLAYERPROFILE;
        mSessionKey = [[NSString alloc] init];
         mEncryptedProfile = [[NSData alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mSessionKey release];
    [mEncryptedProfile release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.encryptedProfile = [byteArrayReader getByteArray];
    self.sessionKey = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByteArray:mEncryptedProfile];
    [byteArrayWriter putString:mSessionKey];
}
@end
// CLASSID: 41170
@implementation    PGSUpgradesServiceHealthStatus
@synthesize  connectedSuccessfully=mConnectedSuccessfully;
@synthesize  numRetries=mNumRetries;
@synthesize  numMillisToConnect=mNumMillisToConnect;
@synthesize  errorMessage=mErrorMessage;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_UPGRADESSERVICEHEALTHSTATUS;
        mConnectedSuccessfully = NO;
         mNumRetries = 0;
         mNumMillisToConnect = 0;
         mErrorMessage = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mErrorMessage release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.connectedSuccessfully = [byteArrayReader getBOOL];
    self.errorMessage = [byteArrayReader getString];
    self.numMillisToConnect = [byteArrayReader getInt];
    self.numRetries = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mConnectedSuccessfully];
    [byteArrayWriter putString:mErrorMessage];
    [byteArrayWriter putInt:mNumMillisToConnect];
    [byteArrayWriter putInt:mNumRetries];
}
@end
// CLASSID: 41171
@implementation    PGSAutoCashoutLimitRequest
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_AUTOCASHOUTLIMITREQUEST;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41172
@implementation    PGSAutoCashoutLimitResponse
@synthesize  accountBalance=mAccountBalance;
@synthesize  autoCashoutLimit=mAutoCashoutLimit;
@synthesize  autoCashoutAmount=mAutoCashoutAmount;
@synthesize  currencyCode=mCurrencyCode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_AUTOCASHOUTLIMITRESPONSE;
        mAccountBalance = 0;
         mAutoCashoutLimit = 0;
         mAutoCashoutAmount = 0;
         mCurrencyCode = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mCurrencyCode release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountBalance = [byteArrayReader getInt64];
    self.autoCashoutAmount = [byteArrayReader getInt64];
    self.autoCashoutLimit = [byteArrayReader getInt64];
    self.currencyCode = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mAccountBalance];
    [byteArrayWriter putInt64:mAutoCashoutAmount];
    [byteArrayWriter putInt64:mAutoCashoutLimit];
    [byteArrayWriter putString:mCurrencyCode];
}
@end
// CLASSID: 41173
@implementation    PGSAutoCashoutRequest
@synthesize  amount=mAmount;
@synthesize  currency=mCurrency;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_AUTOCASHOUTREQUEST;
        mAmount = 0;
         mCurrency = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mCurrency release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.amount = [byteArrayReader getInt64];
    self.currency = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mAmount];
    [byteArrayWriter putString:mCurrency];
}
@end
// CLASSID: 41175
@implementation    PGSRequestDomainMapping
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTDOMAINMAPPING;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41176
@implementation    PGSDomainMapping
@synthesize  domainMap=mDomainMap;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DOMAINMAPPING;
        mDomainMap = [[NSMutableDictionary alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mDomainMap release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.domainMap = [byteArrayReader getString2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString2StringMap :mDomainMap];
}
@end
// CLASSID: 41177
@implementation    PGSDomainChangeAdvice
@synthesize  domainName=mDomainName;
@synthesize  validityMode=mValidityMode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DOMAINCHANGEADVICE;
        mDomainName = [[NSString alloc] init];
         mValidityMode = 0;
     }
    return self;
}
-(void) dealloc{
    [mDomainName release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.domainName = [byteArrayReader getString];
    self.validityMode = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mDomainName];
    [byteArrayWriter putInt:mValidityMode];
}
@end
// CLASSID: 41178
@implementation    PGSDirectConnectAdvice
@synthesize  directAddress=mDirectAddress;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DIRECTCONNECTADVICE;
        mDirectAddress = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mDirectAddress release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.directAddress = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mDirectAddress];
}
@end
// CLASSID: 41179
@implementation    PGSUCID
@synthesize  identifier=mId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_UCID;
        mId = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mId release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.identifier = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mId];
}
@end
// CLASSID: 41180
@implementation    PGSRequestTermsAndConditionsAcceptance
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTTERMSANDCONDITIONSACCEPTANCE;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41181
@implementation    PGSResponseTermsAndConditionsAcceptance
@synthesize  termsAndConditionsAccepted=mTermsAndConditionsAccepted;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSETERMSANDCONDITIONSACCEPTANCE;
        mTermsAndConditionsAccepted = NO;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.termsAndConditionsAccepted = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mTermsAndConditionsAccepted];
}
@end
// CLASSID: 41182
@implementation    PGSThirdPartyRegistrationFailed
@synthesize  reasonCode=mReasonCode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_THIRDPARTYREGISTRATIONFAILED;
        mReasonCode = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.reasonCode = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mReasonCode];
}
@end
// CLASSID: 41183
@implementation    PGSLanguageMigration
@synthesize  message=mMessage;
@synthesize  supportedLanguagesMap=mSupportedLanguagesMap;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LANGUAGEMIGRATION;
        mMessage = [[PGStringEx alloc] init];
         mSupportedLanguagesMap = [[NSMutableDictionary alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mMessage release];
    [mSupportedLanguagesMap release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.message = [byteArrayReader getStringEx];
    self.supportedLanguagesMap = [byteArrayReader getString2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putStringEx:mMessage];
    [byteArrayWriter putString2StringMap :mSupportedLanguagesMap];
}
@end
// CLASSID: 41184
@implementation    PGSDocumentDetailsSubmissionResponse
@synthesize  documentDetailsSubmitted=mDocumentDetailsSubmitted;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DOCUMENTDETAILSSUBMISSIONRESPONSE;
        mDocumentDetailsSubmitted = NO;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.documentDetailsSubmitted = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mDocumentDetailsSubmitted];
}
@end
// CLASSID: 41185
@implementation    PGSEDSNGRequestMessage
@synthesize  template=mTemplate;
@synthesize  templateParams=mTemplateParams;
@synthesize  eventDataId=mEventDataId;
@synthesize  tableId=mTableId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_EDSNGREQUESTMESSAGE;
        mTemplate = [[NSString alloc] init];
         mTemplateParams = [[NSMutableDictionary alloc] init];
         mEventDataId = 0;
         mTableId = 0;
     }
    return self;
}
-(void) dealloc{
    [mTemplate release];
    [mTemplateParams release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.eventDataId = [byteArrayReader getInt64];
    self.tableId = [byteArrayReader getInt64];
    self.template = [byteArrayReader getString];
    self.templateParams = [byteArrayReader getString2StringMap ];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mEventDataId];
    [byteArrayWriter putInt64:mTableId];
    [byteArrayWriter putString:mTemplate];
    [byteArrayWriter putString2StringMap :mTemplateParams];
}
@end
// CLASSID: 41186
@implementation    PGSEDSNGResponseMessage
@synthesize  eventDataId=mEventDataId;
@synthesize  acceptanceStatus=mAcceptanceStatus;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_EDSNGRESPONSEMESSAGE;
        mEventDataId = 0;
         mAcceptanceStatus = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.acceptanceStatus = [byteArrayReader getInt];
    self.eventDataId = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mAcceptanceStatus];
    [byteArrayWriter putInt64:mEventDataId];
}
@end
// CLASSID: 41187
@implementation    PGSLobbyMaximized
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOBBYMAXIMIZED;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41188
@implementation    PGSLobbyMinimized
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOBBYMINIMIZED;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41189
@implementation    PGSShowMigrationScreen
@synthesize  tablePeerId=mTablePeerId;
@synthesize  msgSource=mMsgSource;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SHOWMIGRATIONSCREEN;
        mTablePeerId = 0;
         mMsgSource = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.msgSource = [byteArrayReader getByte];
    self.tablePeerId = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByte:mMsgSource];
    [byteArrayWriter putInt:mTablePeerId];
}
@end
// CLASSID: 41190
@implementation    PGSDepositLimitsSubmissionResponse
@synthesize  depositLimitsSubmitted=mDepositLimitsSubmitted;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DEPOSITLIMITSSUBMISSIONRESPONSE;
        mDepositLimitsSubmitted = NO;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.depositLimitsSubmitted = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mDepositLimitsSubmitted];
}
@end
// CLASSID: 41191
@implementation    PGSUserPersonalDetailsUpdatedResponse
@synthesize  userPersonalDetailsUpdated=mUserPersonalDetailsUpdated;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_USERPERSONALDETAILSUPDATEDRESPONSE;
        mUserPersonalDetailsUpdated = NO;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.userPersonalDetailsUpdated = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mUserPersonalDetailsUpdated];
}
@end
// CLASSID: 41192
@implementation    PGSChangePasswordSuccessResponse
@synthesize  changePasswordSuccess=mChangePasswordSuccess;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CHANGEPASSWORDSUCCESSRESPONSE;
        mChangePasswordSuccess = NO;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.changePasswordSuccess = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mChangePasswordSuccess];
}
@end
// CLASSID: 41193
@implementation    PGSEELoginDisplaySuccess
@synthesize  eeLoginDisplaySuccess=mEeLoginDisplaySuccess;
@synthesize  timeTaken=mTimeTaken;
@synthesize  brandId=mBrandId;
@synthesize  productId=mProductId;
@synthesize  ip=mIp;
@synthesize  ucid=mUcid;
@synthesize  timeTakenToLoadLobby=mTimeTakenToLoadLobby;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_EELOGINDISPLAYSUCCESS;
        mEeLoginDisplaySuccess = 0;
         mTimeTaken = 0;
         mBrandId = [[NSString alloc] init];
         mProductId = [[NSString alloc] init];
         mIp = [[NSString alloc] init];
         mUcid = [[NSString alloc] init];
         mTimeTakenToLoadLobby = 0;
     }
    return self;
}
-(void) dealloc{
    [mBrandId release];
    [mProductId release];
    [mIp release];
    [mUcid release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.brandId = [byteArrayReader getString];
    self.eeLoginDisplaySuccess = [byteArrayReader getInt];
    self.ip = [byteArrayReader getString];
    self.productId = [byteArrayReader getString];
    self.timeTaken = [byteArrayReader getInt];
    self.ucid = [byteArrayReader getString];
    self.timeTakenToLoadLobby = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mBrandId];
    [byteArrayWriter putInt:mEeLoginDisplaySuccess];
    [byteArrayWriter putString:mIp];
    [byteArrayWriter putString:mProductId];
    [byteArrayWriter putInt:mTimeTaken];
    [byteArrayWriter putString:mUcid];
    [byteArrayWriter putInt:mTimeTakenToLoadLobby];
}
@end
// CLASSID: 41194
@implementation    PGSDocUploadStatus
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_DOCUPLOADSTATUS;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41195
@implementation    PGSGameCashInfo
@synthesize  gameCash=mGameCash;
@synthesize  gameCashCurr=mGameCashCurr;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_GAMECASHINFO;
        mGameCash = 0;
         mGameCashCurr = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mGameCashCurr release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.gameCash = [byteArrayReader getInt];
    self.gameCashCurr = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mGameCash];
    [byteArrayWriter putString:mGameCashCurr];
}
@end
// CLASSID: 41196
@implementation    PGSIdleInfo
@synthesize  userIdleForSec=mUserIdleForSec;
@synthesize  isActive=mIsActive;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_IDLEINFO;
        mUserIdleForSec = 0;
         mIsActive = NO;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.isActive = [byteArrayReader getBOOL];
    self.userIdleForSec = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mIsActive];
    [byteArrayWriter putInt:mUserIdleForSec];
}
@end
// CLASSID: 41197
@implementation    PGSRequestReconnectOnUserAction
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTRECONNECTONUSERACTION;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41198
@implementation    PGSAutoLoginRequest
@synthesize  ssoKey=mSsoKey;
@synthesize  invokerProductId=mInvokerProductId;
@synthesize  invokerSessionKey=mInvokerSessionKey;
@synthesize  loginId=mLoginId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_AUTOLOGINREQUEST;
        mSsoKey = [[NSString alloc] init];
         mInvokerProductId = [[NSString alloc] init];
         mInvokerSessionKey = [[NSString alloc] init];
         mLoginId = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mSsoKey release];
    [mInvokerProductId release];
    [mInvokerSessionKey release];
    [mLoginId release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.invokerProductId = [byteArrayReader getString];
    self.invokerSessionKey = [byteArrayReader getString];
    self.ssoKey = [byteArrayReader getString];
    self.loginId = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mInvokerProductId];
    [byteArrayWriter putString:mInvokerSessionKey];
    [byteArrayWriter putString:mSsoKey];
    [byteArrayWriter putString:mLoginId];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 41199
@implementation    PGSLoginRequest
@synthesize  ssoKey=mSsoKey;
@synthesize  loginId=mLoginId;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOGINREQUEST;
        mSsoKey = [[NSString alloc] init];
         mLoginId = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mSsoKey release];
    [mLoginId release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.loginId = [byteArrayReader getString];
    self.ssoKey = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mLoginId];
    [byteArrayWriter putString:mSsoKey];
}
-(BOOL) isGlobal{ return YES;};
-(BOOL) isPrivileged { return YES;};
@end
// CLASSID: 41200
@implementation    PGSLoginFailureResponse
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOGINFAILURERESPONSE;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41201
@implementation    PGSLoginIncompleteLaunchURL
@synthesize  errorCode=mErrorCode;
@synthesize  interceptorName=mInterceptorName;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOGININCOMPLETELAUNCHURL;
        mErrorCode = 0;
         mInterceptorName = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mInterceptorName release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.errorCode = [byteArrayReader getInt];
    self.interceptorName = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mErrorCode];
    [byteArrayWriter putString:mInterceptorName];
}
@end
// CLASSID: 41202
@implementation    PGSLoginServiceUnavailable
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOGINSERVICEUNAVAILABLE;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41203
@implementation    PGSLoginSuccessResponse
@synthesize  ssoKey=mSsoKey;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOGINSUCCESSRESPONSE;
        mSsoKey = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mSsoKey release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.ssoKey = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mSsoKey];
}
@end
// CLASSID: 41204
@implementation    PGSLoginSuccessUserProfile
@synthesize  userProfile=mUserProfile;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_LOGINSUCCESSUSERPROFILE;
        mUserProfile = [[PGSUserProfile alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mUserProfile release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.userProfile = [byteArrayReader getObject];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putObject:mUserProfile];
}
@end
// CLASSID: 41205
@implementation    PGSSSOKeyMessage
@synthesize  encodedSSOKey=mEncodedSSOKey;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SSOKEYMESSAGE;
        mEncodedSSOKey = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mEncodedSSOKey release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.encodedSSOKey = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mEncodedSSOKey];
}
@end
// CLASSID: 41206
@implementation    PGSClientResolutionDetails
@synthesize  brandId=mBrandId;
@synthesize  productId=mProductId;
@synthesize  ip=mIp;
@synthesize  ucid=mUcid;
@synthesize  width=mWidth;
@synthesize  height=mHeight;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CLIENTRESOLUTIONDETAILS;
        mBrandId = [[NSString alloc] init];
         mProductId = [[NSString alloc] init];
         mIp = [[NSString alloc] init];
         mUcid = [[NSString alloc] init];
         mWidth = 0;
         mHeight = 0;
     }
    return self;
}
-(void) dealloc{
    [mBrandId release];
    [mProductId release];
    [mIp release];
    [mUcid release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.brandId = [byteArrayReader getString];
    self.height = [byteArrayReader getInt];
    self.ip = [byteArrayReader getString];
    self.productId = [byteArrayReader getString];
    self.ucid = [byteArrayReader getString];
    self.width = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mBrandId];
    [byteArrayWriter putInt:mHeight];
    [byteArrayWriter putString:mIp];
    [byteArrayWriter putString:mProductId];
    [byteArrayWriter putString:mUcid];
    [byteArrayWriter putInt:mWidth];
}
@end
// CLASSID: 41207
@implementation    PGSClientSwitchMessage
@synthesize  navigationUrl=mNavigationUrl;
@synthesize  clientUrl=mClientUrl;
@synthesize  silent=mSilent;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_CLIENTSWITCHMESSAGE;
        mNavigationUrl = [[NSString alloc] init];
         mClientUrl = [[NSString alloc] init];
         mSilent = NO;
     }
    return self;
}
-(void) dealloc{
    [mNavigationUrl release];
    [mClientUrl release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.navigationUrl = [byteArrayReader getString];
    self.clientUrl = [byteArrayReader getString];
    self.silent = [byteArrayReader getBOOL];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mNavigationUrl];
    [byteArrayWriter putString:mClientUrl];
    [byteArrayWriter putBOOL:mSilent];
}
@end
// CLASSID: 41208
@implementation    PGSAvatarDetails
@synthesize  avatarStatus=mAvatarStatus;
@synthesize  avatarImageName=mAvatarImageName;
@synthesize  avatarImagePath=mAvatarImagePath;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_AVATARDETAILS;
        mAvatarStatus = 0;
         mAvatarImageName = [[NSString alloc] init];
         mAvatarImagePath = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mAvatarImageName release];
    [mAvatarImagePath release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.avatarStatus = [byteArrayReader getByte];
    self.avatarImageName = [byteArrayReader getString];
    self.avatarImagePath = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByte:mAvatarStatus];
    [byteArrayWriter putString:mAvatarImageName];
    [byteArrayWriter putString:mAvatarImagePath];
}
@end
// CLASSID: 41209
@implementation    PGSAvatarUpdateEventMessage
@synthesize  userId=mUserId;
@synthesize  userAvatarInfo=mUserAvatarInfo;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_AVATARUPDATEEVENTMESSAGE;
        mUserId = [[NSString alloc] init];
         mUserAvatarInfo = [[PGSUserAvatarInfo alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mUserId release];
    [mUserAvatarInfo release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.userId = [byteArrayReader getString];
    self.userAvatarInfo = [byteArrayReader getObject];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putString:mUserId];
    [byteArrayWriter putObject:mUserAvatarInfo];
}
@end
// CLASSID: 41210
@implementation    PGSGameTypeInfo
@synthesize  limitType=mLimitType;
@synthesize  gameType=mGameType;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_GAMETYPEINFO;
        mLimitType = 0;
         mGameType = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.limitType = [byteArrayReader getInt];
    self.gameType = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mLimitType];
    [byteArrayWriter putInt:mGameType];
}
@end
// CLASSID: 41211
@implementation    PGSGameVariantBonus
@synthesize  gameCategory=mGameCategory;
@synthesize  allowedStakesInCents=mAllowedStakesInCents;
@synthesize  allowedSeats=mAllowedSeats;
@synthesize  allowedPools=mAllowedPools;
@synthesize  allowedGameTypes=mAllowedGameTypes;
@synthesize  gvb=mGvb;
@synthesize  bonusAmount=mBonusAmount;
@synthesize  accountCurrencyType=mAccountCurrencyType;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_GAMEVARIANTBONUS;
        mGameCategory = 0;
         mAllowedStakesInCents = [[NSMutableArray alloc] init];
         mAllowedSeats = [[NSMutableArray alloc] init];
         mAllowedPools = [[NSMutableArray alloc] init];
         mAllowedGameTypes = [[NSMutableArray alloc] init];
         mGvb = NO;
         mBonusAmount = 0;
         mAccountCurrencyType = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mAllowedStakesInCents release];
    [mAllowedSeats release];
    [mAllowedPools release];
    [mAllowedGameTypes release];
    [mAccountCurrencyType release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.gameCategory = [byteArrayReader getInt];
    self.allowedStakesInCents = [byteArrayReader getIntArray];
    self.allowedSeats = [byteArrayReader getIntArray];
    self.allowedPools = [byteArrayReader getIntArray];
    self.allowedGameTypes = [byteArrayReader getObjectArray];
    self.gvb = [byteArrayReader getBOOL];
    self.bonusAmount = [byteArrayReader getInt64];
    self.accountCurrencyType = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mGameCategory];
    [byteArrayWriter putIntArray:mAllowedStakesInCents];
    [byteArrayWriter putIntArray:mAllowedSeats];
    [byteArrayWriter putIntArray:mAllowedPools];
    [byteArrayWriter putObjectArray:mAllowedGameTypes];
    [byteArrayWriter putBOOL:mGvb];
    [byteArrayWriter putInt64:mBonusAmount];
    [byteArrayWriter putString:mAccountCurrencyType];
}
@end
// CLASSID: 41212
@implementation    PGSPlayBalance
@synthesize  chips=mChips;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_PLAYBALANCE;
        mChips = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.chips = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mChips];
}
@end
// CLASSID: 41213
@implementation    PGSRealBalance
@synthesize  accountBalance=mAccountBalance;
@synthesize  accountCurrency=mAccountCurrency;
@synthesize  cashOutableBalance=mCashOutableBalance;
@synthesize  restrictedBalance=mRestrictedBalance;
@synthesize  PayPalBalance=mPayPalBalance;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REALBALANCE;
        mAccountBalance = 0;
         mAccountCurrency = [[NSString alloc] init];
         mCashOutableBalance = 0;
         mRestrictedBalance = [[NSMutableArray alloc] init];
         mPayPalBalance = 0;
     }
    return self;
}
-(void) dealloc{
    [mAccountCurrency release];
    [mRestrictedBalance release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountBalance = [byteArrayReader getInt64];
    self.accountCurrency = [byteArrayReader getString];
    self.cashOutableBalance = [byteArrayReader getInt64];
    self.restrictedBalance = [byteArrayReader getObjectArray];
    self.PayPalBalance = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mAccountBalance];
    [byteArrayWriter putString:mAccountCurrency];
    [byteArrayWriter putInt64:mCashOutableBalance];
    [byteArrayWriter putObjectArray:mRestrictedBalance];
    [byteArrayWriter putInt64:mPayPalBalance];
}
@end
// CLASSID: 41214
@implementation    PGSRequestUserBalanceInfo
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTUSERBALANCEINFO;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41215
@implementation    PGSTourneyCurrencyBalance
@synthesize  tourneyCurrencyBalance=mTourneyCurrencyBalance;
@synthesize  tourneyCurrencyType=mTourneyCurrencyType;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_TOURNEYCURRENCYBALANCE;
        mTourneyCurrencyBalance = 0;
         mTourneyCurrencyType = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mTourneyCurrencyType release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.tourneyCurrencyBalance = [byteArrayReader getInt64];
    self.tourneyCurrencyType = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mTourneyCurrencyBalance];
    [byteArrayWriter putString:mTourneyCurrencyType];
}
@end
// CLASSID: 41216
@implementation    PGSResponseUserBalanceInfo
@synthesize  playBalance=mPlayBalance;
@synthesize  realBalance=mRealBalance;
@synthesize  tourneyCurrencyBalance=mTourneyCurrencyBalance;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEUSERBALANCEINFO;
        mPlayBalance = [[PGSPlayBalance alloc] init];
         mRealBalance = [[PGSRealBalance alloc] init];
         mTourneyCurrencyBalance = [[PGSTourneyCurrencyBalance alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mPlayBalance release];
    [mRealBalance release];
    [mTourneyCurrencyBalance release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.playBalance = [byteArrayReader getObject];
    self.realBalance = [byteArrayReader getObject];
    self.tourneyCurrencyBalance = [byteArrayReader getObject];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putObject:mPlayBalance];
    [byteArrayWriter putObject:mRealBalance];
    [byteArrayWriter putObject:mTourneyCurrencyBalance];
}
@end
// CLASSID: 41217
@implementation    PGSResponseUserBalanceInfoError
@synthesize  errorCode=mErrorCode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSEUSERBALANCEINFOERROR;
        mErrorCode = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.errorCode = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mErrorCode];
}
@end
// CLASSID: 41218
@implementation    PGSNotifyPlayerProfileWithSSOKey
@synthesize  sessionKey=mSessionKey;
@synthesize  encryptedProfile=mEncryptedProfile;
@synthesize  encodedSSOKey=mEncodedSSOKey;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_NOTIFYPLAYERPROFILEWITHSSOKEY;
        mSessionKey = [[NSString alloc] init];
         mEncryptedProfile = [[NSData alloc] init];
         mEncodedSSOKey = [[NSString alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mSessionKey release];
    [mEncryptedProfile release];
    [mEncodedSSOKey release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.encryptedProfile = [byteArrayReader getByteArray];
    self.sessionKey = [byteArrayReader getString];
    self.encodedSSOKey = [byteArrayReader getString];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putByteArray:mEncryptedProfile];
    [byteArrayWriter putString:mSessionKey];
    [byteArrayWriter putString:mEncodedSSOKey];
}
@end
// CLASSID: 41219
@implementation    PGSNetRealBalance
@synthesize  accountBalance=mAccountBalance;
@synthesize  accountCurrency=mAccountCurrency;
@synthesize  cashOutableBalance=mCashOutableBalance;
@synthesize  restrictedBalance=mRestrictedBalance;
@synthesize  netAccountBalance=mNetAccountBalance;
@synthesize  payPalBalance=mPayPalBalance;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_NETREALBALANCE;
        mAccountBalance = 0;
         mAccountCurrency = [[NSString alloc] init];
         mCashOutableBalance = 0;
         mRestrictedBalance = [[NSMutableArray alloc] init];
         mNetAccountBalance = 0;
         mPayPalBalance = 0;
     }
    return self;
}
-(void) dealloc{
    [mAccountCurrency release];
    [mRestrictedBalance release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.accountBalance = [byteArrayReader getInt64];
    self.accountCurrency = [byteArrayReader getString];
    self.cashOutableBalance = [byteArrayReader getInt64];
    self.restrictedBalance = [byteArrayReader getObjectArray];
    self.netAccountBalance = [byteArrayReader getInt64];
    self.payPalBalance = [byteArrayReader getInt64];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt64:mAccountBalance];
    [byteArrayWriter putString:mAccountCurrency];
    [byteArrayWriter putInt64:mCashOutableBalance];
    [byteArrayWriter putObjectArray:mRestrictedBalance];
    [byteArrayWriter putInt64:mNetAccountBalance];
    [byteArrayWriter putInt64:mPayPalBalance];
}
@end
// CLASSID: 41220
@implementation    PGSRequestNetUserBalanceInfo
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTNETUSERBALANCEINFO;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41221
@implementation    PGSResponseNetUserBalanceInfo
@synthesize  playBalance=mPlayBalance;
@synthesize  netRealBalance=mNetRealBalance;
@synthesize  tourneyCurrencyBalance=mTourneyCurrencyBalance;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSENETUSERBALANCEINFO;
        mPlayBalance = [[PGSPlayBalance alloc] init];
         mNetRealBalance = [[PGSNetRealBalance alloc] init];
         mTourneyCurrencyBalance = [[PGSTourneyCurrencyBalance alloc] init];
     }
    return self;
}
-(void) dealloc{
    [mPlayBalance release];
    [mNetRealBalance release];
    [mTourneyCurrencyBalance release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.playBalance = [byteArrayReader getObject];
    self.netRealBalance = [byteArrayReader getObject];
    self.tourneyCurrencyBalance = [byteArrayReader getObject];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putObject:mPlayBalance];
    [byteArrayWriter putObject:mNetRealBalance];
    [byteArrayWriter putObject:mTourneyCurrencyBalance];
}
@end
// CLASSID: 41222
@implementation    PGSResponseNetUserBalanceInfoError
@synthesize  errorCode=mErrorCode;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RESPONSENETUSERBALANCEINFOERROR;
        mErrorCode = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.errorCode = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mErrorCode];
}
@end
// CLASSID: 41223
@implementation    PGSSessionLimitLogout
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_SESSIONLIMITLOGOUT;
    }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
}
@end
// CLASSID: 41224
@implementation    PGSRequestToStayORLogOutOnUserAction
@synthesize  timeLeftInSec=mTimeLeftInSec;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_REQUESTTOSTAYORLOGOUTONUSERACTION;
        mTimeLeftInSec = 0;
     }
    return self;
}
-(void) dealloc{
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.timeLeftInSec = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putInt:mTimeLeftInSec];
}
@end
// CLASSID: 69633
@implementation RTPointsUpdate
@synthesize  isPointsEnabled=mIsPointsEnabled;
@synthesize  playerCategory=mPlayerCategory;
@synthesize  points=mPoints;
-(id) init{
    self = [super init];
    if (self != nil) {
        mClassID = CLASS_ID_RTPOINTSUPDATE;
        mIsPointsEnabled = NO;
         mPlayerCategory = [[NSString alloc] init];
         mPoints = 0;
     }
    return self;
}
-(void) dealloc{
    [mPlayerCategory release];
    [super dealloc];
}

-(void) read:(PGByteArrayReader*) byteArrayReader{
    [super read:byteArrayReader];
    self.isPointsEnabled = [byteArrayReader getBOOL];
    self.playerCategory = [byteArrayReader getString];
    self.points = [byteArrayReader getInt];
}
    
-(void) write:(PGByteArrayWriter*) byteArrayWriter{
    [super write:byteArrayWriter];
    [byteArrayWriter putBOOL:mIsPointsEnabled];
    [byteArrayWriter putString:mPlayerCategory];
    [byteArrayWriter putInt:mPoints];
}
@end

