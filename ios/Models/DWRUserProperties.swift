//
//  DWRUserProperties.swift
//  RNDeepWall
//
//  Created by Burak Yalcin on 8.09.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

import DeepWall

public final class DWRUserProperties: Decodable {
	
	public var uuid: String
	public var country: String
	public var language: String
	public var environmentStyle: UInt?
	public var debugAdvertiseAttributions: [String]?
}

extension DWRUserProperties {
	
	func toDWObject() -> DeepWallUserProperties {
		
		let dwCountry = DeepWallCountryManager.getCountry(by: self.country)
		let dwLanguage = DeepWallLanguageManager.getLanguage(by: self.language)
		let dwEnvironmentStyle: DeepWallEnvironmentStyle
		if let environmentStyle = self.environmentStyle {
            dwEnvironmentStyle = DeepWallEnvironmentStyle.init(rawValue: environmentStyle) ?? .automatic
		} else {
            dwEnvironmentStyle = .automatic
		}
		
		return DeepWallUserProperties(
			uuid: self.uuid,
			country: dwCountry,
			language: dwLanguage,
            environmentStyle: dwEnvironmentStyle,
			debugAdvertiseAttributions: self.debugAdvertiseAttributions)
	}
}
