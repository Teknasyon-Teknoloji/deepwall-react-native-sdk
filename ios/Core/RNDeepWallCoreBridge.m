//
//  RNDeepWallCoreBridge.m
//  RNDeepWall
//
//  Created by Burak Yalcin on 7.09.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNDeepWall, NSObject)

RCT_EXTERN_METHOD(initialize:(NSString *)apiKey environment:(int)environment)
RCT_EXTERN_METHOD(setUserProperties:(NSDictionary *)props)
RCT_EXTERN_METHOD(updateUserProperties:(NSString *)country language:(NSString *)language environmentStyle:(int)environmentStyle debugAdvertiseAttributions:(NSDictionary *)debugAdvertiseAttributions)

RCT_EXTERN_METHOD(requestPaywall:(NSString *)action extraData:(NSDictionary *)extraData)
RCT_EXTERN_METHOD(closePaywall)
RCT_EXTERN_METHOD(hidePaywallLoadingIndicator)

RCT_EXTERN_METHOD(validateReceipt:(int)type)

+ (BOOL)requiresMainQueueSetup {
	return YES;
}

@end
