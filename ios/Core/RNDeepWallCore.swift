//
//  RNDeepWallCore.swift
//  RNDeepWall
//
//  Created by Burak Yalcin on 5.09.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit
import DeepWall
import AttributionAgent
import Ploutos

typealias DeepWallDictType = [String: Any]

@objc(RNDeepWall)
internal final class RNDeepWall: NSObject {
	
    private var hasDeepWallObservers = false
    
	@objc(initialize:environment:)
	func initialize(apiKey: String, environment: Int) {
		
		if !hasDeepWallObservers {
            DeepWall.shared.observeEvents(for: self)
		}
		
		let env: DeepWallEnvironment = environment == 1 ? .sandbox : .production
		DeepWall.initialize(apiKey: apiKey, environment: env)
	}
	
	
	@objc(setUserProperties:)
	func setUserProperties(_ props: DeepWallDictType) {
		guard let dwProps = props.toObject(type: DWRUserProperties.self)?.toDWObject() else {
			return
		}
		
		DeepWall.shared.setUserProperties(dwProps)
	}
	
	@objc(updateUserProperties:language:environmentStyle:debugAdvertiseAttributions:)
	func updateUserProperties(
		country: String? = nil,
		language: String? = nil,
		environmentStyle: UInt = 0,
		debugAdvertiseAttributions: [String]? = nil) {
		
		let dwCountry: String?
		if let country = country {
			dwCountry = DeepWallCountryManager.getCountry(by: country)
		} else {
			dwCountry = nil
		}
		
		let dwLanguage: String?
		if let language = language {
			dwLanguage = DeepWallLanguageManager.getLanguage(by: language)
		} else {
			dwLanguage = nil
		}
		
		
		let dwEnvironmentStyle: DeepWallEnvironmentStyle
		if environmentStyle != 0 {
            dwEnvironmentStyle = DeepWallEnvironmentStyle.init(rawValue: environmentStyle) ?? .automatic
		} else {
			dwEnvironmentStyle = DeepWall.shared.userProperties().environmentStyle
		}
        
		DeepWall.shared.updateUserProperties(country: dwCountry, language: dwLanguage, environmentStyle: dwEnvironmentStyle, debugAdvertiseAttributions: debugAdvertiseAttributions)
	}
	
	@objc(requestPaywall:extraData:)
    func requestPaywall(action: String, extraData: [String: Any]? = nil) {
		DispatchQueue.main.async {
			guard let view = RCTPresentedViewController() else {
				return
			}
			
			DeepWall.shared.requestPaywall(action: action, in: view, extraData: extraData)
		}
	}
	
	@objc(closePaywall)
	func closePaywall() {
		DeepWall.shared.closePaywall()
	}
	
	@objc(hidePaywallLoadingIndicator)
	func hidePaywallLoadingIndicator() {
		DeepWall.shared.hidePaywallLoadingIndicator()
	}
	
	
	@objc(validateReceipt:)
	func validateReceipt(for type: Int) {
		
		let validationType: PloutosValidationType
		switch type {
		case 1:
			validationType = .purchase
		case 2:
			validationType = .restore
		case 3:
			validationType = .automatic
		default:
			return
		}
		
        Ploutos.shared.validateReceipt(for: validationType)
	}
}

// MARK: - DeepWallNotifierDelegate
extension RNDeepWall: DeepWallNotifierDelegate {
    
    func deepWallPaywallRequested() {
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallRequested", dataEncoded: [:])
    }
    
    func deepWallPaywallResponseReceived() {
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallResponseReceived", dataEncoded: [:])
    }
    
    func deepWallPaywallResponseFailure(_ event: DeepWallPaywallResponseFailedModel) {
        let data: [String: Any] = [
            "errorCode": event.errorCode,
            "reason": event.reason
        ]
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallResponseFailure", dataEncoded: data)
    }
    
    func deepWallPaywallOpened(_ event: DeepWallPaywallOpenedInfoModel) {
        let data: [String: Any] = [
            "pageId": event.pageId
        ]
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallOpened", dataEncoded: data)
    }
    
    func deepWallPaywallNotOpened(_ event: DeepWallPaywallNotOpenedInfoModel) {
        let data: [String: Any] = [
            "pageId": event.pageId
        ]
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallNotOpened", dataEncoded: data)
    }
    
    func deepWallPaywallActionShowDisabled(_ event: DeepWallPaywallActionShowDisabledInfoModel) {
        let data: [String: Any] = [
            "pageId": event.pageId
        ]
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallActionShowDisabled", dataEncoded: data)
    }
    
    func deepWallPaywallClosed(_ event: DeepWallPaywallClosedInfoModel) {
        let data: [String: Any] = [
            "pageId": event.pageId
        ]
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallClosed", dataEncoded: data)
    }
    
    func deepWallPaywallExtraDataReceived(_ event: [AnyHashable : Any]) {
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallExtraDataReceived", dataEncoded: event as! [String: Any])
    }
    
    func deepWallPaywallPurchasingProduct(_ event: DeepWallPaywallPurchasingProduct) {
        let data: [String: Any] = [
            "productCode": event.productCode
        ]
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallPurchasingProduct", dataEncoded: data)
    }
    
    func deepWallPaywallPurchaseSuccess(_ event: DeepWallValidateReceiptResult) {
        let data: [String: Any] = [
            "type": event.type.rawValue,
            "result": event.result?.toDictionary() ?? [:]
        ]
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallPurchaseSuccess", dataEncoded: data)
    }
    
    func deepWallPaywallPurchaseFailed(_ event: DeepWallPurchaseFailedModel) {
        let data: [String: Any] = [
            "productCode": event.productCode,
            "reason": event.reason,
            "errorCode": event.errorCode,
            "isPaymentCancelled": event.isPaymentCancelled
        ]
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallPurchaseFailed", dataEncoded: data)
    }
    
    func deepWallPaywallRestoreSuccess() {
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallRestoreSuccess", dataEncoded: [:])
    }
    
    func deepWallPaywallRestoreFailed(_ event: DeepWallRestoreFailedModel) {
        let data: [String: Any] = [
            "reason": event.reason.rawValue,
            "errorCode": event.errorCode,
            "errorText": event.errorText ?? "",
            "isPaymentCancelled": event.isPaymentCancelled
        ]
        RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "deepWallPaywallRestoreFailed", dataEncoded: data)
    }
}
