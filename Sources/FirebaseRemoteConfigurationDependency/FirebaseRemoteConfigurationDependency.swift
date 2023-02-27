import Dependencies
import Foundation

public enum Source {
	case remote
	case `default`
}

/// Indicates whether updated data was successfully fetched.
public enum FetchStatus {
	/// Config has never been fetched.
	case noFetchYet

	/// Config fetch succeeded.
	case success

	/// Config fetch failed.
	case failure

	/// Config fetch was throttled.
	case throttled
}

/// Indicates whether updated data was successfully fetched.
public enum FetchAndActivateStatus {
	case successFetchedFromRemote

	case successUsingPreFetchedData

	case error
}

/// A data structure that can be used to configure the fetch settings.
public struct FetchSettings {
	public let minimumInterval: TimeInterval?
	public let timeout: TimeInterval?
}

public extension FirebaseRemoteConfigurationClient {
	enum Error: Equatable {
		/// Unknown or no error.
		case unknown

		/// Frequency of fetch requests exceeds throttled limit.
		case throttled

		/// Internal error that covers all internal HTTP errors.
		case `internal`
	}
}

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
		stringForKey: @escaping @Sendable (String) -> String?,
		numberForKey: @escaping @Sendable (String) -> NSNumber?,
		dataForKey: @escaping @Sendable (String) -> Data?,
		boolForKey: @escaping @Sendable (String) -> Bool?,
		jsonForKey: @escaping @Sendable (String) -> JSONSerialization?
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

	let stringForKey: @Sendable (String) -> String?
	let numberForKey: @Sendable (String) -> NSNumber?
	let dataForKey: @Sendable (String) -> Data?
	let boolForKey: @Sendable (String) -> Bool?
	let jsonForKey: @Sendable (String) -> JSONSerialization?
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
