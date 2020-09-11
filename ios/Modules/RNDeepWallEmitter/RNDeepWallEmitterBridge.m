//
//  RNDeepWallEmitterBridge.m
//  RNDeepWall
//
//  Created by Burak Yalcin on 8.09.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNDeepWallEmitter, NSObject)

+ (BOOL)requiresMainQueueSetup {
  return YES;
}

@end
