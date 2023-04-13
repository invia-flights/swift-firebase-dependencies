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

		public init(name: String, parameters: [String: Value?] = [:]) {
			self.name = name
			self.parameters = parameters
		}

		public let name: String
		public let parameters: [String: Value?]
	}
}
