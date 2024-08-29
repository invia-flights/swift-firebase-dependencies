import Foundation

public struct ParametersEncoder {
	public init() {}

	public func encode(_ value: some Encodable) throws -> [String: Event.Custom.Value] {
		let encoder = _CustomValueEncoder()
		try value.encode(to: encoder)
		return encoder.result
	}
}

// MARK: - Internal Encoder

private class _CustomValueEncoder: Encoder {
	var result: [String: Event.Custom.Value] = [:]

	var codingPath: [CodingKey] = []
	var userInfo: [CodingUserInfoKey: Any] = [:]

	func container<Key>(keyedBy _: Key.Type) -> KeyedEncodingContainer<Key> {
		let container = CustomKeyedEncodingContainer<Key>(encoder: self)
		return KeyedEncodingContainer(container)
	}

	func unkeyedContainer() -> UnkeyedEncodingContainer {
		fatalError("Unkeyed encoding is not supported")
	}

	func singleValueContainer() -> SingleValueEncodingContainer {
		self
	}
}

// MARK: - Custom Keyed Encoding Container

private struct CustomKeyedEncodingContainer<K: CodingKey>: KeyedEncodingContainerProtocol {
	typealias Key = K

	let encoder: _CustomValueEncoder
	var codingPath: [CodingKey] = []

	mutating func encodeNil(forKey _: K) throws {
		// Do nothing for nil values, they won't be added to the result
	}

	mutating func encode(_ value: some Encodable, forKey key: K) throws {
		encoder.result[key.stringValue] = try encoder.box(value)
	}

	mutating func nestedContainer<NestedKey>(
		keyedBy _: NestedKey.Type,
		forKey _: K
	) -> KeyedEncodingContainer<NestedKey> {
		fatalError("Nested containers are not supported")
	}

	mutating func nestedUnkeyedContainer(forKey _: K) -> UnkeyedEncodingContainer {
		fatalError("Unkeyed containers are not supported")
	}

	mutating func superEncoder() -> Encoder {
		encoder
	}

	mutating func superEncoder(forKey _: K) -> Encoder {
		encoder
	}
}

// MARK: - Single Value Encoding

extension _CustomValueEncoder: SingleValueEncodingContainer {
	func setValue(_ value: Event.Custom.Value) {
		guard let lastCodingPath = codingPath.last?.stringValue else {
			return
		}
		result[lastCodingPath] = value
	}

	func encodeNil() throws {}

	func encode(_ value: some Encodable) throws {
		try setValue(box(value))
	}

	func encode(_ value: String) throws {
		setValue(.string(value))
	}

	func encode(_ value: Double) throws {
		setValue(.double(value))
	}

	func encode(_ value: Int) throws {
		setValue(.int(value))
	}

	func encode(_ value: Bool) throws {
		setValue(.bool(value))
	}
}

// MARK: - Boxing Values

private extension _CustomValueEncoder {
	func box(_ value: some Encodable) throws -> Event.Custom.Value {
		if let stringValue = value as? String {
			return .string(stringValue)
		} else if let doubleValue = value as? Double {
			return .double(doubleValue)
		} else if let intValue = value as? Int {
			return .int(intValue)
		} else if let boolValue = value as? Bool {
			return .bool(boolValue)
		} else if let arrayValue = value as? [Encodable] {
			return try .array(arrayValue.map { try box($0) })
		} else if let dictValue = value as? [String: Encodable] {
			var dictionaryResult: [String: Event.Custom.Value] = [:]
			for (key, nestedValue) in dictValue {
				dictionaryResult[key] = try box(nestedValue)
			}
			return .dictionary(dictionaryResult)
		} else {
			let encoder = _CustomValueEncoder()
			try value.encode(to: encoder)
			return .dictionary(encoder.result)
		}
	}
}
