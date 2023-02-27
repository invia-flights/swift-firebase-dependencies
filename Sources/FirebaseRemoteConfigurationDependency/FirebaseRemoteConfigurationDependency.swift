import Dependencies
import Foundation

/// Enumerated value that indicates the source of Remote Config data. Data can come from the Remote
/// Config service, the DefaultConfig that is available when the app is first installed, or a static
/// initialized value if data is not available from the service or DefaultConfig.
public enum Source {
	/// The data source is the Remote Config service.
	case remote

	/// The data source is the DefaultConfig defined for this app.
	case `default`

	/// The data doesn’t exist, return a static initialized value.
	case `static`
}

/// A client for FIrebase’s remote configuration service.
public struct FirebaseRemoteConfigurationClient: Sendable {
	public init(
		configure: @escaping @Sendable (FetchSettings) -> Void,
		setDefaultsFromPlist: @escaping @Sendable (String?) -> Void,
		lastFetchTime: @escaping @Sendable () -> Date?,
		lastFetchStatus: @escaping @Sendable () -> FetchStatus,
		ensureInitialized: @escaping @Sendable () async throws -> Void,
		fetch: @escaping @Sendable () async throws -> FetchStatus,
		fetchWithExpirationDuration: @escaping @Sendable (TimeInterval) async throws -> FetchStatus,
		fetchAndActivate: @escaping @Sendable () async throws -> FetchAndActivateStatus,
		activate: @escaping @Sendable () async throws -> Bool,
		stringForKey: @escaping @Sendable (String, Source?) -> String?,
		numberForKey: @escaping @Sendable (String, Source?) -> NSNumber?,
		dataForKey: @escaping @Sendable (String, Source?) -> Data?,
		boolForKey: @escaping @Sendable (String, Source?) -> Bool?,
		jsonForKey: @escaping @Sendable (String, Source?) -> JSONSerialization?
	) {
		self.configure = configure
		self.setDefaultsFromPlist = setDefaultsFromPlist
		self.lastFetchTime = lastFetchTime
		self.lastFetchStatus = lastFetchStatus
		self.ensureInitialized = ensureInitialized
		self.fetch = fetch
		self.fetchWithExpirationDuration = fetchWithExpirationDuration
		self.fetchAndActivate = fetchAndActivate
		self.activate = activate
		self.stringForKey = stringForKey
		self.numberForKey = numberForKey
		self.dataForKey = dataForKey
		self.boolForKey = boolForKey
		self.jsonForKey = jsonForKey
	}

	let configure: @Sendable (FetchSettings) -> Void
	let setDefaultsFromPlist: @Sendable (String?) -> Void
	let lastFetchTime: @Sendable () -> Date?

	let lastFetchStatus: @Sendable () -> FetchStatus

	/// Ensures initialization is complete and clients can begin querying for Remote Config values.
	let ensureInitialized: @Sendable () async throws -> Void

	let fetch: @Sendable () async throws -> FetchStatus

	let fetchWithExpirationDuration: @Sendable (TimeInterval) async throws -> FetchStatus

	let fetchAndActivate: @Sendable () async throws -> FetchAndActivateStatus

	let activate: @Sendable () async throws -> Bool

	let stringForKey: @Sendable (String, Source?) -> String?
	let numberForKey: @Sendable (String, Source?) -> NSNumber?
	let dataForKey: @Sendable (String, Source?) -> Data?
	let boolForKey: @Sendable (String, Source?) -> Bool?
	let jsonForKey: @Sendable (String, Source?) -> JSONSerialization?
}

extension FirebaseRemoteConfigurationClient: TestDependencyKey {
	public static var testValue: FirebaseRemoteConfigurationClient = .init(
		configure: unimplemented("configure"),
		setDefaultsFromPlist: unimplemented("setDefaultsFromPlist"),
		lastFetchTime: unimplemented("lastFetchTime"),
		lastFetchStatus: unimplemented("lastFetchStatus"),
		ensureInitialized: unimplemented("ensureInitialized"),
		fetch: unimplemented("fetch"),
		fetchWithExpirationDuration: unimplemented("fetchWithExpirationDuration"),
		fetchAndActivate: unimplemented("fetchAndActivate"),
		activate: unimplemented("activate"),
		stringForKey: unimplemented("stringForKey"),
		numberForKey: unimplemented("numberForKey"),
		dataForKey: unimplemented("dataForKey"),
		boolForKey: unimplemented("boolForKey"),
		jsonForKey: unimplemented("jsonForKey")
	)
}
