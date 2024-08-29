import Foundation

public struct ParametersEncoder {
    public init() {}

    public func encode<T: Encodable>(_ value: T) throws -> [String: Event.Custom.Value] {
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
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        let container = CustomKeyedEncodingContainer<Key>(encoder: self)
        return KeyedEncodingContainer(container)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("Unkeyed encoding is not supported")
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        return self
    }
}

// MARK: - Custom Keyed Encoding Container

private struct CustomKeyedEncodingContainer<K: CodingKey>: KeyedEncodingContainerProtocol {
    typealias Key = K
    
    let encoder: _CustomValueEncoder
    var codingPath: [CodingKey] = []
    
    mutating func encodeNil(forKey key: K) throws {
        // Do nothing for nil values, they won't be added to the result
    }
    
    mutating func encode<T>(_ value: T, forKey key: K) throws where T : Encodable {
        encoder.result[key.stringValue] = try encoder.box(value)
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: K) -> KeyedEncodingContainer<NestedKey> {
        fatalError("Nested containers are not supported")
    }
    
    mutating func nestedUnkeyedContainer(forKey key: K) -> UnkeyedEncodingContainer {
        fatalError("Unkeyed containers are not supported")
    }
    
    mutating func superEncoder() -> Encoder {
        return encoder
    }
    
    mutating func superEncoder(forKey key: K) -> Encoder {
        return encoder
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
    
    func encode<T>(_ value: T) throws where T : Encodable {
        setValue(try box(value))
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
    func box<T: Encodable>(_ value: T) throws -> Event.Custom.Value {
        if let stringValue = value as? String {
            return .string(stringValue)
        } else if let doubleValue = value as? Double {
            return .double(doubleValue)
        } else if let intValue = value as? Int {
            return .int(intValue)
        } else if let boolValue = value as? Bool {
            return .bool(boolValue)
        } else if let arrayValue = value as? [Encodable] {
            return .array(try arrayValue.map { try box($0) })
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

