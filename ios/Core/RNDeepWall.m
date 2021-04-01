
#import "RNDeepWall.h"
#import <DeepWall/DeepWall.h>
#import <React/RCTUtils.h>
#import "RNDeepWallEmitter.h"
#import "DWRUserProperties.h"

@interface RNDeepWall() <DeepWallNotifierDelegate>

@property (class) BOOL hasInitialized;

@end

@implementation RNDeepWall

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

static BOOL hasInitialized;

+ (void)setHasInitialized:(BOOL)status {
    hasInitialized = status;
}

+ (BOOL)hasInitialized {
    return hasInitialized;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(initialize:(NSString *)apiKey environment:(int)environment)
{
    if ([RNDeepWall hasInitialized] == YES) {
        return;
    }

    [RNDeepWall setHasInitialized:YES];

	[[DeepWallCore shared] observeEventsFor:self];

	DeepWallEnvironment env;
	if (environment == 1) {
		env = DeepWallEnvironmentSandbox;
	} else {
		env = DeepWallEnvironmentProduction;
	}

	[DeepWallCore initializeWithApiKey:apiKey environment:env];
}

RCT_EXPORT_METHOD(setUserProperties:(NSDictionary *)props)
{
	NSError *error;
	DWRUserProperties *dwProps = [[DWRUserProperties alloc] initWithDictionary:props error:&error];

	if (error != nil) {
		NSLog(@"[RNDeepWall] Failed to set user properties!");
		return;
	}

	[[DeepWallCore shared] setUserProperties:[dwProps toDWObject]];
}

RCT_EXPORT_METHOD(updateUserProperties:(NSString *)country language:(NSString *)language environmentStyle:(int)environmentStyle debugAdvertiseAttributions:(NSDictionary *)debugAdvertiseAttributions)
{
	NSString *dwCountry = nil;
	if (country != nil) {
		dwCountry = [DeepWallCountryManager getCountryByCode:country];
	}

	NSString *dwLanguage = nil;
	if (language != nil) {
		dwLanguage = [DeepWallLanguageManager getLanguageByCode:language];
	}

	DeepWallEnvironmentStyle dwEnvironmentStyle;
	if (environmentStyle != 0) {
		dwEnvironmentStyle = (DeepWallEnvironmentStyle)environmentStyle;
	} else {
		dwEnvironmentStyle = [[DeepWallCore shared] userProperties].environmentStyle;
	}

	[[DeepWallCore shared] updateUserPropertiesCountry:dwCountry language:dwLanguage environmentStyle:dwEnvironmentStyle debugAdvertiseAttributions:debugAdvertiseAttributions];
}


RCT_EXPORT_METHOD(requestPaywall:(NSString *)action extraData:(NSDictionary *)extraData)
{
	dispatch_async(dispatch_get_main_queue(), ^{
		UIViewController *view = RCTPresentedViewController();
		if (view == nil) {
			return;
		}

		[[DeepWallCore shared] requestPaywallWithAction:action inView:view extraData:extraData];
	});

}


RCT_EXPORT_METHOD(closePaywall)
{
	[[DeepWallCore shared] closePaywall];
}

RCT_EXPORT_METHOD(hidePaywallLoadingIndicator)
{
	[[DeepWallCore shared] hidePaywallLoadingIndicator];
}

RCT_EXPORT_METHOD(validateReceipt:(int)type)
{
	PloutosValidationType validationType = (PloutosValidationType)type;
	[[DeepWallCore shared] validateReceiptForType:validationType];
}


#pragma mark - DeepWallNotifierDelegate

- (void)deepWallPaywallRequested {
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallRequested" dataEncoded:@{}];
}

- (void)deepWallPaywallResponseReceived {
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallResponseReceived" dataEncoded:@{}];
}

- (void)deepWallPaywallResponseFailure:(DeepWallPaywallResponseFailedModel *)event {
	NSDictionary *data = @{
		@"errorCode": event.errorCode ?: @"",
		@"reason": event.reason ?: @""
	};
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallResponseFailure" dataEncoded:data];
}

- (void)deepWallPaywallOpened:(DeepWallPaywallOpenedInfoModel *)event {
	NSDictionary *data = @{
		@"pageId": @(event.pageId)
	};
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallOpened" dataEncoded:data];
}

- (void)deepWallPaywallNotOpened:(DeepWallPaywallNotOpenedInfoModel *)event {
	NSDictionary *data = @{
		@"pageId": @(event.pageId)
	};
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallNotOpened" dataEncoded:data];
}

- (void)deepWallPaywallActionShowDisabled:(DeepWallPaywallActionShowDisabledInfoModel *)event {
	NSDictionary *data = @{
		@"pageId": @(event.pageId)
	};
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallActionShowDisabled" dataEncoded:data];
}

- (void)deepWallPaywallClosed:(DeepWallPaywallClosedInfoModel)event {
	NSDictionary *data = @{
		@"pageId": @(event.pageId)
	};
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallClosed" dataEncoded:data];
}

- (void)deepWallPaywallExtraDataReceived:(DeepWallExtraDataType)event {
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallExtraDataReceived" dataEncoded:event];
}


- (void)deepWallPaywallPurchasingProduct:(DeepWallPaywallPurchasingProduct *)event {
	NSDictionary *data = @{
		@"productCode": event.productCode
	};
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallPurchasingProduct" dataEncoded:data];
}

- (void)deepWallPaywallPurchaseSuccess:(DeepWallValidateReceiptResult)event {
	NSDictionary *data = @{
		@"type": @((int)event.type),
		@"result": event.result != nil ? [event.result toDictionary] : @{}
	};
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallPurchaseSuccess" dataEncoded:data];
}


- (void)deepWallPaywallPurchaseFailed:(DeepWallPurchaseFailedModel)event {
	NSDictionary *data = @{
		@"productCode": event.productCode ?: @"",
		@"reason": event.reason ?: @"",
		@"errorCode": event.errorCode ?: @"",
		@"isPaymentCancelled": @(event.isPaymentCancelled)
	};
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallPurchaseFailed" dataEncoded:data];
}

- (void)deepWallPaywallRestoreSuccess {
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallRestoreSuccess" dataEncoded:@{}];
}

- (void)deepWallPaywallRestoreFailed:(DeepWallRestoreFailedModel)event {
	NSDictionary *data = @{
		@"reason": @((int)event.reason),
		@"errorCode": event.errorCode ?: @"",
		@"errorText": event.errorText ?: @"",
		@"isPaymentCancelled": @(event.isPaymentCancelled)
	};
	[[RNDeepWallEmitterSingleton sharedManager] sendEventWithName:@"deepWallPaywallRestoreFailed" dataEncoded:data];
}


@end

