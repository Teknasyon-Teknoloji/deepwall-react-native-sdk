//
//  RNDeepWallEmitter.h
//  RNDeepWall
//
//  Created by Burak Yalcin on 9.11.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>
#import <DeepWall/DeepWall.h>


NS_ASSUME_NONNULL_BEGIN

@interface RNDeepWallEmitter : RCTEventEmitter <RCTBridgeModule>

@end


@interface RNDeepWallEmitterSingleton: NSObject

+ (instancetype)sharedManager;

- (void)sendEventWithName:(NSString *)name data:(JSONModel *)data;
- (void)sendEventWithName:(NSString *)name dataEncoded:(NSDictionary *)encodedData;

@end

NS_ASSUME_NONNULL_END
