import FirebaseRemoteConfig
import FirebaseRemoteConfigurationDependency
import Foundation
import Dependencies

public protocol RemoteConfigProtocol: AnyObject {
	var configSettings: RemoteConfigSettings { get set }
	func setDefaults(fromPlist: String?)
	var lastFetchTime: Date? { get }
	var lastFetchStatus: RemoteConfigFetchStatus { get }
	func ensureInitialized() async throws
	func configValue(forKey key: String?, source: FirebaseRemoteConfig.RemoteConfigSource) -> RemoteConfigValue
	func fetch() async throws -> RemoteConfigFetchStatus
	func fetch(withExpirationDuration duration: TimeInterval) async throws -> RemoteConfigFetchStatus
	func fetchAndActivate() async throws -> RemoteConfigFetchAndActivateStatus
	func activate() async throws -> Bool
}

class TestRemoteConfig: RemoteConfigProtocol {
	var _setDefaultsFromPlist: (String?) -> Void = unimplemented("_setDefaultsFromPlist")
	var _ensureInitialized: () async throws -> Void = unimplemented("_ensureInitialized")
	var _configValue: (String?, RemoteConfigSource) -> RemoteConfigValue = unimplemented("_configValueForKeySource")
	var _fetch: () -> RemoteConfigFetchStatus = unimplemented("_fetch")
	var _fetchWithExpirationDuration: (TimeInterval) -> RemoteConfigFetchStatus = unimplemented("_fetchWithExpirationDuration")
	var _fetchAndActivate: () -> RemoteConfigFetchAndActivateStatus = unimplemented("_fetchAndActivate")
	var _activate: () -> Bool = unimplemented("_activate")
	var _setRemoteConfigSettings: (RemoteConfigSettings) -> Void = unimplemented("_setRemoteConfigSettings")
	var _getRemoteConfigSettings: () -> RemoteConfigSettings = unimplemented("_getRemoteConfigSettings")
	var _getLastFetchTime: () -> Date = unimplemented("_getLastFetchTime")
	var _getLastFetchStatus: () -> RemoteConfigFetchStatus = unimplemented("_getLastFetchStatus")

	var configSettings: RemoteConfigSettings {
		get {
			_getRemoteConfigSettings()
		}
		set {
			_setRemoteConfigSettings(newValue)
		}
	}

	func setDefaults(fromPlist plist: String?) {
		_setDefaultsFromPlist(plist)
	}
	
	var lastFetchTime: Date? {
		_getLastFetchTime()
	}
	
	var lastFetchStatus: RemoteConfigFetchStatus {
		_getLastFetchStatus()
	}
	
	func ensureInitialized() async throws {
		try await _ensureInitialized()
	}
	
	func configValue(forKey key: String?, source: RemoteConfigSource) -> RemoteConfigValue {
		_configValue(key, source)
	}
	
	func fetch() async throws -> RemoteConfigFetchStatus {
		_fetch()
	}
	
	func fetch(withExpirationDuration duration: TimeInterval) async throws -> RemoteConfigFetchStatus {
		_fetchWithExpirationDuration(duration)
	}
	
	func fetchAndActivate() async throws -> RemoteConfigFetchAndActivateStatus {
		_fetchAndActivate()
	}
	
	func activate() async throws -> Bool {
		_activate()
	}
}

class TestRemoteConfigValue: RemoteConfigValue {
	var _stringValue: () -> String? = unimplemented("_stringValue")
	var _numberValue: () -> NSNumber = unimplemented("_numberValue")
	var _dataValue: () -> Data = unimplemented("_dataValue")
	var _boolValue: () -> Bool = unimplemented("_boolValue")
	var _jsonValue: () -> Any? = unimplemented("_jsonValue")

	override var stringValue: String? {
		_stringValue()
	}
	
	override var numberValue: NSNumber {
		_numberValue()
	}
	
	override var dataValue: Data {
		_dataValue()
	}
	
	override var boolValue: Bool {
		_boolValue()
	}
	
	override var jsonValue: Any? {
		_jsonValue()
	}
}
