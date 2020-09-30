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
	
	/// DeepWall observers
	private var kairosObservers: [DeepWallNotifierHub.Observer] = []
	
	@objc(initialize:environment:)
	func initialize(apiKey: String, environment: Int) {
		
		if kairosObservers.isEmpty {
			self.observerDeepWallEvents()
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
		environmentStyle: Int = 0,
		debugAdvertiseAttributions: [String]? = nil) {
		
		let dwCountry: DeepWallCountry?
		if let country = country {
			dwCountry = DeepWallCountryManager.getCountry(by: country)
		} else {
			dwCountry = nil
		}
		
		let dwLanguage: DeepWallLanguage?
		if let language = language {
			dwLanguage = DeepWallLanguageManager.getLanguage(by: language)
		} else {
			dwLanguage = nil
		}
		
		
		let dwEnvironmentStyle: DeepWallEnvironmentStyle?
		if environmentStyle != 0 {
			dwEnvironmentStyle = DeepWallEnvironmentStyle.init(rawValue: environmentStyle)
		} else {
			dwEnvironmentStyle = nil
		}
		
		
		DeepWall.shared.updateUserProperties(country: dwCountry, language: dwLanguage, environmentStyle: dwEnvironmentStyle, debugAdvertiseAttributions: debugAdvertiseAttributions)
	}
	
	@objc(requestLanding:extraData:)
	func requestLanding(action: String, extraData: DeepWallExtraDataType? = nil) {
		DispatchQueue.main.async {
			guard let view = RCTPresentedViewController() else {
				return
			}
			
			DeepWall.shared.requestLanding(action: action, in: view, extraData: extraData)
		}
	}
	
	@objc(closeLanding)
	func closeLanding() {
		DeepWall.shared.closeLanding()
	}
	
	@objc(hideLandingLoadingIndicator)
	func hideLandingLoadingIndicator() {
		DeepWall.shared.hideLandingLoadingIndicator()
	}
	
	
	@objc(validateReceipt:)
	func validateReceipt(for type: Int) {
		
		let validationType: DeepWallReceiptValidationType
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
		
		DeepWall.shared.validateReceipt(for: validationType)
	}
}


/// MARK: - Private Functions
private extension RNDeepWall {
	
	func observerDeepWallEvents() {
		let landingOpenedObserver = DeepWallNotifierHub.observe(.landingOpened) { model in
			RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "landingOpened", data: model)
		}
		
		let landingClosedObserver = DeepWallNotifierHub.observe(.landingClosed) { model in
			RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "landingClosed", data: model)
		}
		
		let landingResponseFailureObserver = DeepWallNotifierHub.observe(.landingResponseFailure) { model in
			RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "landingResponseFailure", data: model)
		}
		
		let landingActionShowDisabledObserver = DeepWallNotifierHub.observe(.landingActionShowDisabled) { model in
			RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "landingActionShowDisabled", data: model)
		}
		
		let landingPurchasingProductObserver = DeepWallNotifierHub.observe(.landingPurchasingProduct) { model in
			RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "landingPurchasingProduct", data: model)
		}
		
		let landingPurchaseSuccessObserver = DeepWallNotifierHub.observe(.landingPurchaseSuccess) { model in
			
			let modelDict: [String: Any]
			if let model = model {
				
				let validationType: Int
				switch model.type {
				case .purchase:
					validationType = 1
				case .restore:
					validationType = 2
				case .automatic:
					validationType = 3
				@unknown default:
					validationType = 0
				}
				
				modelDict = [
					"type": validationType,
					"result": try? DictionaryEncoder().encode(model.result)
				]
			} else {
				modelDict = [:]
			}
			
			RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "landingPurchaseSuccess", dataEncoded: modelDict)
		}
		
		let landingPurchaseFailedObserver = DeepWallNotifierHub.observe(.landingPurchaseFailed) { model in
			RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "landingPurchaseFailed", data: model)
		}
		
		let landingRestoreSuccessObserver = DeepWallNotifierHub.observe(.landingRestoreSuccess) {
			RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "landingRestoreSuccess", dataEncoded: [:])
		}
		
		let landingRestoreFailedObserver = DeepWallNotifierHub.observe(.landingRestoreFailed) { model in
			RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "landingRestoreFailed", data: model)
		}
		
		let landingExtraDataReceivedObserver = DeepWallNotifierHub.observe(.landingExtraDataReceived) { model in
			RNDeepWallEmitterSingleton.defaultManager.sendEvent(name: "landingExtraDataReceived", dataEncoded: model)
		}
		
		self.kairosObservers.append(landingOpenedObserver)
		self.kairosObservers.append(landingClosedObserver)
		self.kairosObservers.append(landingResponseFailureObserver)
		self.kairosObservers.append(landingActionShowDisabledObserver)
		self.kairosObservers.append(landingPurchasingProductObserver)
		self.kairosObservers.append(landingPurchaseSuccessObserver)
		self.kairosObservers.append(landingPurchaseFailedObserver)
		self.kairosObservers.append(landingRestoreSuccessObserver)
		self.kairosObservers.append(landingRestoreFailedObserver)
		self.kairosObservers.append(landingExtraDataReceivedObserver)
	}
	
}
