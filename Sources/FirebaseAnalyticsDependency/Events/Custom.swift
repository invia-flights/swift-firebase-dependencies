//
//  File.swift
//  
//
//  Created by Quico Moya on 28.02.23.
//

import Foundation

public extension Event {
	struct Custom: Equatable {
		public enum Value: Equatable {
			case string(String)
			case double(Double)
			case int(Int)
			case bool(Bool)
			case array([Value])
			case dictionary([String: Value])
		}

		static let validEventNameRegularExpression =
			try! NSRegularExpression(pattern: "/^(?!google_|ga_|firebase_)[A-Za-z0-9_]*/gm")

		static func isEventNameValid(_ name: String) -> Bool {
			let range = NSRange(location: 0, length: name.utf16.count)
			return Self.validEventNameRegularExpression.firstMatch(in: name, range: range) != nil
		}

		public init(name: String, parameters: [String: Value?] = [:]) throws {
			guard Self.isEventNameValid(name) else {
				struct InvalidName: Error {}
				throw InvalidName()
			}

			self.name = name
			self.parameters = parameters
		}

		public let name: String
		public let parameters: [String: Value?]
	}
}
