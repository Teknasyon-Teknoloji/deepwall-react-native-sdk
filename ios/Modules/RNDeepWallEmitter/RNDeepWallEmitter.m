//
//  RNDeepWallEmitter.m
//  RNDeepWall
//
//  Created by Burak Yalcin on 9.11.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "RNDeepWallEmitter.h"
#import <React/RCTUtils.h>

@interface RNDeepWallEmitter()

@property (nonatomic) BOOL hasListener;
@property (nonatomic) UIViewController *oldWindow;

@end

@implementation RNDeepWallEmitter

RCT_EXPORT_MODULE();

static RNDeepWallEmitter *sharedManager = nil;

+ (instancetype)sharedEmitter {
	return sharedManager;
}

+ (void)setSharedEmitter:(RNDeepWallEmitter *)emitter {
	sharedManager = emitter;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		
		if ([RNDeepWallEmitter sharedEmitter] == nil || [RNDeepWallEmitter sharedEmitter].oldWindow == nil || [RNDeepWallEmitter sharedEmitter].oldWindow == RCTPresentedViewController()) {
			self.oldWindow = RCTPresentedViewController();
			[RNDeepWallEmitter setSharedEmitter:self];
		}
	}
	return self;
}

- (void)startObserving {
	self.hasListener = YES;
}

- (void)stopObserving {
	self.hasListener = NO;
}

- (NSArray<NSString *> *)supportedEvents {
	return @[ @"DeepWallEvent" ];
}

+ (BOOL)requiresMainQueueSetup {
	return YES;
}

@end



@implementation RNDeepWallEmitterSingleton

+ (instancetype)sharedManager {
	static RNDeepWallEmitterSingleton *sharedManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedManager = [[self alloc] init];
	});
	return sharedManager;
}


- (void)sendEventWithName:(NSString *)name data:(JSONModel *)data {
	NSDictionary *encodedData = [data toDictionary];
	[self sendEventWithName:name dataEncoded:encodedData];
}

- (void)sendEventWithName:(NSString *)name dataEncoded:(NSDictionary *)encodedData {
	if([RNDeepWallEmitter sharedEmitter] == nil || [RNDeepWallEmitter sharedEmitter].bridge == nil || [RNDeepWallEmitter sharedEmitter].hasListener == NO) {
		return;
	}
	
	[[RNDeepWallEmitter sharedEmitter] sendEventWithName:@"DeepWallEvent" body:@{
		@"event": name,
		@"data": encodedData
	}];
}



/*
 
 - (void)sendEventWithType:(DeepWallEventListenerToReactModelType)type data:(JSONModel *)data {
	 NSDictionary *encodedData = [data toDictionary];
	 [self sendEventWithType:type dictionary:encodedData];
 }

 - (void)sendEventWithType:(DeepWallEventListenerToReactModelType)type dictionary:(NSDictionary *)encodedData {
	 
	 if(self.emitter == nil || self.emitter.bridge == nil) {
		 return;
	 }
	 
	 [self.emitter sendEventWithName:@"ClientEvent" body:@{
		 @"type": @((int)type),
		 @"data": encodedData
	 }];
 }
 */


@end
