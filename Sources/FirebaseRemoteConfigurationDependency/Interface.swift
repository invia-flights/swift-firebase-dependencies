import Dependencies
import Foundation

/// A client for Firebase’s remote configuration service.
public struct FirebaseRemoteConfigClient: Sendable {

  /// Creates a new client.
  public init(
    configure: @escaping @Sendable (Settings) -> Void,
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
    jsonForKey: @escaping @Sendable (String, Source?) -> Any?
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

  /// Applies custom fetch settings.
  let configure: @Sendable (Settings) -> Void

  /// Sets default configs from plist for default namespace.
  ///
  /// @param fileName The plist file name, with no file name extension. For example, if the plist file
  ///                 is named `defaultSamples.plist`:
  ///                 `RemoteConfig.remoteConfig().setDefaults(fromPlist: "defaultSamples")`
  let setDefaultsFromPlist: @Sendable (String?) -> Void

  /// Last successful fetch completion time.
  let lastFetchTime: @Sendable () -> Date?

  /// Last fetch status. The status can be any enumerated value from `RemoteConfigFetchStatus`.
  let lastFetchStatus: @Sendable () -> FetchStatus

  /// Ensures initialization is complete and clients can begin querying for Remote Config values.
  let ensureInitialized: @Sendable () async throws -> Void

  /// Fetches Remote Config data. Call `activate` to make fetched data
  /// available to your app.
  ///
  /// Note: This method uses a Firebase Installations token to identify the app instance, and once
  /// it's called, it periodically sends data to the Firebase backend. (see
  /// `Installations.authToken(completion:)`).
  /// To stop the periodic sync, call `Installations.delete(completion:)`
  /// and avoid calling this method again.
  ///
  /// @param completionHandler Fetch operation callback with status and error parameters.
  let fetch: @Sendable () async throws -> FetchStatus

  /// Fetches Remote Config data and sets a duration that specifies how long config data lasts.
  /// Call `activate` to make fetched data available to your app.
  ///
  /// Note: This method uses a Firebase Installations token to identify the app instance, and once
  /// it's called, it periodically sends data to the Firebase backend. (see
  /// `Installations.authToken(completion:)`).
  /// To stop the periodic sync, call `Installations.delete(completion:)`
  /// and avoid calling this method again.
  ///
  /// @param expirationDuration  Override the (default or optionally set
  /// property in `configure`) `minimumInterval` for only the current request, in
  /// seconds. Setting a value of 0 seconds will force a fetch to the backend.
  let fetchWithExpirationDuration:
    @Sendable (_ expirationDuration: TimeInterval) async throws -> FetchStatus

  /// Fetches Remote Config data and if successful, activates fetched data. Optional completion
  /// handler callback is invoked after the attempted activation of data, if the fetch call succeeded.
  ///
  /// Note: This method uses a Firebase Installations token to identify the app instance, and once
  /// it's called, it periodically sends data to the Firebase backend. (see
  /// `Installations.authToken(completion:)`).
  /// To stop the periodic sync, call `Installations.delete(completion:)`
  /// and avoid calling this method again.
  let fetchAndActivate: @Sendable () async throws -> FetchAndActivateStatus

  /// Applies Fetched Config data to the Active Config, causing updates to the behavior and appearance
  /// of the app to take effect (depending on how config data is used in the app).
  /// @param completion Activate operation callback with changed and error parameters.
  let activate: @Sendable () async throws -> Bool

  /// If present, retrieves a `String` from the remote config storage, optionally specifying the `Source`,
  let stringForKey: @Sendable (String, Source?) -> String?

  /// If present, retrieves an `NSNumber` from the remote config storage, optionally specifying the `Source`,
  let numberForKey: @Sendable (String, Source?) -> NSNumber?

  /// If present, retrieves a `Data` instance from the remote config storage, optionally specifying the `Source`,
  let dataForKey: @Sendable (String, Source?) -> Data?

  /// If present, retrieves a`Bool` from the remote config storage, optionally specifying the `Source`,
  let boolForKey: @Sendable (String, Source?) -> Bool?

  /// If present, retrieves a`JSONSerialization` instance from the remote config storage, optionally specifying the `Source`,
  let jsonForKey: @Sendable (String, Source?) -> Any?
}

extension FirebaseRemoteConfigClient: TestDependencyKey {
  /// A client instance that is appropriate for testing.
  public static var testValue: FirebaseRemoteConfigClient = .init(
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
