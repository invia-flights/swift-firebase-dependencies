import FirebaseRemoteConfig
import FirebaseRemoteConfigurationDependency
import Foundation

public protocol RemoteConfigProtocol: AnyObject {
	var configSettings: RemoteConfigSettings { get set }
	func setDefaults(fromPlist: String?)
	var lastFetchTime: Date? { get }
	var lastFetchStatus: RemoteConfigFetchStatus { get }
	func ensureInitialized() async throws
	func configValue(forKey key: String?, source: RemoteConfigSource) -> RemoteConfigValue
	func fetch() async throws -> RemoteConfigFetchStatus
	func fetch(withExpirationDuration duration: TimeInterval) async throws -> RemoteConfigFetchStatus
	func fetchAndActivate() async throws -> RemoteConfigFetchAndActivateStatus
	func activate() async throws -> Bool
}
