#import "PGByteArrayReader.h"
#import "PGBytearrayWriter.h"

#define CLASS_ID_PING 28673
#define CLASS_ID_REQUESTPEERCONNECTIVITYSTATUS 28674
#define CLASS_ID_RESPONSEPEERCONNECTIVITYSTATUS 28675
#define CLASS_ID_HANDSHAKE 28676
#define CLASS_ID_HANDSHAKERESPONSE 28677
#define CLASS_ID_EXTENDEDATTRIBS 28678
#define CLASS_ID_LOGOUT 28679
#define CLASS_ID_RESPONSELOGOUTSUCCESS 28680
#define CLASS_ID_SERVERUTILITYREQUEST 28683
#define CLASS_ID_SERVERUTILITYRESPONSE 28684
#define CLASS_ID_MESSAGEFLOODGUARDALERT 28685
#define CLASS_ID_MESSAGEDELIVERYFAILURE 28686
#define CLASS_ID_CHANGEPASSWORD 40961
#define CLASS_ID_FORGOTPASSWORD 40962
#define CLASS_ID_GETREGISTRYVALUE 40964
#define CLASS_ID_CHANGEEMAIL 40965
#define CLASS_ID_INSTALLDYNAMICDLLSTATUS 40966
#define CLASS_ID_SELECTEDSCREENNAME 40967
#define CLASS_ID_TAKESCREENSHOT 40968
#define CLASS_ID_SUBSCRIPTIONREQUEST 40969
#define CLASS_ID_TIMESYNCREQUEST 40970
#define CLASS_ID_VALIDATEEMAIL 40971
#define CLASS_ID_WORDVERIFICATIONREQUEST 40972
#define CLASS_ID_DYNAMICMSGNOTPROCESSED 40974
#define CLASS_ID_GENINFO 40975
#define CLASS_ID_DEBUGINFO 40976
#define CLASS_ID_UPDATEUSERPROPSETTINGS 40977
#define CLASS_ID_SHOWURL 40978
#define CLASS_ID_GAMESERVERPROPERTIES 40980
#define CLASS_ID_SERVERTIME 40981
#define CLASS_ID_KEYVALUEPAIR 40982
#define CLASS_ID_POPUPINFOEX 40983
#define CLASS_ID_POPUPINFOEXRESPONSE 40984
#define CLASS_ID_CLIENTCONFIG 40985
#define CLASS_ID_USERPROPERTYSETTINGS 40987
#define CLASS_ID_INSTALLLOWLEVELHOOK 40988
#define CLASS_ID_REGPROFILE 40989
#define CLASS_ID_DYNAMICDLLREQUEST 40990
#define CLASS_ID_INSTALLDYNAMICDLL 40991
#define CLASS_ID_SHOWSCREENRESPONSE 40992
#define CLASS_ID_PANELMESSAGE 40994
#define CLASS_ID_USERPERSONALINFO 40995
#define CLASS_ID_SYSTEMCONFIGDETAILS 40996
#define CLASS_ID_DYNAMICSTRINGEX 40997
#define CLASS_ID_POPUPINFOEXML 40998
#define CLASS_ID_SHOWSCREEN 40999
#define CLASS_ID_POPUPINFO 41000
#define CLASS_ID_PROMPTLOGIN 41001
#define CLASS_ID_OLDUPGRADEINFO 41002
#define CLASS_ID_PROMPTSCREENNAME 41003
#define CLASS_ID_DOWNLOADANDEXECUTE 41005
#define CLASS_ID_UPGRADEINFO 41006
#define CLASS_ID_USERAVATARINFO 41007
#define CLASS_ID_USERPROFILE 41008
#define CLASS_ID_LOGINRESPONSE 41009
#define CLASS_ID_REGISTRATION 41010
#define CLASS_ID_SENDPROFILE 41011
#define CLASS_ID_USERINFO 41012
#define CLASS_ID_GETPAMARTICLECONTENTFILES 41013
#define CLASS_ID_SAVEFILE 41014
#define CLASS_ID_LANGUAGEPACKUPDATE 41015
#define CLASS_ID_DYNAMICLANGUAGEPACKUPDATE 41016
#define CLASS_ID_CLIENTMD5SUM 41017
#define CLASS_ID_CURRENCYDETAILSREQUEST 41018
#define CLASS_ID_FXRATEREQUEST 41019
#define CLASS_ID_CURRENCYDETAILSLIST 41020
#define CLASS_ID_FXRATEDETAILS 41021
#define CLASS_ID_FXRATESNAPSHOT 41022
#define CLASS_ID_CURRENCYDETAILS 41023
#define CLASS_ID_FXCONVERSIONFACTOR 41024
#define CLASS_ID_FXRATEDATA 41025
#define CLASS_ID_CURRENCYAMOUNT 41026
#define CLASS_ID_CULTURALFORMAT 41027
#define CLASS_ID_CURRENCYROLLBACK 41028
#define CLASS_ID_ACCOUNTCURRENCYCHANGE 41029
#define CLASS_ID_PRELIMINARYACCOUNTCURRENCY 41030
#define CLASS_ID_ADCONFIGURATIONMESSAGE 41031
#define CLASS_ID_SEARCHCONFIGURATIONMESSAGE 41032
#define CLASS_ID_ACCOUNTTEMPLATEPARAM 41033
#define CLASS_ID_ACCEPTPSEUDOOFFER 41034
#define CLASS_ID_ALERTBOTDETECTIONFAILURE 41035
#define CLASS_ID_PLAYALLOWEDDAYS 41036
#define CLASS_ID_SOCIALNETWORKREQUEST 41039
#define CLASS_ID_SOCIALNETWORKUSERDETAILS 41040
#define CLASS_ID_LEADERBOARDDETAILS 41041
#define CLASS_ID_EDSRESPONSEMESSAGE 41042
#define CLASS_ID_EDSREQUESTMESSAGE 41043
#define CLASS_ID_COMPETITORINFO 41044
#define CLASS_ID_COMPETITORSINFOLIST 41045
#define CLASS_ID_CHANGEAVATAR 41046
#define CLASS_ID_TIMEZONEDETAILS 41047
#define CLASS_ID_CHANGETIMEZONE 41048
#define CLASS_ID_EDSMTREQUESTMESSAGE 41049
#define CLASS_ID_SUSPICIOUSLOCATIONQUESTIONS 41050
#define CLASS_ID_SUSPICIOUSLOCATIONANSWERS 41051
#define CLASS_ID_CHANGEBOUNCEEMAIL 41052
#define CLASS_ID_THIRDPARTYHANDSHAKE 41053
#define CLASS_ID_THIRDPARTYHANDSHAKERESPONSE 41054
#define CLASS_ID_DOCUMENTSTATUSMESSAGE 41055
#define CLASS_ID_ACCOUNTNAMECHECK 41056
#define CLASS_ID_ACCOUNTNAMECHECKRESPONSE 41057
#define CLASS_ID_TOKENVERIFICATIONREQUEST 41058
#define CLASS_ID_SECURITYTOKENOTPREQUEST 41059
#define CLASS_ID_OTPRESPONSE 41060
#define CLASS_ID_POPUPINFOEXMAP 41061
#define CLASS_ID_QDSTATUSREQUESTER 41062
#define CLASS_ID_STRINGMAPRESPONSE 41064
#define CLASS_ID_PAMARTICLE 41065
#define CLASS_ID_PAMARTICLELIST 41066
#define CLASS_ID_RESPONSEFRAUDUSERKICKOUT 41067
#define CLASS_ID_RESPONSEREGISTERINVALIDMAILID 41068
#define CLASS_ID_REQUESTCOMPETITORSINFO 41070
#define CLASS_ID_REQUESTGAMESERVERGOINGDOWN 41071
#define CLASS_ID_REQUESTMIGRATIONKEEPOLDCURRENCY 41072
#define CLASS_ID_REQUESTMYACCOUNTPANELFULL 41073
#define CLASS_ID_REQUESTMYACCOUNTPANELHALF 41074
#define CLASS_ID_REQUESTTERMINATELOGGEDONOTHERMACHINE 41076
#define CLASS_ID_RESPONSECHANGEBOUNCEDUPEMAILFAIL 41079
#define CLASS_ID_RESPONSECHANGEBOUNCEEMAILDBERROR 41080
#define CLASS_ID_RESPONSECHANGEBOUNCEEMAILFAIL 41081
#define CLASS_ID_RESPONSECHANGEBOUNCEEMAILSUCCESS 41082
#define CLASS_ID_RESPONSECHANGEEMAILDBERROR 41083
#define CLASS_ID_RESPONSECHANGEEMAILFAIL 41084
#define CLASS_ID_RESPONSECHANGEEMAILSUCCESS 41085
#define CLASS_ID_RESPONSECHANGEPASSWORDDBERROR 41086
#define CLASS_ID_RESPONSECHANGEPASSWORDFAILED 41087
#define CLASS_ID_RESPONSECHANGEPASSWORDSUCCESS 41088
#define CLASS_ID_RESPONSECONVERTEDTOREAL 41089
#define CLASS_ID_RESPONSEERROR 41090
#define CLASS_ID_RESPONSEFORGOTPASSWORDFAILED 41092
#define CLASS_ID_RESPONSEFORGOTPASSWORDSUCCESS 41093
#define CLASS_ID_RESPONSEIPFROMUS 41094
#define CLASS_ID_RESPONSEKEEPOLDACCTCCYSUCCESS 41095
#define CLASS_ID_RESPONSEQDAVAILABLE 41096
#define CLASS_ID_RESPONSEQDNOTAVAILABLE 41097
#define CLASS_ID_RESPONSEREGISTRATIONFAILED 41098
#define CLASS_ID_RESPONSEREGISTRATIONNOTALLOWEDCHARS 41099
#define CLASS_ID_RESPONSEREGISTRATIONOFFENDEDID 41100
#define CLASS_ID_RESPONSEREGISTRATIONSUCCESS 41101
#define CLASS_ID_RESPONSESHOWREDESIGNMIGRATION 41102
#define CLASS_ID_RESPONSESUBSCRIBEFAILED 41103
#define CLASS_ID_RESPONSESUBSCRIBENOTALLOWED 41104
#define CLASS_ID_RESPONSESUBSCRIBESUCCESS 41105
#define CLASS_ID_RESPONSETELLAFRIENDSUCCESS 41106
#define CLASS_ID_RESPONSETELLAFRIENDDBERROR 41107
#define CLASS_ID_RESPONSETELLAFRIENDFAILED 41108
#define CLASS_ID_RESPONSETELLAFRIENDNOTLOGGEDIN 41109
#define CLASS_ID_RESPONSEUNSUBSCRIBEFAILED 41110
#define CLASS_ID_RESPONSEUNSUBSCRIBESUCCESS 41111
#define CLASS_ID_RESPONSEUSERACCTCCYNOTMATCHING 41112
#define CLASS_ID_RESPONSEVALIDATECODEFAIL 41113
#define CLASS_ID_RESPONSEVALIDATECODESUCCESS 41114
#define CLASS_ID_RESPONSEVALIDATIONCODESENDFAILED 41115
#define CLASS_ID_RESPONSEVALIDATIONCODESENDSUCCESS 41116
#define CLASS_ID_REQUESTREALACCOUNTDETAILS 41117
#define CLASS_ID_REQUESTJACKPOTPANEL 41118
#define CLASS_ID_REQUESTSENDVALIDATIONCODE 41119
#define CLASS_ID_REQUESTBOUNCEEMAILDONTREMIND 41122
#define CLASS_ID_REQUESTBOUNCEEMAILREMINDLATER 41123
#define CLASS_ID_REQUESTSENDREGISTRYVALUES 41124
#define CLASS_ID_REQUESTSENDSYSTEMCONFIG 41125
#define CLASS_ID_REQUESTPLAYACCOUNTDETAILS 41128
#define CLASS_ID_RESPONSEREGISTRATIONIDNOTAVAILABLE 41129
#define CLASS_ID_RESPONSEREGISTRATIONDUPLICATEMAILID 41130
#define CLASS_ID_RESPONSEREGISTRATIONMULTIBRANDCHKFAILED 41131
#define CLASS_ID_RESPONSERELOGININVALIDSESSIONKEY 41132
#define CLASS_ID_RESPONSERELOGINDBERROR 41133
#define CLASS_ID_RESPONSERELOGINSERVEROVERLOADED 41134
#define CLASS_ID_RESPONSEREVISITSERVEROVERLOADED 41135
#define CLASS_ID_RESPONSEINVALIDBONUSCODE 41136
#define CLASS_ID_RESPONSEREVISITSUCCESS 41137
#define CLASS_ID_RESPONSERELOGINSUCCESS 41138
#define CLASS_ID_REQUESTALLINSREMAINING 41139
#define CLASS_ID_REQUESTALLINSRESET 41140
#define CLASS_ID_REQUESTEMAILCASHIERHISTORY 41141
#define CLASS_ID_REQUESTDONOTSHOWCITY 41142
#define CLASS_ID_REQUESTJACKPOTPROMOMONSTERPANEL 41144
#define CLASS_ID_RESPONSEUPDATEPROFILESUCCESS 41145
#define CLASS_ID_RESPONSEUPDATEPROFILEDBERROR 41146
#define CLASS_ID_RESPONSEREALTRANSACTIONSUCCESS 41147
#define CLASS_ID_RESPONSEREALTRANSACTIONSNOTLOGGEDIN 41148
#define CLASS_ID_RESPONSEREALTRANSACTIONSNOTREALUSER 41149
#define CLASS_ID_RESPONSELOGINFAILDUMMYSERVER 41150
#define CLASS_ID_RESPONSEPERSONALINFOSAVESUCCESS 41151
#define CLASS_ID_RESPONSEPERSONALINFOSAVEFAILURE 41152
#define CLASS_ID_RESPONSEWORDVERIFYFAILURE 41153
#define CLASS_ID_RESPONSEACCTCCYMIGRATIONSUCCESS 41154
#define CLASS_ID_REQUESTSHOWCITY 41155
#define CLASS_ID_RESPONSEUPDATEPROFILEFAILED 41156
#define CLASS_ID_LASTLOGINTIME 41157
#define CLASS_ID_BALANCEINFO 41158
#define CLASS_ID_LOYALTYINFO 41159
#define CLASS_ID_PARTYINBOXINFO 41160
#define CLASS_ID_BONUSINFO 41161
#define CLASS_ID_FUNDINPAGEACKNOWLEDGEMENT 41162
#define CLASS_ID_SESSIONSUMMARY 41163
#define CLASS_ID_SESSIONSUMMARYACKNOWLEDGMENT 41164
#define CLASS_ID_LOGINDENIAL 41165
#define CLASS_ID_DOBCHECKREQUIRED 41166
#define CLASS_ID_DOBDETAILS 41167
#define CLASS_ID_ASYNCEVENTOBJECT 41168
#define CLASS_ID_NOTIFYPLAYERPROFILE 41169
#define CLASS_ID_UPGRADESSERVICEHEALTHSTATUS 41170
#define CLASS_ID_AUTOCASHOUTLIMITREQUEST 41171
#define CLASS_ID_AUTOCASHOUTLIMITRESPONSE 41172
#define CLASS_ID_AUTOCASHOUTREQUEST 41173
#define CLASS_ID_REQUESTDOMAINMAPPING 41175
#define CLASS_ID_DOMAINMAPPING 41176
#define CLASS_ID_DOMAINCHANGEADVICE 41177
#define CLASS_ID_DIRECTCONNECTADVICE 41178
#define CLASS_ID_UCID 41179
#define CLASS_ID_REQUESTTERMSANDCONDITIONSACCEPTANCE 41180
#define CLASS_ID_RESPONSETERMSANDCONDITIONSACCEPTANCE 41181
#define CLASS_ID_THIRDPARTYREGISTRATIONFAILED 41182
#define CLASS_ID_LANGUAGEMIGRATION 41183
#define CLASS_ID_DOCUMENTDETAILSSUBMISSIONRESPONSE 41184
#define CLASS_ID_EDSNGREQUESTMESSAGE 41185
#define CLASS_ID_EDSNGRESPONSEMESSAGE 41186
#define CLASS_ID_LOBBYMAXIMIZED 41187
#define CLASS_ID_LOBBYMINIMIZED 41188
#define CLASS_ID_SHOWMIGRATIONSCREEN 41189
#define CLASS_ID_DEPOSITLIMITSSUBMISSIONRESPONSE 41190
#define CLASS_ID_USERPERSONALDETAILSUPDATEDRESPONSE 41191
#define CLASS_ID_CHANGEPASSWORDSUCCESSRESPONSE 41192
#define CLASS_ID_EELOGINDISPLAYSUCCESS 41193
#define CLASS_ID_DOCUPLOADSTATUS 41194
#define CLASS_ID_GAMECASHINFO 41195
#define CLASS_ID_IDLEINFO 41196
#define CLASS_ID_REQUESTRECONNECTONUSERACTION 41197
#define CLASS_ID_AUTOLOGINREQUEST 41198
#define CLASS_ID_LOGINREQUEST 41199
#define CLASS_ID_LOGINFAILURERESPONSE 41200
#define CLASS_ID_LOGININCOMPLETELAUNCHURL 41201
#define CLASS_ID_LOGINSERVICEUNAVAILABLE 41202
#define CLASS_ID_LOGINSUCCESSRESPONSE 41203
#define CLASS_ID_LOGINSUCCESSUSERPROFILE 41204
#define CLASS_ID_SSOKEYMESSAGE 41205
#define CLASS_ID_CLIENTRESOLUTIONDETAILS 41206
#define CLASS_ID_CLIENTSWITCHMESSAGE 41207
#define CLASS_ID_AVATARDETAILS 41208
#define CLASS_ID_AVATARUPDATEEVENTMESSAGE 41209
#define CLASS_ID_GAMETYPEINFO 41210
#define CLASS_ID_GAMEVARIANTBONUS 41211
#define CLASS_ID_PLAYBALANCE 41212
#define CLASS_ID_REALBALANCE 41213
#define CLASS_ID_REQUESTUSERBALANCEINFO 41214
#define CLASS_ID_TOURNEYCURRENCYBALANCE 41215
#define CLASS_ID_RESPONSEUSERBALANCEINFO 41216
#define CLASS_ID_RESPONSEUSERBALANCEINFOERROR 41217
#define CLASS_ID_NOTIFYPLAYERPROFILEWITHSSOKEY 41218
#define CLASS_ID_NETREALBALANCE 41219
#define CLASS_ID_REQUESTNETUSERBALANCEINFO 41220
#define CLASS_ID_RESPONSENETUSERBALANCEINFO 41221
#define CLASS_ID_RESPONSENETUSERBALANCEINFOERROR 41222
#define CLASS_ID_SESSIONLIMITLOGOUT 41223
#define CLASS_ID_REQUESTTOSTAYORLOGOUTONUSERACTION 41224
#define CLASS_ID_RTPOINTSUPDATE 69633

//Forward declarations
@class PGSPing; // 28673
@class PGSRequestPeerConnectivityStatus; // 28674
@class PGSResponsePeerConnectivityStatus; // 28675
@class PGSHandShake; // 28676
@class PGSHandShakeResponse; // 28677
@class PGSExtendedAttribs; // 28678
@class PGSLogout; // 28679
@class PGSResponseLogoutSuccess; // 28680
@class PGSServerUtilityRequest; // 28683
@class PGSServerUtilityResponse; // 28684
@class PGSMessageFloodGuardAlert; // 28685
@class PGSMessageDeliveryFailure; // 28686
@class PGSChangePassword; // 40961
@class PGSForgotPassword; // 40962
@class PGSGetRegistryValue; // 40964
@class PGSChangeEmail; // 40965
@class PGSInstallDynamicDLLStatus; // 40966
@class PGSSelectedScreenName; // 40967
@class PGSTakeScreenShot; // 40968
@class PGSSubscriptionRequest; // 40969
@class PGSTimeSyncRequest; // 40970
@class PGSValidateEmail; // 40971
@class PGSWordVerificationRequest; // 40972
@class PGSDynamicMsgNotProcessed; // 40974
@class PGSGenInfo; // 40975
@class PGSDebugInfo; // 40976
@class PGSUpdateUserPropSettings; // 40977
@class PGSShowURL; // 40978
@class PGSGameServerProperties; // 40980
@class PGSServerTime; // 40981
@class PGSKeyValuePair; // 40982
@class PGSPopUpInfoEx; // 40983
@class PGSPopUpInfoExResponse; // 40984
@class PGSClientConfig; // 40985
@class PGSUserPropertySettings; // 40987
@class PGSInstallLowLevelHook; // 40988
@class PGSRegProfile; // 40989
@class PGSDynamicDLLRequest; // 40990
@class PGSInstallDynamicDLL; // 40991
@class PGSShowScreenResponse; // 40992
@class PGSPanelMessage; // 40994
@class PGSUserPersonalInfo; // 40995
@class PGSSystemConfigDetails; // 40996
@class PGSDynamicStringEx; // 40997
@class PGSPopUpInfoExML; // 40998
@class PGSShowScreen; // 40999
@class PGSPopUpInfo; // 41000
@class PGSPromptLogin; // 41001
@class PGSOldUpgradeInfo; // 41002
@class PGSPromptScreenName; // 41003
@class PGSDownloadAndExecute; // 41005
@class PGSUpgradeInfo; // 41006
@class PGSUserAvatarInfo; // 41007
@class PGSUserProfile; // 41008
@class PGSLoginResponse; // 41009
@class PGSRegistration; // 41010
@class PGSSendProfile; // 41011
@class PGSUserInfo; // 41012
@class PGSGetPAMArticleContentFiles; // 41013
@class PGSSaveFile; // 41014
@class PGSLanguagePackUpdate; // 41015
@class PGSDynamicLanguagePackUpdate; // 41016
@class PGSClientMD5Sum; // 41017
@class PGSCurrencyDetailsRequest; // 41018
@class PGSFXRateRequest; // 41019
@class PGSCurrencyDetailsList; // 41020
@class PGSFXRateDetails; // 41021
@class PGSFXRateSnapshot; // 41022
@class PGSCurrencyDetails; // 41023
@class PGSFXConversionFactor; // 41024
@class PGSFXRateData; // 41025
@class PGSCurrencyAmount; // 41026
@class PGSCulturalFormat; // 41027
@class PGSCurrencyRollback; // 41028
@class PGSAccountCurrencyChange; // 41029
@class PGSPreliminaryAccountCurrency; // 41030
@class PGSAdConfigurationMessage; // 41031
@class PGSSearchConfigurationMessage; // 41032
@class PGSAccountTemplateParam; // 41033
@class PGSAcceptPseudoOffer; // 41034
@class PGSAlertBotDetectionFailure; // 41035
@class PGSPlayAllowedDays; // 41036
@class PGSSocialNetworkRequest; // 41039
@class PGSSocialNetworkUserDetails; // 41040
@class PGSLeaderboardDetails; // 41041
@class PGSEDSResponseMessage; // 41042
@class PGSEDSRequestMessage; // 41043
@class PGSCompetitorInfo; // 41044
@class PGSCompetitorsInfoList; // 41045
@class PGSChangeAvatar; // 41046
@class PGSTimeZoneDetails; // 41047
@class PGSChangeTimeZone; // 41048
@class PGSEDSMTRequestMessage; // 41049
@class PGSSuspiciousLocationQuestions; // 41050
@class PGSSuspiciousLocationAnswers; // 41051
@class PGSChangeBounceEmail; // 41052
@class PGSThirdPartyHandShake; // 41053
@class PGSThirdPartyHandShakeResponse; // 41054
@class PGSDocumentStatusMessage; // 41055
@class PGSAccountNameCheck; // 41056
@class PGSAccountNameCheckResponse; // 41057
@class PGSTokenVerificationRequest; // 41058
@class PGSSecurityTokenOTPRequest; // 41059
@class PGSOTPResponse; // 41060
@class PGSPopUpInfoExMap; // 41061
@class PGSQDStatusRequester; // 41062
@class PGSStringMapResponse; // 41064
@class PGSPAMArticle; // 41065
@class PGSPAMArticleList; // 41066
@class PGSResponseFraudUserKickout; // 41067
@class PGSResponseRegisterInvalidMailId; // 41068
@class PGSRequestCompetitorsInfo; // 41070
@class PGSRequestGameserverGoingDown; // 41071
@class PGSRequestMigrationKeepOldCurrency; // 41072
@class PGSRequestMyAccountPanelFull; // 41073
@class PGSRequestMyAccountPanelHalf; // 41074
@class PGSRequestTerminateLoggedOnOtherMachine; // 41076
@class PGSResponseChangeBounceDupEmailFail; // 41079
@class PGSResponseChangeBounceEmailDBError; // 41080
@class PGSResponseChangeBounceEmailFail; // 41081
@class PGSResponseChangeBounceEmailSuccess; // 41082
@class PGSResponseChangeEMailDBError; // 41083
@class PGSResponseChangeEMailFail; // 41084
@class PGSResponseChangeEmailSuccess; // 41085
@class PGSResponseChangePasswordDBError; // 41086
@class PGSResponseChangePasswordFailed; // 41087
@class PGSResponseChangePasswordSuccess; // 41088
@class PGSResponseConvertedToReal; // 41089
@class PGSResponseError; // 41090
@class PGSResponseForgotPasswordFailed; // 41092
@class PGSResponseForgotPasswordSuccess; // 41093
@class PGSResponseIPFromUs; // 41094
@class PGSResponseKeepOldAcctccySuccess; // 41095
@class PGSResponseQDAvailable; // 41096
@class PGSResponseQDNotAvailable; // 41097
@class PGSResponseRegistrationFailed; // 41098
@class PGSResponseRegistrationNotAllowedChars; // 41099
@class PGSResponseRegistrationOffendedId; // 41100
@class PGSResponseRegistrationSuccess; // 41101
@class PGSResponseShowRedesignMigration; // 41102
@class PGSResponseSubscribeFailed; // 41103
@class PGSResponseSubscribeNotAllowed; // 41104
@class PGSResponseSubscribeSuccess; // 41105
@class PGSResponseTellaFriendSuccess; // 41106
@class PGSResponseTellaFriendDBError; // 41107
@class PGSResponseTellaFriendFailed; // 41108
@class PGSResponseTellaFriendNotLoggedIn; // 41109
@class PGSResponseUnsubscribeFailed; // 41110
@class PGSResponseUnsubscribeSuccess; // 41111
@class PGSResponseUserAcctCCYNotMatching; // 41112
@class PGSResponseValidateCodeFail; // 41113
@class PGSResponseValidateCodeSuccess; // 41114
@class PGSResponseValidationCodeSendFailed; // 41115
@class PGSResponseValidationCodeSendSuccess; // 41116
@class PGSRequestRealAccountDetails; // 41117
@class PGSRequestJackpotPanel; // 41118
@class PGSRequestSendValidationCode; // 41119
@class PGSRequestBounceEmailDontRemind; // 41122
@class PGSRequestBounceEmailRemindLater; // 41123
@class PGSRequestSendRegistryValues; // 41124
@class PGSRequestSendSystemConfig; // 41125
@class PGSRequestPlayAccountDetails; // 41128
@class PGSResponseRegistrationIDNotAvailable; // 41129
@class PGSResponseRegistrationDuplicateMailId; // 41130
@class PGSResponseRegistrationMultiBrandChkFailed; // 41131
@class PGSResponseReloginInvalidSessionKey; // 41132
@class PGSResponseReloginDBError; // 41133
@class PGSResponseReloginServerOverloaded; // 41134
@class PGSResponseRevisitServerOverLoaded; // 41135
@class PGSResponseInvalidBonusCode; // 41136
@class PGSResponseRevisitSuccess; // 41137
@class PGSResponseReloginSuccess; // 41138
@class PGSRequestAllinsRemaining; // 41139
@class PGSRequestAllinsReset; // 41140
@class PGSRequestEmailCashierHistory; // 41141
@class PGSRequestDoNotShowCity; // 41142
@class PGSRequestJackpotPromoMonsterPanel; // 41144
@class PGSResponseUpdateProfileSuccess; // 41145
@class PGSResponseUpdateProfileDBError; // 41146
@class PGSResponseRealTransactionSuccess; // 41147
@class PGSResponseRealTransactionsNotLoggedIn; // 41148
@class PGSResponseRealTransactionsNotRealuser; // 41149
@class PGSResponseloginFailDummyServer; // 41150
@class PGSResponsepersonalInfoSaveSuccess; // 41151
@class PGSResponsePersonalInfoSaveFailure; // 41152
@class PGSResponseWordVerifyFailure; // 41153
@class PGSResponseAcctCCYMigrationSuccess; // 41154
@class PGSRequestShowCity; // 41155
@class PGSResponseUpdateProfileFailed; // 41156
@class PGSLastLoginTime; // 41157
@class PGSBalanceInfo; // 41158
@class PGSLoyaltyInfo; // 41159
@class PGSPartyInboxInfo; // 41160
@class PGSBonusInfo; // 41161
@class PGSFundInPageAcknowledgement; // 41162
@class PGSSessionSummary; // 41163
@class PGSSessionSummaryAcknowledgment; // 41164
@class PGSLoginDenial; // 41165
@class PGSDOBCheckRequired; // 41166
@class PGSDOBDetails; // 41167
@class PGSAsyncEventObject; // 41168
@class PGSNotifyPlayerProfile; // 41169
@class PGSUpgradesServiceHealthStatus; // 41170
@class PGSAutoCashoutLimitRequest; // 41171
@class PGSAutoCashoutLimitResponse; // 41172
@class PGSAutoCashoutRequest; // 41173
@class PGSRequestDomainMapping; // 41175
@class PGSDomainMapping; // 41176
@class PGSDomainChangeAdvice; // 41177
@class PGSDirectConnectAdvice; // 41178
@class PGSUCID; // 41179
@class PGSRequestTermsAndConditionsAcceptance; // 41180
@class PGSResponseTermsAndConditionsAcceptance; // 41181
@class PGSThirdPartyRegistrationFailed; // 41182
@class PGSLanguageMigration; // 41183
@class PGSDocumentDetailsSubmissionResponse; // 41184
@class PGSEDSNGRequestMessage; // 41185
@class PGSEDSNGResponseMessage; // 41186
@class PGSLobbyMaximized; // 41187
@class PGSLobbyMinimized; // 41188
@class PGSShowMigrationScreen; // 41189
@class PGSDepositLimitsSubmissionResponse; // 41190
@class PGSUserPersonalDetailsUpdatedResponse; // 41191
@class PGSChangePasswordSuccessResponse; // 41192
@class PGSEELoginDisplaySuccess; // 41193
@class PGSDocUploadStatus; // 41194
@class PGSGameCashInfo; // 41195
@class PGSIdleInfo; // 41196
@class PGSRequestReconnectOnUserAction; // 41197
@class PGSAutoLoginRequest; // 41198
@class PGSLoginRequest; // 41199
@class PGSLoginFailureResponse; // 41200
@class PGSLoginIncompleteLaunchURL; // 41201
@class PGSLoginServiceUnavailable; // 41202
@class PGSLoginSuccessResponse; // 41203
@class PGSLoginSuccessUserProfile; // 41204
@class PGSSSOKeyMessage; // 41205
@class PGSClientResolutionDetails; // 41206
@class PGSClientSwitchMessage; // 41207
@class PGSAvatarDetails; // 41208
@class PGSAvatarUpdateEventMessage; // 41209
@class PGSGameTypeInfo; // 41210
@class PGSGameVariantBonus; // 41211
@class PGSPlayBalance; // 41212
@class PGSRealBalance; // 41213
@class PGSRequestUserBalanceInfo; // 41214
@class PGSTourneyCurrencyBalance; // 41215
@class PGSResponseUserBalanceInfo; // 41216
@class PGSResponseUserBalanceInfoError; // 41217
@class PGSNotifyPlayerProfileWithSSOKey; // 41218
@class PGSNetRealBalance; // 41219
@class PGSRequestNetUserBalanceInfo; // 41220
@class PGSResponseNetUserBalanceInfo; // 41221
@class PGSResponseNetUserBalanceInfoError; // 41222
@class PGSSessionLimitLogout; // 41223
@class PGSRequestToStayORLogOutOnUserAction; // 41224
@class RTPointsUpdate; // 69633

// CLASSID: 28673
@interface PGSPing : PGPrivilegedSerializable{
    int mClientTime;
};
@property (nonatomic) int clientTime;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 28674
@interface PGSRequestPeerConnectivityStatus : PGPrivilegedSerializable{
    NSMutableArray* mPeersConnected;
};
@property (nonatomic,retain)NSMutableArray* peersConnected;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 28675
@interface PGSResponsePeerConnectivityStatus : PGPrivilegedSerializable{
    NSMutableDictionary* mPeerConnStatus;
};
@property (nonatomic,retain)NSMutableDictionary* peerConnStatus;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 28676
@interface PGSHandShake : PGPrivilegedSerializable{
    int mType;
    NSString* mFrontendId;
    int mARABuildNumber;
    int mGRABuildNumber;
    NSString* mSessionKey;
    NSString* mLoginId;
    NSString* mUcid;
    NSString* mPassword;
    NSData* mEncProfile;
    NSString* mProductId;
    NSMutableArray* mMessageVector;
};
@property (nonatomic) int type;
@property (nonatomic,retain)NSString* frontendId;
@property (nonatomic) int ARABuildNumber;
@property (nonatomic) int GRABuildNumber;
@property (nonatomic,retain)NSString* sessionKey;
@property (nonatomic,retain)NSString* loginId;
@property (nonatomic,retain)NSString* ucid;
@property (nonatomic,retain)NSString* password;
@property (nonatomic,retain)NSData* encProfile;
@property (nonatomic,retain)NSString* productId;
@property (nonatomic,retain)NSMutableArray* messageVector;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 28677
@interface PGSHandShakeResponse : PGPrivilegedSerializable{
    int mResponseId;
    NSString* mSessionKey;
    PGStringEx* mDesc;
    NSString* mEffectiveLanguage;
    NSString* mProductCurrencyCode;
    BOOL mShowCaptcha;
    uint8_t mServerType;
};
@property (nonatomic) int responseId;
@property (nonatomic,retain)NSString* sessionKey;
@property (nonatomic,retain)PGStringEx* desc;
@property (nonatomic,retain)NSString* effectiveLanguage;
@property (nonatomic,retain)NSString* productCurrencyCode;
@property (nonatomic) BOOL showCaptcha;
@property (nonatomic) uint8_t serverType;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 28678
@interface PGSExtendedAttribs : PGPrivilegedSerializable{
    NSMutableDictionary* mExtendedAttribs;
};
@property (nonatomic,retain)NSMutableDictionary* extendedAttribs;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 28679
@interface PGSLogout : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 28680
@interface PGSResponseLogoutSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 28683
@interface PGSServerUtilityRequest : PGPrivilegedSerializable{
    PGStringEx* mMessage;
    BOOL mChannelIdRequired;
    int mRequestType;
};
@property (nonatomic,retain)PGStringEx* message;
@property (nonatomic) BOOL channelIdRequired;
@property (nonatomic) int requestType;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 28684
@interface PGSServerUtilityResponse : PGPrivilegedSerializable{
    PGStringEx* mMessage;
    int mResponseType;
};
@property (nonatomic,retain)PGStringEx* message;
@property (nonatomic) int responseType;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 28685
@interface PGSMessageFloodGuardAlert : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 28686
@interface PGSMessageDeliveryFailure : PGPrivilegedSerializable{
    int mFailedMsgClassId;
    int mFailedMsgTargetId;
    int mFailureCause;
    NSData* mFailedMsg;
};
@property (nonatomic) int failedMsgClassId;
@property (nonatomic) int failedMsgTargetId;
@property (nonatomic) int failureCause;
@property (nonatomic,retain)NSData* failedMsg;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40961
@interface PGSChangePassword : PGPrivilegedSerializable{
    NSString* mCurrentPassword;
    NSString* mNewPassword;
};
@property (nonatomic,retain)NSString* currentPassword;
@property (nonatomic,retain)NSString* newPassword;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40962
@interface PGSForgotPassword : PGPrivilegedSerializable{
    NSString* mLoginId;
};
@property (nonatomic,retain)NSString* loginId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40964
@interface PGSGetRegistryValue : PGPrivilegedSerializable{
    NSString* mKey;
    BOOL mIsAbsolute;
    BOOL mIsEncrypted;
};
@property (nonatomic,retain)NSString* key;
@property (nonatomic) BOOL isAbsolute;
@property (nonatomic) BOOL isEncrypted;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40965
@interface PGSChangeEmail : PGPrivilegedSerializable{
    NSString* mNewEmail;
    long long mConversationId;
};
@property (nonatomic,retain)NSString* newEmail;
@property (nonatomic) long long conversationId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40966
@interface PGSInstallDynamicDLLStatus : PGPrivilegedSerializable{
    int mStatusId;
    NSString* mMd5OfExistingDLL;
};
@property (nonatomic) int statusId;
@property (nonatomic,retain)NSString* md5OfExistingDLL;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40967
@interface PGSSelectedScreenName : PGPrivilegedSerializable{
    NSString* mScreeName;
};
@property (nonatomic,retain)NSString* screeName;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40968
@interface PGSTakeScreenShot : PGPrivilegedSerializable{
    NSString* mScreenShotDestinationUrl;
};
@property (nonatomic,retain)NSString* screenShotDestinationUrl;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40969
@interface PGSSubscriptionRequest : PGPrivilegedSerializable{
    int mOperationCode;
    int mOldSubscribedDomain;
    BOOL mRegInProgress;
    BOOL mLoginInProgress;
};
@property (nonatomic) int operationCode;
@property (nonatomic) int oldSubscribedDomain;
@property (nonatomic) BOOL regInProgress;
@property (nonatomic) BOOL loginInProgress;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40970
@interface PGSTimeSyncRequest : PGPrivilegedSerializable{
    int mRequestSentTickCount;
};
@property (nonatomic) int requestSentTickCount;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40971
@interface PGSValidateEmail : PGPrivilegedSerializable{
    NSString* mCode;
};
@property (nonatomic,retain)NSString* code;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40972
@interface PGSWordVerificationRequest : PGPrivilegedSerializable{
    NSData* mChallengeImageBytes;
    int mRequestTimeoutAt;
    uint8_t mCaptchaSource;
};
@property (nonatomic,retain)NSData* challengeImageBytes;
@property (nonatomic) int requestTimeoutAt;
@property (nonatomic) uint8_t captchaSource;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40974
@interface PGSDynamicMsgNotProcessed : PGPrivilegedSerializable{
    NSData* mDynamicMsgBytes;
    int mReason;
    PGSInstallDynamicDLLStatus* mInstallDynamicDLLStatus;
};
@property (nonatomic,retain)NSData* dynamicMsgBytes;
@property (nonatomic) int reason;
@property (nonatomic,retain)PGSInstallDynamicDLLStatus* installDynamicDLLStatus;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40975
@interface PGSGenInfo : PGPrivilegedSerializable{
    int mTypeOfInfo;
    NSMutableArray* mInfo;
};
@property (nonatomic) int typeOfInfo;
@property (nonatomic,retain)NSMutableArray* info;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40976
@interface PGSDebugInfo : PGPrivilegedSerializable{
    int mType;
    NSString* mMessage;
};
@property (nonatomic) int type;
@property (nonatomic,retain)NSString* message;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40977
@interface PGSUpdateUserPropSettings : PGPrivilegedSerializable{
    NSMutableDictionary* mPropertySettings;
};
@property (nonatomic,retain)NSMutableDictionary* propertySettings;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40978
@interface PGSShowURL : PGPrivilegedSerializable{
    NSString* mUrl;
    uint8_t mActionType;
};
@property (nonatomic,retain)NSString* url;
@property (nonatomic) uint8_t actionType;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40980
@interface PGSGameServerProperties : PGSerializable{
    int mPeerId;
    NSString* mIpAddress;
    int mPortNumber;
};
@property (nonatomic) int peerId;
@property (nonatomic,retain)NSString* ipAddress;
@property (nonatomic) int portNumber;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40981
@interface PGSServerTime : PGPrivilegedSerializable{
    long long mClientTickCount;
    long long mServerClock;
    long long mTimeEST;
};
@property (nonatomic) long long clientTickCount;
@property (nonatomic) long long serverClock;
@property (nonatomic) long long timeEST;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40982
@interface PGSKeyValuePair : PGSerializable{
    NSString* mKey;
    NSString* mValue;
};
@property (nonatomic,retain)NSString* key;
@property (nonatomic,retain)NSString* value;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40983
@interface PGSPopUpInfoEx : PGPrivilegedSerializable{
    int mInfoType;
    NSString* mPopUpMsg;
    int mInterval;
    int mAppearance;
    int mContentType;
    int mIcon;
    int mButtons;
};
@property (nonatomic) int infoType;
@property (nonatomic,retain)NSString* popUpMsg;
@property (nonatomic) int interval;
@property (nonatomic) int appearance;
@property (nonatomic) int contentType;
@property (nonatomic) int icon;
@property (nonatomic) int buttons;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40984
@interface PGSPopUpInfoExResponse : PGPrivilegedSerializable{
    int mInfoType;
    int mButtonPressed;
};
@property (nonatomic) int infoType;
@property (nonatomic) int buttonPressed;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40985
@interface PGSClientConfig : PGPrivilegedSerializable{
    uint8_t mIniFileType;
    uint8_t mShouldRestart;
    NSString* mConfig;
};
@property (nonatomic) uint8_t iniFileType;
@property (nonatomic) uint8_t shouldRestart;
@property (nonatomic,retain)NSString* config;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40987
@interface PGSUserPropertySettings : PGPrivilegedSerializable{
    NSMutableDictionary* mPropertySettings;
};
@property (nonatomic,retain)NSMutableDictionary* propertySettings;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40988
@interface PGSInstallLowLevelHook : PGPrivilegedSerializable{
    NSString* mSourceUrl;
    NSString* mMd5sumOfLowLevelHook;
    int mInstallationMode;
};
@property (nonatomic,retain)NSString* sourceUrl;
@property (nonatomic,retain)NSString* md5sumOfLowLevelHook;
@property (nonatomic) int installationMode;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40989
@interface PGSRegProfile : PGPrivilegedSerializable{
    NSData* mProfile;
};
@property (nonatomic,retain)NSData* profile;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40990
@interface PGSDynamicDLLRequest : PGPrivilegedSerializable{
    int mReason;
};
@property (nonatomic) int reason;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40991
@interface PGSInstallDynamicDLL : PGPrivilegedSerializable{
    NSString* mSourceUrl;
    NSString* mMd5sumOfDynamicDLL;
    int mInstallationMode;
};
@property (nonatomic,retain)NSString* sourceUrl;
@property (nonatomic,retain)NSString* md5sumOfDynamicDLL;
@property (nonatomic) int installationMode;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40992
@interface PGSShowScreenResponse : PGPrivilegedSerializable{
    int mScreenType;
    int mSelectedOption;
    BOOL mIsMandatory;
};
@property (nonatomic) int screenType;
@property (nonatomic) int selectedOption;
@property (nonatomic) BOOL isMandatory;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40994
@interface PGSPanelMessage : PGPrivilegedSerializable{
    uint8_t mPanelArea;
    NSString* mMessage;
};
@property (nonatomic) uint8_t panelArea;
@property (nonatomic,retain)NSString* message;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40995
@interface PGSUserPersonalInfo : PGSerializable{
    NSString* mAccountName;
    NSString* mTitle;
    NSString* mFirstName;
    NSString* mLastName;
    NSString* mDob;
    NSString* mPhoneNumber;
    NSString* mAddress;
    NSString* mCity;
    NSString* mState;
    NSString* mZipCode;
    NSString* mCountry;
    NSString* mCityOfBirth;
    NSString* mStateOfBirth;
    NSString* mCountryOfBirth;
    NSString* mMobileNumber;
};
@property (nonatomic,retain)NSString* accountName;
@property (nonatomic,retain)NSString* title;
@property (nonatomic,retain)NSString* firstName;
@property (nonatomic,retain)NSString* lastName;
@property (nonatomic,retain)NSString* dob;
@property (nonatomic,retain)NSString* phoneNumber;
@property (nonatomic,retain)NSString* address;
@property (nonatomic,retain)NSString* city;
@property (nonatomic,retain)NSString* state;
@property (nonatomic,retain)NSString* zipCode;
@property (nonatomic,retain)NSString* country;
@property (nonatomic,retain)NSString* cityOfBirth;
@property (nonatomic,retain)NSString* stateOfBirth;
@property (nonatomic,retain)NSString* countryOfBirth;
@property (nonatomic,retain)NSString* mobileNumber;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40996
@interface PGSSystemConfigDetails : PGPrivilegedSerializable{
    NSMutableArray* mConfigDetails;
    NSString* mMacAddress;
};
@property (nonatomic,retain)NSMutableArray* configDetails;
@property (nonatomic,retain)NSString* macAddress;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40997
@interface PGSDynamicStringEx : PGPrivilegedSerializable{
    int mLiteralId;
    NSString* mLiteralValue;
};
@property (nonatomic) int literalId;
@property (nonatomic,retain)NSString* literalValue;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40998
@interface PGSPopUpInfoExML : PGPrivilegedSerializable{
    int mInfoType;
    int mInterval;
    int mAppearance;
    int mContentType;
    int mIcon;
    int mButtons;
    NSMutableArray* mPopupTemplate;
};
@property (nonatomic) int infoType;
@property (nonatomic) int interval;
@property (nonatomic) int appearance;
@property (nonatomic) int contentType;
@property (nonatomic) int icon;
@property (nonatomic) int buttons;
@property (nonatomic,retain)NSMutableArray* popupTemplate;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 40999
@interface PGSShowScreen : PGPrivilegedSerializable{
    int mScreenType;
    PGStringEx* mAlertMessageToShow;
    int mAlertMessageType;
    PGStringEx* mTitleMessage;
    BOOL mIsMandatory;
    PGStringEx* mFailureMessage;
    PGStringEx* mCancelMessage;
};
@property (nonatomic) int screenType;
@property (nonatomic,retain)PGStringEx* alertMessageToShow;
@property (nonatomic) int alertMessageType;
@property (nonatomic,retain)PGStringEx* titleMessage;
@property (nonatomic) BOOL isMandatory;
@property (nonatomic,retain)PGStringEx* failureMessage;
@property (nonatomic,retain)PGStringEx* cancelMessage;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41000
@interface PGSPopUpInfo : PGPrivilegedSerializable{
    int mInfoType;
    PGStringEx* mPopUpMsg;
    int mInterval;
};
@property (nonatomic) int infoType;
@property (nonatomic,retain)PGStringEx* popUpMsg;
@property (nonatomic) int interval;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41001
@interface PGSPromptLogin : PGPrivilegedSerializable{
    PGStringEx* mAlertMessageToShow;
};
@property (nonatomic,retain)PGStringEx* alertMessageToShow;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41002
@interface PGSOldUpgradeInfo : PGPrivilegedSerializable{
    int mUpgradeType;
    NSString* mUpgradeURL;
    PGStringEx* mUpgradeMsg;
    int mMinorBuildNumber;
};
@property (nonatomic) int upgradeType;
@property (nonatomic,retain)NSString* upgradeURL;
@property (nonatomic,retain)PGStringEx* upgradeMsg;
@property (nonatomic) int minorBuildNumber;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41003
@interface PGSPromptScreenName : PGPrivilegedSerializable{
    int mRequestId;
    NSString* mSuggestedScreenName;
    PGStringEx* mDesc;
};
@property (nonatomic) int requestId;
@property (nonatomic,retain)NSString* suggestedScreenName;
@property (nonatomic,retain)PGStringEx* desc;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41005
@interface PGSDownloadAndExecute : PGPrivilegedSerializable{
    BOOL mSilent;
    NSString* mUrl;
    PGStringEx* mContext;
};
@property (nonatomic) BOOL silent;
@property (nonatomic,retain)NSString* url;
@property (nonatomic,retain)PGStringEx* context;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41006
@interface PGSUpgradeInfo : PGPrivilegedSerializable{
    int mUpgradeType;
    NSMutableArray* mUpgradeURL;
    PGStringEx* mUpgradeMsg;
    int mMinorBuildNumber;
};
@property (nonatomic) int upgradeType;
@property (nonatomic,retain)NSMutableArray* upgradeURL;
@property (nonatomic,retain)PGStringEx* upgradeMsg;
@property (nonatomic) int minorBuildNumber;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41007
@interface PGSUserAvatarInfo : PGSerializable{
    int mAvatarId;
    BOOL mIsCustomEnabled;
    NSString* mAvatarMD5Sum;
    long long mFirstUploadedInCycle;
    int mUploadsRemaining;
    NSMutableArray* mAvatarDetails;
};
@property (nonatomic) int avatarId;
@property (nonatomic) BOOL isCustomEnabled;
@property (nonatomic,retain)NSString* avatarMD5Sum;
@property (nonatomic) long long firstUploadedInCycle;
@property (nonatomic) int uploadsRemaining;
@property (nonatomic,retain)NSMutableArray* avatarDetails;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41008
@interface PGSUserProfile : PGSerializable{
    NSString* mLoginId;
    NSString* mAccountName;
    NSString* mScreenName;
    int mWebMasterId;
    NSString* mReferer;
    NSString* mMailId;
    NSString* mFirstName;
    NSString* mLastName;
    NSString* mSex;
    NSString* mMailingAddress;
    NSString* mBonusCode;
    BOOL mIsValidated;
    NSString* mFrontendId;
    NSString* mCity;
    BOOL mCanShowPersonalInfo;
    PGSUserPersonalInfo* mUserInfo;
    NSString* mHearFrom;
    BOOL mShowCity;
    NSData* mEncProfile;
    NSString* mChannelId;
    NSString* mSessionLanguageId;
    NSString* mAccountLanguageId;
    NSString* mAccountCurrencyCode;
    NSString* mLocale;
    NSString* mBrandId;
    BOOL mIsPMCEnabled;
    uint8_t mAccountStatus;
    BOOL mIsPointsEnabled;
    NSString* mPartyPointsCategory;
    PGSUserAvatarInfo* mAvatarInfo;
    NSString* mUserTimeZoneId;
    NSString* mVipStatus;
    BOOL mSuspiciousLocationLoginStatus;
    NSString* mDocumentValidationStatus;
    int mDaysPassedAfterRealAccountCreation;
    NSString* mInvID;
    NSString* mPromoID;
    NSString* mPlayerJurisdiction;
    NSString* mKycStatus;
};
@property (nonatomic,retain)NSString* loginId;
@property (nonatomic,retain)NSString* accountName;
@property (nonatomic,retain)NSString* screenName;
@property (nonatomic) int webMasterId;
@property (nonatomic,retain)NSString* referer;
@property (nonatomic,retain)NSString* mailId;
@property (nonatomic,retain)NSString* firstName;
@property (nonatomic,retain)NSString* lastName;
@property (nonatomic,retain)NSString* sex;
@property (nonatomic,retain)NSString* mailingAddress;
@property (nonatomic,retain)NSString* bonusCode;
@property (nonatomic) BOOL IsValidated;
@property (nonatomic,retain)NSString* frontendId;
@property (nonatomic,retain)NSString* city;
@property (nonatomic) BOOL canShowPersonalInfo;
@property (nonatomic,retain)PGSUserPersonalInfo* userInfo;
@property (nonatomic,retain)NSString* hearFrom;
@property (nonatomic) BOOL showCity;
@property (nonatomic,retain)NSData* encProfile;
@property (nonatomic,retain)NSString* channelId;
@property (nonatomic,retain)NSString* sessionLanguageId;
@property (nonatomic,retain)NSString* accountLanguageId;
@property (nonatomic,retain)NSString* accountCurrencyCode;
@property (nonatomic,retain)NSString* locale;
@property (nonatomic,retain)NSString* brandId;
@property (nonatomic) BOOL isPMCEnabled;
@property (nonatomic) uint8_t accountStatus;
@property (nonatomic) BOOL isPointsEnabled;
@property (nonatomic,retain)NSString* partyPointsCategory;
@property (nonatomic,retain)PGSUserAvatarInfo* avatarInfo;
@property (nonatomic,retain)NSString* userTimeZoneId;
@property (nonatomic,retain)NSString* vipStatus;
@property (nonatomic) BOOL suspiciousLocationLoginStatus;
@property (nonatomic,retain)NSString* documentValidationStatus;
@property (nonatomic) int daysPassedAfterRealAccountCreation;
@property (nonatomic,retain)NSString* invID;
@property (nonatomic,retain)NSString* promoID;
@property (nonatomic,retain)NSString* playerJurisdiction;
@property (nonatomic,retain)NSString* kycStatus;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41009
@interface PGSLoginResponse : PGPrivilegedSerializable{
    int mResponseId;
    PGSUserProfile* mUserProfile;
    BOOL mIsRealMoneyAccountActivated;
    PGStringEx* mDesc;
    NSString* mKeyM1;
    NSString* mAccountName;
    uint8_t mFailedLoginAttemptCount;
    BOOL mShowCaptcha;
    long long mConversationId;
    NSString* mScreenName;
};
@property (nonatomic) int responseId;
@property (nonatomic,retain)PGSUserProfile* userProfile;
@property (nonatomic) BOOL isRealMoneyAccountActivated;
@property (nonatomic,retain)PGStringEx* desc;
@property (nonatomic,retain)NSString* keyM1;
@property (nonatomic,retain)NSString* accountName;
@property (nonatomic) uint8_t failedLoginAttemptCount;
@property (nonatomic) BOOL showCaptcha;
@property (nonatomic) long long conversationId;
@property (nonatomic,retain)NSString* screenName;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41010
@interface PGSRegistration : PGPrivilegedSerializable{
    PGSUserProfile* mProfile;
    NSString* mPassword;
    BOOL mIsEmailOptin;
    BOOL mIsFirstRequest;
};
@property (nonatomic,retain)PGSUserProfile* profile;
@property (nonatomic,retain)NSString* password;
@property (nonatomic) BOOL isEmailOptin;
@property (nonatomic) BOOL isFirstRequest;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41011
@interface PGSSendProfile : PGPrivilegedSerializable{
    int mResponseId;
    PGSUserProfile* mUserProfile;
};
@property (nonatomic) int responseId;
@property (nonatomic,retain)PGSUserProfile* userProfile;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41012
@interface PGSUserInfo : PGPrivilegedSerializable{
    PGSUserProfile* mProfile;
    int mOpcode;
};
@property (nonatomic,retain)PGSUserProfile* profile;
@property (nonatomic) int opcode;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41013
@interface PGSGetPAMArticleContentFiles : PGPrivilegedSerializable{
    NSMutableDictionary* mArticleLanguageIds;
    BOOL mIsPersonal;
};
@property (nonatomic,retain)NSMutableDictionary* articleLanguageIds;
@property (nonatomic) BOOL isPersonal;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41014
@interface PGSSaveFile : PGPrivilegedSerializable{
    NSData* mFileContent;
    NSString* mFileName;
    NSString* mLocation;
    NSString* mLanguageId;
};
@property (nonatomic,retain)NSData* fileContent;
@property (nonatomic,retain)NSString* fileName;
@property (nonatomic,retain)NSString* location;
@property (nonatomic,retain)NSString* languageId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41015
@interface PGSLanguagePackUpdate : PGPrivilegedSerializable{
    NSMutableArray* mUpgradeURL;
};
@property (nonatomic,retain)NSMutableArray* upgradeURL;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41016
@interface PGSDynamicLanguagePackUpdate : PGPrivilegedSerializable{
    NSMutableDictionary* mLiteralsMap;
};
@property (nonatomic,retain)NSMutableDictionary* literalsMap;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41017
@interface PGSClientMD5Sum : PGPrivilegedSerializable{
    int mSumType;
    NSMutableArray* mCheckSumList;
};
@property (nonatomic) int sumType;
@property (nonatomic,retain)NSMutableArray* checkSumList;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41018
@interface PGSCurrencyDetailsRequest : PGPrivilegedSerializable{
    NSMutableArray* mCurrencyCodes;
};
@property (nonatomic,retain)NSMutableArray* currencyCodes;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41019
@interface PGSFXRateRequest : PGPrivilegedSerializable{
    NSString* mFromCurrencyCode;
    NSString* mToCurrencyCode;
    long long mSnapshotId;
    NSString* mMarkupType;
};
@property (nonatomic,retain)NSString* fromCurrencyCode;
@property (nonatomic,retain)NSString* toCurrencyCode;
@property (nonatomic) long long snapshotId;
@property (nonatomic,retain)NSString* markupType;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41020
@interface PGSCurrencyDetailsList : PGPrivilegedSerializable{
    NSMutableArray* mCurrencies;
};
@property (nonatomic,retain)NSMutableArray* currencies;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41021
@interface PGSFXRateDetails : PGPrivilegedSerializable{
    long long mSnapshotId;
    NSString* mMarkupType;
    NSString* mFromCurrencyCode;
    NSString* mToCurrencyCode;
    long long mConversionFactor4Client;
    long long mReverseConversionFactor4Client;
};
@property (nonatomic) long long snapshotId;
@property (nonatomic,retain)NSString* markupType;
@property (nonatomic,retain)NSString* fromCurrencyCode;
@property (nonatomic,retain)NSString* toCurrencyCode;
@property (nonatomic) long long conversionFactor4Client;
@property (nonatomic) long long reverseConversionFactor4Client;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41022
@interface PGSFXRateSnapshot : PGPrivilegedSerializable{
    long long mSnapshotId;
    NSMutableArray* mFxRates;
};
@property (nonatomic) long long snapshotId;
@property (nonatomic,retain)NSMutableArray* fxRates;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41023
@interface PGSCurrencyDetails : PGSerializable{
    NSString* mCode;
    NSString* mSymbol;
    NSString* mName;
    int mDefaultFractionDigits;
};
@property (nonatomic,retain)NSString* code;
@property (nonatomic,retain)NSString* symbol;
@property (nonatomic,retain)NSString* name;
@property (nonatomic) int defaultFractionDigits;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41024
@interface PGSFXConversionFactor : PGSerializable{
    NSString* mMarkupType;
    long long mConversionFactor4Client;
    long long mReverseConversionFactor4Client;
};
@property (nonatomic,retain)NSString* markupType;
@property (nonatomic) long long conversionFactor4Client;
@property (nonatomic) long long reverseConversionFactor4Client;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41025
@interface PGSFXRateData : PGSerializable{
    NSString* mFromCurrencyCode;
    NSString* mToCurrencyCode;
    NSMutableArray* mFactors;
};
@property (nonatomic,retain)NSString* fromCurrencyCode;
@property (nonatomic,retain)NSString* toCurrencyCode;
@property (nonatomic,retain)NSMutableArray* factors;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41026
@interface PGSCurrencyAmount : PGSerializable{
    NSString* mCurrencyCode;
    long long mAmount;
};
@property (nonatomic,retain)NSString* currencyCode;
@property (nonatomic) long long amount;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41027
@interface PGSCulturalFormat : PGPrivilegedSerializable{
    NSString* mLocale;
    NSString* mNumberFormat;
    NSString* mCurrencyFormatSymbol;
    NSString* mCurrencyFormatCode;
    NSString* mCurrencyFormatName;
    NSString* mCurrencyFormatSymbolCode;
    NSString* mCurrencyFormatSymbolName;
    NSString* mCurrencyFormatCodeName;
    NSString* mDateFormatLong;
    NSString* mDateFormatShort;
    BOOL mTime24Hours;
    BOOL mDefaultFormat;
};
@property (nonatomic,retain)NSString* locale;
@property (nonatomic,retain)NSString* numberFormat;
@property (nonatomic,retain)NSString* currencyFormatSymbol;
@property (nonatomic,retain)NSString* currencyFormatCode;
@property (nonatomic,retain)NSString* currencyFormatName;
@property (nonatomic,retain)NSString* currencyFormatSymbolCode;
@property (nonatomic,retain)NSString* currencyFormatSymbolName;
@property (nonatomic,retain)NSString* currencyFormatCodeName;
@property (nonatomic,retain)NSString* dateFormatLong;
@property (nonatomic,retain)NSString* dateFormatShort;
@property (nonatomic) BOOL time24Hours;
@property (nonatomic) BOOL defaultFormat;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41028
@interface PGSCurrencyRollback : PGPrivilegedSerializable{
    uint8_t mCause;
    long long mAccountBalance;
    NSMutableArray* mCurrencyList;
    NSString* mFallbackCurrency;
};
@property (nonatomic) uint8_t cause;
@property (nonatomic) long long accountBalance;
@property (nonatomic,retain)NSMutableArray* currencyList;
@property (nonatomic,retain)NSString* fallbackCurrency;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41029
@interface PGSAccountCurrencyChange : PGPrivilegedSerializable{
    NSString* mCurrentCurrencyCode;
    NSString* mNewCurrencyCode;
    uint8_t mType;
};
@property (nonatomic,retain)NSString* currentCurrencyCode;
@property (nonatomic,retain)NSString* newCurrencyCode;
@property (nonatomic) uint8_t type;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41030
@interface PGSPreliminaryAccountCurrency : PGPrivilegedSerializable{
    NSString* mCurrencyCode;
};
@property (nonatomic,retain)NSString* currencyCode;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41031
@interface PGSAdConfigurationMessage : PGPrivilegedSerializable{
    NSData* mRealPlacements;
    NSData* mPlayPlacements;
};
@property (nonatomic,retain)NSData* realPlacements;
@property (nonatomic,retain)NSData* playPlacements;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41032
@interface PGSSearchConfigurationMessage : PGPrivilegedSerializable{
    BOOL mSearchBarRequired;
    BOOL mSearchApplicationRequired;
};
@property (nonatomic) BOOL searchBarRequired;
@property (nonatomic) BOOL searchApplicationRequired;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41033
@interface PGSAccountTemplateParam : PGPrivilegedSerializable{
    NSMutableDictionary* mParams;
};
@property (nonatomic,retain)NSMutableDictionary* params;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41034
@interface PGSAcceptPseudoOffer : PGPrivilegedSerializable{
    int mEventId;
};
@property (nonatomic) int eventId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41035
@interface PGSAlertBotDetectionFailure : PGPrivilegedSerializable{
    int mBotAlertType;
    int mErrorCode;
    NSString* mReasonsForFailure;
    NSString* mDllName;
    NSString* mMd5OfExistingDLL;
};
@property (nonatomic) int botAlertType;
@property (nonatomic) int errorCode;
@property (nonatomic,retain)NSString* reasonsForFailure;
@property (nonatomic,retain)NSString* dllName;
@property (nonatomic,retain)NSString* md5OfExistingDLL;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41036
@interface PGSPlayAllowedDays : PGPrivilegedSerializable{
    long long mOptionalDaysLeft;
    long long mMadatoryDaysLeft;
    BOOL mIsMandatory;
};
@property (nonatomic) long long optionalDaysLeft;
@property (nonatomic) long long madatoryDaysLeft;
@property (nonatomic) BOOL isMandatory;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41039
@interface PGSSocialNetworkRequest : PGPrivilegedSerializable{
    int mTypeId;
    NSMutableArray* mUsers;
};
@property (nonatomic) int typeId;
@property (nonatomic,retain)NSMutableArray* users;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41040
@interface PGSSocialNetworkUserDetails : PGSerializable{
    NSString* mAccountName;
    NSString* mScreenName;
    long long mChipsAmount;
    int mLeaderboardRank;
};
@property (nonatomic,retain)NSString* accountName;
@property (nonatomic,retain)NSString* screenName;
@property (nonatomic) long long chipsAmount;
@property (nonatomic) int leaderboardRank;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41041
@interface PGSLeaderboardDetails : PGPrivilegedSerializable{
    int mTypeId;
    NSMutableArray* mLeaders;
};
@property (nonatomic) int typeId;
@property (nonatomic,retain)NSMutableArray* leaders;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41042
@interface PGSEDSResponseMessage : PGPrivilegedSerializable{
    int mEventDataId;
    int mAcceptanceStatus;
    NSString* mTransactionReferenceId;
};
@property (nonatomic) int eventDataId;
@property (nonatomic) int acceptanceStatus;
@property (nonatomic,retain)NSString* transactionReferenceId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41043
@interface PGSEDSRequestMessage : PGPrivilegedSerializable{
    NSString* mTemplate;
    NSMutableDictionary* mTemplateParams;
    NSString* mOfferType;
    int mResponseRequired;
    int mEventDataId;
    int mPopupType;
    int mOnRejectGoToPA;
};
@property (nonatomic,retain)NSString* template;
@property (nonatomic,retain)NSMutableDictionary* templateParams;
@property (nonatomic,retain)NSString* offerType;
@property (nonatomic) int responseRequired;
@property (nonatomic) int eventDataId;
@property (nonatomic) int popupType;
@property (nonatomic) int onRejectGoToPA;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41044
@interface PGSCompetitorInfo : PGPrivilegedSerializable{
    NSString* mApplicationName;
    NSString* mInstallationDate;
    NSString* mLastModificationDate;
    NSString* mLastAccessDate;
    NSString* mAppVersion;
};
@property (nonatomic,retain)NSString* applicationName;
@property (nonatomic,retain)NSString* installationDate;
@property (nonatomic,retain)NSString* lastModificationDate;
@property (nonatomic,retain)NSString* lastAccessDate;
@property (nonatomic,retain)NSString* appVersion;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41045
@interface PGSCompetitorsInfoList : PGPrivilegedSerializable{
    NSMutableArray* mInfoList;
};
@property (nonatomic,retain)NSMutableArray* infoList;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41046
@interface PGSChangeAvatar : PGPrivilegedSerializable{
    int mAvatarId;
    BOOL mIsCustomAvatar;
};
@property (nonatomic) int avatarId;
@property (nonatomic) BOOL isCustomAvatar;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41047
@interface PGSTimeZoneDetails : PGPrivilegedSerializable{
    BOOL mMsgSTZ;
    int mRowOffset;
    BOOL mUseDSTime;
    int mStartMonth;
    int mStartDay;
    int mStartDayOfWeek;
    int mStartTime;
    NSString* mWindowsTZid;
    NSString* mMetaZoneID;
    int mStartMode;
    int mEndMonth;
    int mEndDay;
    int mEndDayOfWeek;
    int mEndTime;
    int mEndMode;
    int mDstSavings;
    long long mStandardShortDisplayName;
    long long mDaylightShortDisplayName;
    long long mStandardLongDisplayName;
    long long mDaylightLongDisplayName;
};
@property (nonatomic) BOOL msgSTZ;
@property (nonatomic) int rowOffset;
@property (nonatomic) BOOL useDSTime;
@property (nonatomic) int startMonth;
@property (nonatomic) int startDay;
@property (nonatomic) int startDayOfWeek;
@property (nonatomic) int startTime;
@property (nonatomic,retain)NSString* windowsTZid;
@property (nonatomic,retain)NSString* metaZoneID;
@property (nonatomic) int startMode;
@property (nonatomic) int endMonth;
@property (nonatomic) int endDay;
@property (nonatomic) int endDayOfWeek;
@property (nonatomic) int endTime;
@property (nonatomic) int endMode;
@property (nonatomic) int dstSavings;
@property (nonatomic) long long standardShortDisplayName;
@property (nonatomic) long long daylightShortDisplayName;
@property (nonatomic) long long standardLongDisplayName;
@property (nonatomic) long long daylightLongDisplayName;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41048
@interface PGSChangeTimeZone : PGPrivilegedSerializable{
    NSString* mNewTimeZone;
};
@property (nonatomic,retain)NSString* newTimeZone;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41049
@interface PGSEDSMTRequestMessage : PGPrivilegedSerializable{
    NSString* mTemplate;
    NSMutableDictionary* mTemplateParams;
    int mEventDataId;
    NSMutableArray* mTableIds;
};
@property (nonatomic,retain)NSString* template;
@property (nonatomic,retain)NSMutableDictionary* templateParams;
@property (nonatomic) int eventDataId;
@property (nonatomic,retain)NSMutableArray* tableIds;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41050
@interface PGSSuspiciousLocationQuestions : PGPrivilegedSerializable{
    int mResponseId;
    uint8_t mNoOfAttempts;
};
@property (nonatomic) int responseId;
@property (nonatomic) uint8_t noOfAttempts;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41051
@interface PGSSuspiciousLocationAnswers : PGPrivilegedSerializable{
    NSMutableDictionary* mSuspiciuosQnAnsMap;
    BOOL mSuspiciousLocationLoginStatus;
};
@property (nonatomic,retain)NSMutableDictionary* suspiciuosQnAnsMap;
@property (nonatomic) BOOL suspiciousLocationLoginStatus;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41052
@interface PGSChangeBounceEmail : PGPrivilegedSerializable{
    NSString* mNewEmail;
};
@property (nonatomic,retain)NSString* newEmail;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41053
@interface PGSThirdPartyHandShake : PGPrivilegedSerializable{
    NSString* mThirdParty;
    NSString* mInvokerProduct;
    NSMutableDictionary* mExtendedAttributes;
};
@property (nonatomic,retain)NSString* thirdParty;
@property (nonatomic,retain)NSString* invokerProduct;
@property (nonatomic,retain)NSMutableDictionary* extendedAttributes;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41054
@interface PGSThirdPartyHandShakeResponse : PGPrivilegedSerializable{
    NSString* mResponseURL;
    int mErrorCode;
    NSString* mGameType;
};
@property (nonatomic,retain)NSString* responseURL;
@property (nonatomic) int errorCode;
@property (nonatomic,retain)NSString* gameType;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41055
@interface PGSDocumentStatusMessage : PGPrivilegedSerializable{
    int mVerificationStatus;
};
@property (nonatomic) int verificationStatus;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41056
@interface PGSAccountNameCheck : PGPrivilegedSerializable{
    NSString* mAccountName;
    NSString* mFrontEndId;
};
@property (nonatomic,retain)NSString* accountName;
@property (nonatomic,retain)NSString* frontEndId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41057
@interface PGSAccountNameCheckResponse : PGPrivilegedSerializable{
    BOOL mIsAccountAvailable;
    PGStringEx* mSugestedIds;
    NSString* mAccountName;
};
@property (nonatomic) BOOL isAccountAvailable;
@property (nonatomic,retain)PGStringEx* sugestedIds;
@property (nonatomic,retain)NSString* accountName;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41058
@interface PGSTokenVerificationRequest : PGPrivilegedSerializable{
    NSString* mLoginId;
    int mTokenCode;
};
@property (nonatomic,retain)NSString* loginId;
@property (nonatomic) int tokenCode;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41059
@interface PGSSecurityTokenOTPRequest : PGPrivilegedSerializable{
    NSString* mLoginId;
};
@property (nonatomic,retain)NSString* loginId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41060
@interface PGSOTPResponse : PGPrivilegedSerializable{
    int mResponseId;
    int mLastDigitsOfMobile;
};
@property (nonatomic) int responseId;
@property (nonatomic) int lastDigitsOfMobile;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41061
@interface PGSPopUpInfoExMap : PGPrivilegedSerializable{
    int mInfoType;
    NSString* mPopUpMsg;
    int mInterval;
    int mAppearance;
    int mContentType;
    int mIcon;
    int mButtons;
    NSMutableDictionary* mPopupTemplate;
};
@property (nonatomic) int infoType;
@property (nonatomic,retain)NSString* popUpMsg;
@property (nonatomic) int interval;
@property (nonatomic) int appearance;
@property (nonatomic) int contentType;
@property (nonatomic) int icon;
@property (nonatomic) int buttons;
@property (nonatomic,retain)NSMutableDictionary* popupTemplate;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41062
@interface PGSQDStatusRequester : PGPrivilegedSerializable{
    long long mGameTableId;
};
@property (nonatomic) long long gameTableId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41064
@interface PGSStringMapResponse : PGPrivilegedSerializable{
    NSString* mMsgType;
    NSMutableDictionary* mAttributeMap;
};
@property (nonatomic,retain)NSString* msgType;
@property (nonatomic,retain)NSMutableDictionary* attributeMap;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41065
@interface PGSPAMArticle : PGSerializable{
    int mArticleID;
    uint8_t mPriority;
    int mArticleCategory;
    BOOL mIsPersonal;
    BOOL mIsCBTArticle;
    long long mStartTime;
    long long mEndTime;
    NSString* mLanguageId;
    BOOL mIsBaseHtml;
    BOOL mToBeShown;
};
@property (nonatomic) int articleID;
@property (nonatomic) uint8_t priority;
@property (nonatomic) int articleCategory;
@property (nonatomic) BOOL isPersonal;
@property (nonatomic) BOOL isCBTArticle;
@property (nonatomic) long long startTime;
@property (nonatomic) long long endTime;
@property (nonatomic,retain)NSString* languageId;
@property (nonatomic) BOOL isBaseHtml;
@property (nonatomic) BOOL toBeShown;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41066
@interface PGSPAMArticleList : PGPrivilegedSerializable{
    NSMutableArray* mAttributeList;
};
@property (nonatomic,retain)NSMutableArray* attributeList;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41067
@interface PGSResponseFraudUserKickout : PGPrivilegedSerializable{
    long long mConversationId;
    NSString* mAccountName;
    NSString* mScreenName;
};
@property (nonatomic) long long conversationId;
@property (nonatomic,retain)NSString* accountName;
@property (nonatomic,retain)NSString* screenName;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41068
@interface PGSResponseRegisterInvalidMailId : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41070
@interface PGSRequestCompetitorsInfo : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41071
@interface PGSRequestGameserverGoingDown : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41072
@interface PGSRequestMigrationKeepOldCurrency : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41073
@interface PGSRequestMyAccountPanelFull : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41074
@interface PGSRequestMyAccountPanelHalf : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41076
@interface PGSRequestTerminateLoggedOnOtherMachine : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41079
@interface PGSResponseChangeBounceDupEmailFail : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41080
@interface PGSResponseChangeBounceEmailDBError : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41081
@interface PGSResponseChangeBounceEmailFail : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41082
@interface PGSResponseChangeBounceEmailSuccess : PGPrivilegedSerializable{
    PGStringEx* mMsg;
};
@property (nonatomic,retain)PGStringEx* msg;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41083
@interface PGSResponseChangeEMailDBError : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41084
@interface PGSResponseChangeEMailFail : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41085
@interface PGSResponseChangeEmailSuccess : PGPrivilegedSerializable{
    PGStringEx* mMsg;
    long long mConversationId;
};
@property (nonatomic,retain)PGStringEx* msg;
@property (nonatomic) long long conversationId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41086
@interface PGSResponseChangePasswordDBError : PGPrivilegedSerializable{
    PGStringEx* mMsg;
};
@property (nonatomic,retain)PGStringEx* msg;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41087
@interface PGSResponseChangePasswordFailed : PGPrivilegedSerializable{
    PGStringEx* mMsg;
};
@property (nonatomic,retain)PGStringEx* msg;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41088
@interface PGSResponseChangePasswordSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41089
@interface PGSResponseConvertedToReal : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41090
@interface PGSResponseError : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41092
@interface PGSResponseForgotPasswordFailed : PGPrivilegedSerializable{
    PGStringEx* mMsg;
};
@property (nonatomic,retain)PGStringEx* msg;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41093
@interface PGSResponseForgotPasswordSuccess : PGPrivilegedSerializable{
    PGStringEx* mMsg;
};
@property (nonatomic,retain)PGStringEx* msg;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41094
@interface PGSResponseIPFromUs : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41095
@interface PGSResponseKeepOldAcctccySuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41096
@interface PGSResponseQDAvailable : PGPrivilegedSerializable{
    long long mGameTableId;
};
@property (nonatomic) long long gameTableId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41097
@interface PGSResponseQDNotAvailable : PGPrivilegedSerializable{
    long long mGameTableId;
};
@property (nonatomic) long long gameTableId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41098
@interface PGSResponseRegistrationFailed : PGPrivilegedSerializable{
    PGStringEx* mMsg;
};
@property (nonatomic,retain)PGStringEx* msg;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41099
@interface PGSResponseRegistrationNotAllowedChars : PGPrivilegedSerializable{
    PGStringEx* mDesc;
};
@property (nonatomic,retain)PGStringEx* desc;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41100
@interface PGSResponseRegistrationOffendedId : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41101
@interface PGSResponseRegistrationSuccess : PGPrivilegedSerializable{
    PGStringEx* mDesc;
};
@property (nonatomic,retain)PGStringEx* desc;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41102
@interface PGSResponseShowRedesignMigration : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41103
@interface PGSResponseSubscribeFailed : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41104
@interface PGSResponseSubscribeNotAllowed : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41105
@interface PGSResponseSubscribeSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41106
@interface PGSResponseTellaFriendSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41107
@interface PGSResponseTellaFriendDBError : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41108
@interface PGSResponseTellaFriendFailed : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41109
@interface PGSResponseTellaFriendNotLoggedIn : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41110
@interface PGSResponseUnsubscribeFailed : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41111
@interface PGSResponseUnsubscribeSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41112
@interface PGSResponseUserAcctCCYNotMatching : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41113
@interface PGSResponseValidateCodeFail : PGPrivilegedSerializable{
    PGStringEx* mMsg;
};
@property (nonatomic,retain)PGStringEx* msg;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41114
@interface PGSResponseValidateCodeSuccess : PGPrivilegedSerializable{
    PGStringEx* mMsg;
};
@property (nonatomic,retain)PGStringEx* msg;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41115
@interface PGSResponseValidationCodeSendFailed : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41116
@interface PGSResponseValidationCodeSendSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41117
@interface PGSRequestRealAccountDetails : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41118
@interface PGSRequestJackpotPanel : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41119
@interface PGSRequestSendValidationCode : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41122
@interface PGSRequestBounceEmailDontRemind : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41123
@interface PGSRequestBounceEmailRemindLater : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41124
@interface PGSRequestSendRegistryValues : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41125
@interface PGSRequestSendSystemConfig : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41128
@interface PGSRequestPlayAccountDetails : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41129
@interface PGSResponseRegistrationIDNotAvailable : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41130
@interface PGSResponseRegistrationDuplicateMailId : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41131
@interface PGSResponseRegistrationMultiBrandChkFailed : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41132
@interface PGSResponseReloginInvalidSessionKey : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41133
@interface PGSResponseReloginDBError : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41134
@interface PGSResponseReloginServerOverloaded : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41135
@interface PGSResponseRevisitServerOverLoaded : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41136
@interface PGSResponseInvalidBonusCode : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41137
@interface PGSResponseRevisitSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41138
@interface PGSResponseReloginSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41139
@interface PGSRequestAllinsRemaining : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41140
@interface PGSRequestAllinsReset : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41141
@interface PGSRequestEmailCashierHistory : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41142
@interface PGSRequestDoNotShowCity : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41144
@interface PGSRequestJackpotPromoMonsterPanel : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41145
@interface PGSResponseUpdateProfileSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41146
@interface PGSResponseUpdateProfileDBError : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41147
@interface PGSResponseRealTransactionSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41148
@interface PGSResponseRealTransactionsNotLoggedIn : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41149
@interface PGSResponseRealTransactionsNotRealuser : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41150
@interface PGSResponseloginFailDummyServer : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41151
@interface PGSResponsepersonalInfoSaveSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41152
@interface PGSResponsePersonalInfoSaveFailure : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41153
@interface PGSResponseWordVerifyFailure : PGPrivilegedSerializable{
    PGStringEx* mDesc;
};
@property (nonatomic,retain)PGStringEx* desc;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41154
@interface PGSResponseAcctCCYMigrationSuccess : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41155
@interface PGSRequestShowCity : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41156
@interface PGSResponseUpdateProfileFailed : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41157
@interface PGSLastLoginTime : PGPrivilegedSerializable{
    long long mLastLoginTime;
};
@property (nonatomic) long long lastLoginTime;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41158
@interface PGSBalanceInfo : PGPrivilegedSerializable{
    long long mBalance;
    BOOL mFormatRequired;
    long long mInPlayBalance;
    long long mNetBalance;
};
@property (nonatomic) long long balance;
@property (nonatomic) BOOL formatRequired;
@property (nonatomic) long long inPlayBalance;
@property (nonatomic) long long netBalance;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41159
@interface PGSLoyaltyInfo : PGPrivilegedSerializable{
    BOOL mIsPointsEnabled;
    NSString* mVipStatus;
    int mPartyPoints;
};
@property (nonatomic) BOOL isPointsEnabled;
@property (nonatomic,retain)NSString* vipStatus;
@property (nonatomic) int partyPoints;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41160
@interface PGSPartyInboxInfo : PGPrivilegedSerializable{
    BOOL mIsPmcEnabled;
    int mMailCount;
};
@property (nonatomic) BOOL isPmcEnabled;
@property (nonatomic) int mailCount;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41161
@interface PGSBonusInfo : PGPrivilegedSerializable{
    NSString* mBonusOfferUrl;
    NSString* mBonusOffer1;
    NSString* mBonusOffer2;
    NSString* mBonusOffer3;
    NSString* mBonusOffer4;
    NSString* mAbCurrBonus;
    NSString* mAbTotalBonus;
    NSString* mCapBonusPercent;
    NSString* mCapMaxBonus;
    NSString* mCapAccCurrType;
};
@property (nonatomic,retain)NSString* bonusOfferUrl;
@property (nonatomic,retain)NSString* bonusOffer1;
@property (nonatomic,retain)NSString* bonusOffer2;
@property (nonatomic,retain)NSString* bonusOffer3;
@property (nonatomic,retain)NSString* bonusOffer4;
@property (nonatomic,retain)NSString* abCurrBonus;
@property (nonatomic,retain)NSString* abTotalBonus;
@property (nonatomic,retain)NSString* capBonusPercent;
@property (nonatomic,retain)NSString* capMaxBonus;
@property (nonatomic,retain)NSString* capAccCurrType;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41162
@interface PGSFundInPageAcknowledgement : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41163
@interface PGSSessionSummary : PGPrivilegedSerializable{
    long long mConversationId;
    NSMutableArray* mEvents;
};
@property (nonatomic) long long conversationId;
@property (nonatomic,retain)NSMutableArray* events;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41164
@interface PGSSessionSummaryAcknowledgment : PGPrivilegedSerializable{
    long long mConversationId;
    NSMutableArray* mEventIds;
};
@property (nonatomic) long long conversationId;
@property (nonatomic,retain)NSMutableArray* eventIds;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41165
@interface PGSLoginDenial : PGPrivilegedSerializable{
    long long mConversationId;
    NSString* mAccountName;
    NSString* mScreenName;
    PGStringEx* mDescription;
};
@property (nonatomic) long long conversationId;
@property (nonatomic,retain)NSString* accountName;
@property (nonatomic,retain)NSString* screenName;
@property (nonatomic,retain)PGStringEx* description;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41166
@interface PGSDOBCheckRequired : PGPrivilegedSerializable{
    uint8_t mReasonCode;
};
@property (nonatomic) uint8_t reasonCode;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41167
@interface PGSDOBDetails : PGPrivilegedSerializable{
    uint8_t mDay;
    uint8_t mMonth;
    short mYear;
};
@property (nonatomic) uint8_t day;
@property (nonatomic) uint8_t month;
@property (nonatomic) short year;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41168
@interface PGSAsyncEventObject : PGSerializable{
    long long mEventId;
    NSString* mAccountName;
    int64_t mCreatedTime;
    NSString* mType;
    NSString* mFrontend;
    NSString* mBrand;
    NSString* mProduct;
    NSMutableArray* mParams;
    PGStringEx* mMessageDescription;
    NSString* mSource;
    NSData* mByteArray;
};
@property (nonatomic) long long eventId;
@property (nonatomic,retain)NSString* accountName;
@property (nonatomic) int64_t createdTime;
@property (nonatomic,retain)NSString* type;
@property (nonatomic,retain)NSString* frontend;
@property (nonatomic,retain)NSString* brand;
@property (nonatomic,retain)NSString* product;
@property (nonatomic,retain)NSMutableArray* params;
@property (nonatomic,retain)PGStringEx* messageDescription;
@property (nonatomic,retain)NSString* source;
@property (nonatomic,retain)NSData* byteArray;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41169
@interface PGSNotifyPlayerProfile : PGPrivilegedSerializable{
    NSString* mSessionKey;
    NSData* mEncryptedProfile;
};
@property (nonatomic,retain)NSString* sessionKey;
@property (nonatomic,retain)NSData* encryptedProfile;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41170
@interface PGSUpgradesServiceHealthStatus : PGPrivilegedSerializable{
    BOOL mConnectedSuccessfully;
    int mNumRetries;
    int mNumMillisToConnect;
    NSString* mErrorMessage;
};
@property (nonatomic) BOOL connectedSuccessfully;
@property (nonatomic) int numRetries;
@property (nonatomic) int numMillisToConnect;
@property (nonatomic,retain)NSString* errorMessage;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41171
@interface PGSAutoCashoutLimitRequest : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41172
@interface PGSAutoCashoutLimitResponse : PGPrivilegedSerializable{
    long long mAccountBalance;
    long long mAutoCashoutLimit;
    long long mAutoCashoutAmount;
    NSString* mCurrencyCode;
};
@property (nonatomic) long long accountBalance;
@property (nonatomic) long long autoCashoutLimit;
@property (nonatomic) long long autoCashoutAmount;
@property (nonatomic,retain)NSString* currencyCode;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41173
@interface PGSAutoCashoutRequest : PGPrivilegedSerializable{
    long long mAmount;
    NSString* mCurrency;
};
@property (nonatomic) long long amount;
@property (nonatomic,retain)NSString* currency;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41175
@interface PGSRequestDomainMapping : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41176
@interface PGSDomainMapping : PGPrivilegedSerializable{
    NSMutableDictionary* mDomainMap;
};
@property (nonatomic,retain)NSMutableDictionary* domainMap;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41177
@interface PGSDomainChangeAdvice : PGPrivilegedSerializable{
    NSString* mDomainName;
    int mValidityMode;
};
@property (nonatomic,retain)NSString* domainName;
@property (nonatomic) int validityMode;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41178
@interface PGSDirectConnectAdvice : PGPrivilegedSerializable{
    NSString* mDirectAddress;
};
@property (nonatomic,retain)NSString* directAddress;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41179
@interface PGSUCID : PGPrivilegedSerializable{
    NSString* mId;
};
@property (nonatomic,retain)NSString* identifier;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41180
@interface PGSRequestTermsAndConditionsAcceptance : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41181
@interface PGSResponseTermsAndConditionsAcceptance : PGPrivilegedSerializable{
    BOOL mTermsAndConditionsAccepted;
};
@property (nonatomic) BOOL termsAndConditionsAccepted;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41182
@interface PGSThirdPartyRegistrationFailed : PGPrivilegedSerializable{
    int mReasonCode;
};
@property (nonatomic) int reasonCode;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41183
@interface PGSLanguageMigration : PGPrivilegedSerializable{
    PGStringEx* mMessage;
    NSMutableDictionary* mSupportedLanguagesMap;
};
@property (nonatomic,retain)PGStringEx* message;
@property (nonatomic,retain)NSMutableDictionary* supportedLanguagesMap;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41184
@interface PGSDocumentDetailsSubmissionResponse : PGPrivilegedSerializable{
    BOOL mDocumentDetailsSubmitted;
};
@property (nonatomic) BOOL documentDetailsSubmitted;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41185
@interface PGSEDSNGRequestMessage : PGPrivilegedSerializable{
    NSString* mTemplate;
    NSMutableDictionary* mTemplateParams;
    long long mEventDataId;
    long long mTableId;
};
@property (nonatomic,retain)NSString* template;
@property (nonatomic,retain)NSMutableDictionary* templateParams;
@property (nonatomic) long long eventDataId;
@property (nonatomic) long long tableId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41186
@interface PGSEDSNGResponseMessage : PGPrivilegedSerializable{
    long long mEventDataId;
    int mAcceptanceStatus;
};
@property (nonatomic) long long eventDataId;
@property (nonatomic) int acceptanceStatus;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41187
@interface PGSLobbyMaximized : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41188
@interface PGSLobbyMinimized : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41189
@interface PGSShowMigrationScreen : PGPrivilegedSerializable{
    int mTablePeerId;
    uint8_t mMsgSource;
};
@property (nonatomic) int tablePeerId;
@property (nonatomic) uint8_t msgSource;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41190
@interface PGSDepositLimitsSubmissionResponse : PGPrivilegedSerializable{
    BOOL mDepositLimitsSubmitted;
};
@property (nonatomic) BOOL depositLimitsSubmitted;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41191
@interface PGSUserPersonalDetailsUpdatedResponse : PGPrivilegedSerializable{
    BOOL mUserPersonalDetailsUpdated;
};
@property (nonatomic) BOOL userPersonalDetailsUpdated;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41192
@interface PGSChangePasswordSuccessResponse : PGPrivilegedSerializable{
    BOOL mChangePasswordSuccess;
};
@property (nonatomic) BOOL changePasswordSuccess;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41193
@interface PGSEELoginDisplaySuccess : PGPrivilegedSerializable{
    int mEeLoginDisplaySuccess;
    int mTimeTaken;
    NSString* mBrandId;
    NSString* mProductId;
    NSString* mIp;
    NSString* mUcid;
    int mTimeTakenToLoadLobby;
};
@property (nonatomic) int eeLoginDisplaySuccess;
@property (nonatomic) int timeTaken;
@property (nonatomic,retain)NSString* brandId;
@property (nonatomic,retain)NSString* productId;
@property (nonatomic,retain)NSString* ip;
@property (nonatomic,retain)NSString* ucid;
@property (nonatomic) int timeTakenToLoadLobby;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41194
@interface PGSDocUploadStatus : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41195
@interface PGSGameCashInfo : PGPrivilegedSerializable{
    int mGameCash;
    NSString* mGameCashCurr;
};
@property (nonatomic) int gameCash;
@property (nonatomic,retain)NSString* gameCashCurr;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41196
@interface PGSIdleInfo : PGPrivilegedSerializable{
    int mUserIdleForSec;
    BOOL mIsActive;
};
@property (nonatomic) int userIdleForSec;
@property (nonatomic) BOOL isActive;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41197
@interface PGSRequestReconnectOnUserAction : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41198
@interface PGSAutoLoginRequest : PGPrivilegedSerializable{
    NSString* mSsoKey;
    NSString* mInvokerProductId;
    NSString* mInvokerSessionKey;
    NSString* mLoginId;
};
@property (nonatomic,retain)NSString* ssoKey;
@property (nonatomic,retain)NSString* invokerProductId;
@property (nonatomic,retain)NSString* invokerSessionKey;
@property (nonatomic,retain)NSString* loginId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41199
@interface PGSLoginRequest : PGPrivilegedSerializable{
    NSString* mSsoKey;
    NSString* mLoginId;
};
@property (nonatomic,retain)NSString* ssoKey;
@property (nonatomic,retain)NSString* loginId;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41200
@interface PGSLoginFailureResponse : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41201
@interface PGSLoginIncompleteLaunchURL : PGPrivilegedSerializable{
    int mErrorCode;
    NSString* mInterceptorName;
};
@property (nonatomic) int errorCode;
@property (nonatomic,retain)NSString* interceptorName;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41202
@interface PGSLoginServiceUnavailable : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41203
@interface PGSLoginSuccessResponse : PGPrivilegedSerializable{
    NSString* mSsoKey;
};
@property (nonatomic,retain)NSString* ssoKey;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41204
@interface PGSLoginSuccessUserProfile : PGPrivilegedSerializable{
    PGSUserProfile* mUserProfile;
};
@property (nonatomic,retain)PGSUserProfile* userProfile;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41205
@interface PGSSSOKeyMessage : PGPrivilegedSerializable{
    NSString* mEncodedSSOKey;
};
@property (nonatomic,retain)NSString* encodedSSOKey;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41206
@interface PGSClientResolutionDetails : PGPrivilegedSerializable{
    NSString* mBrandId;
    NSString* mProductId;
    NSString* mIp;
    NSString* mUcid;
    int mWidth;
    int mHeight;
};
@property (nonatomic,retain)NSString* brandId;
@property (nonatomic,retain)NSString* productId;
@property (nonatomic,retain)NSString* ip;
@property (nonatomic,retain)NSString* ucid;
@property (nonatomic) int width;
@property (nonatomic) int height;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41207
@interface PGSClientSwitchMessage : PGPrivilegedSerializable{
    NSString* mNavigationUrl;
    NSString* mClientUrl;
    BOOL mSilent;
};
@property (nonatomic,retain)NSString* navigationUrl;
@property (nonatomic,retain)NSString* clientUrl;
@property (nonatomic) BOOL silent;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41208
@interface PGSAvatarDetails : PGSerializable{
    uint8_t mAvatarStatus;
    NSString* mAvatarImageName;
    NSString* mAvatarImagePath;
};
@property (nonatomic) uint8_t avatarStatus;
@property (nonatomic,retain)NSString* avatarImageName;
@property (nonatomic,retain)NSString* avatarImagePath;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41209
@interface PGSAvatarUpdateEventMessage : PGPrivilegedSerializable{
    NSString* mUserId;
    PGSUserAvatarInfo* mUserAvatarInfo;
};
@property (nonatomic,retain)NSString* userId;
@property (nonatomic,retain)PGSUserAvatarInfo* userAvatarInfo;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41210
@interface PGSGameTypeInfo : PGSerializable{
    int mLimitType;
    int mGameType;
};
@property (nonatomic) int limitType;
@property (nonatomic) int gameType;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41211
@interface PGSGameVariantBonus : PGSerializable{
    int mGameCategory;
    NSMutableArray* mAllowedStakesInCents;
    NSMutableArray* mAllowedSeats;
    NSMutableArray* mAllowedPools;
    NSMutableArray* mAllowedGameTypes;
    BOOL mGvb;
    long long mBonusAmount;
    NSString* mAccountCurrencyType;
};
@property (nonatomic) int gameCategory;
@property (nonatomic,retain)NSMutableArray* allowedStakesInCents;
@property (nonatomic,retain)NSMutableArray* allowedSeats;
@property (nonatomic,retain)NSMutableArray* allowedPools;
@property (nonatomic,retain)NSMutableArray* allowedGameTypes;
@property (nonatomic) BOOL gvb;
@property (nonatomic) long long bonusAmount;
@property (nonatomic,retain)NSString* accountCurrencyType;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41212
@interface PGSPlayBalance : PGPrivilegedSerializable{
    long long mChips;
};
@property (nonatomic) long long chips;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41213
@interface PGSRealBalance : PGPrivilegedSerializable{
    long long mAccountBalance;
    NSString* mAccountCurrency;
    long long mCashOutableBalance;
    NSMutableArray* mRestrictedBalance;
    long long mPayPalBalance;
};
@property (nonatomic) long long accountBalance;
@property (nonatomic,retain)NSString* accountCurrency;
@property (nonatomic) long long cashOutableBalance;
@property (nonatomic,retain)NSMutableArray* restrictedBalance;
@property (nonatomic) long long PayPalBalance;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41214
@interface PGSRequestUserBalanceInfo : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41215
@interface PGSTourneyCurrencyBalance : PGPrivilegedSerializable{
    long long mTourneyCurrencyBalance;
    NSString* mTourneyCurrencyType;
};
@property (nonatomic) long long tourneyCurrencyBalance;
@property (nonatomic,retain)NSString* tourneyCurrencyType;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41216
@interface PGSResponseUserBalanceInfo : PGPrivilegedSerializable{
    PGSPlayBalance* mPlayBalance;
    PGSRealBalance* mRealBalance;
    PGSTourneyCurrencyBalance* mTourneyCurrencyBalance;
};
@property (nonatomic,retain)PGSPlayBalance* playBalance;
@property (nonatomic,retain)PGSRealBalance* realBalance;
@property (nonatomic,retain)PGSTourneyCurrencyBalance* tourneyCurrencyBalance;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41217
@interface PGSResponseUserBalanceInfoError : PGPrivilegedSerializable{
    int mErrorCode;
};
@property (nonatomic) int errorCode;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41218
@interface PGSNotifyPlayerProfileWithSSOKey : PGPrivilegedSerializable{
    NSString* mSessionKey;
    NSData* mEncryptedProfile;
    NSString* mEncodedSSOKey;
};
@property (nonatomic,retain)NSString* sessionKey;
@property (nonatomic,retain)NSData* encryptedProfile;
@property (nonatomic,retain)NSString* encodedSSOKey;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41219
@interface PGSNetRealBalance : PGPrivilegedSerializable{
    long long mAccountBalance;
    NSString* mAccountCurrency;
    long long mCashOutableBalance;
    NSMutableArray* mRestrictedBalance;
    long long mNetAccountBalance;
    long long mPayPalBalance;
};
@property (nonatomic) long long accountBalance;
@property (nonatomic,retain)NSString* accountCurrency;
@property (nonatomic) long long cashOutableBalance;
@property (nonatomic,retain)NSMutableArray* restrictedBalance;
@property (nonatomic) long long netAccountBalance;
@property (nonatomic) long long payPalBalance;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41220
@interface PGSRequestNetUserBalanceInfo : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41221
@interface PGSResponseNetUserBalanceInfo : PGPrivilegedSerializable{
    PGSPlayBalance* mPlayBalance;
    PGSNetRealBalance* mNetRealBalance;
    PGSTourneyCurrencyBalance* mTourneyCurrencyBalance;
};
@property (nonatomic,retain)PGSPlayBalance* playBalance;
@property (nonatomic,retain)PGSNetRealBalance* netRealBalance;
@property (nonatomic,retain)PGSTourneyCurrencyBalance* tourneyCurrencyBalance;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41222
@interface PGSResponseNetUserBalanceInfoError : PGPrivilegedSerializable{
    int mErrorCode;
};
@property (nonatomic) int errorCode;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41223
@interface PGSSessionLimitLogout : PGPrivilegedSerializable{
};
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 41224
@interface PGSRequestToStayORLogOutOnUserAction : PGPrivilegedSerializable{
    int mTimeLeftInSec;
};
@property (nonatomic) int timeLeftInSec;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end


// CLASSID: 69633
@interface RTPointsUpdate : PGPrivilegedSerializable{
    BOOL mIsPointsEnabled;
    NSString* mPlayerCategory;
    int mPoints;
};
@property (nonatomic) BOOL isPointsEnabled;
@property (nonatomic,retain)NSString* playerCategory;
@property (nonatomic) int points;
-(void) read:(PGByteArrayReader*) byteArrayReader;
-(void) write:(PGByteArrayWriter*) byteArrayWriter;
@end




