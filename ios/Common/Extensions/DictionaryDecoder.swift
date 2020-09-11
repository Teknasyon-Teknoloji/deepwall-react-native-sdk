//
//  DictionaryDecoder.swift
//  RNDeepWall
//
//  Created by Burak Yalcin on 8.09.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
	
	func toObject<T>(type: T.Type) -> T? where T: Decodable {
		return try? DictionaryDecoder().decode(T.self, from: self as DeepWallDictType)
	}
}

public class DictionaryDecoder {

	private let decoder = JSONDecoder()

	var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
		get { return decoder.dateDecodingStrategy }
		set { decoder.dateDecodingStrategy = newValue }
	}

	var dataDecodingStrategy: JSONDecoder.DataDecodingStrategy {
		get { return decoder.dataDecodingStrategy }
		set { decoder.dataDecodingStrategy = newValue }
	}

	var nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy {
		get { return decoder.nonConformingFloatDecodingStrategy }
		set { decoder.nonConformingFloatDecodingStrategy = newValue }
	}

	var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
		get { return decoder.keyDecodingStrategy }
		set { decoder.keyDecodingStrategy = newValue }
	}

	func decode<T>(_ type: T.Type, from dictionary: [String: Any]) throws -> T where T: Decodable {
		let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
		return try decoder.decode(type, from: data)
	}
}
