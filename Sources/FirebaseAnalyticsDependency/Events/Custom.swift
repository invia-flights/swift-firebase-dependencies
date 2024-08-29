import Foundation

public protocol Eventable {
	associatedtype Parameters: Encodable & Equatable
	var name: String { get }
	var parameters: Parameters { get }
}

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

		static var encoder: ParametersEncoder = .init()

		static func build(from eventable: any Eventable) -> Self {
			let parameters = try? encoder.encode(eventable.parameters)
			return .init(name: eventable.name, parameters: parameters ?? [:])
		}
	}
}
