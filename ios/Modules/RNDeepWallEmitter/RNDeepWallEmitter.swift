//
//  RNDeepWallEmitter.swift
//  RNDeepWall
//
//  Created by Burak Yalcin on 8.09.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

import React

@objc(RNDeepWallEmitter)
internal class RNDeepWallEmitter: RCTEventEmitter {

	override init() {
		super.init()
		
		if RNDeepWallEmitterSingleton.defaultManager.emitter == nil {
			RNDeepWallEmitterSingleton.defaultManager.emitter = self
		}
	}

	var hasListener: Bool = false

	override func startObserving() {
		self.hasListener = true
	}

	override func stopObserving() {
		self.hasListener = false
	}

	override class func requiresMainQueueSetup() -> Bool {
		return true
	}

	override func supportedEvents() -> [String]! {
		return ["DeepWallEvent"]
	}
}


internal final class RNDeepWallEmitterSingleton {

	private init() { }

	static var defaultManager = RNDeepWallEmitterSingleton()

	var emitter: RNDeepWallEmitter?

	func sendEvent<T: Encodable>(name: String, data: T) {

		guard let encodedData = try? DictionaryEncoder().encode(data) else {
			return
		}
		
		self.sendEvent(name: name, dataEncoded: encodedData)
	}
	
	func sendEvent(name: String, dataEncoded: [String: Any]) {
		guard self.emitter?.hasListener ?? false else {
			return
		}

		self.emitter?.sendEvent(withName: "DeepWallEvent", body: [
			"event": name,
			"data": dataEncoded
		])
	}
}
