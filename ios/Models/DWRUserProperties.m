//
//  DWRUserProperties.m
//  RNDeepWall
//
//  Created by Burak Yalcin on 10.11.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "DWRUserProperties.h"

@implementation DWRUserProperties

- (DeepWallUserProperties *)toDWObject {
	NSString *dwCountry = [DeepWallCountryManager getCountryByCode:self.country];
	NSString *dwLanguage = [DeepWallLanguageManager getLanguageByCode:self.language];
	
	DeepWallEnvironmentStyle dwEnvironmentStyle;
	if (self.environmentStyle != nil) {
		dwEnvironmentStyle = (DeepWallEnvironmentStyle)self.environmentStyle.integerValue;
	} else {
		dwEnvironmentStyle = DeepWallEnvironmentStyleAutomatic;
	}
	
    DeepWallUserProperties *dwUserProperties = [[DeepWallUserProperties alloc] initWithUuid:self.uuid country:dwCountry language:dwLanguage environmentStyle:dwEnvironmentStyle phoneNumber:self.phoneNumber debugAdvertiseAttributions:self.debugAdvertiseAttributions];
    dwUserProperties.emailAddress = self.emailAddress;
    dwUserProperties.firstName = self.firstName;
    dwUserProperties.lastName = self.lastName;
    return dwUserProperties;
}

@end
