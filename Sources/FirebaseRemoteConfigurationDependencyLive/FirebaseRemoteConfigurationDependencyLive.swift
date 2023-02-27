import Dependencies
import FirebaseRemoteConfig
import FirebaseRemoteConfigurationDependency
import Foundation

extension FirebaseRemoteConfigurationClient {
	static func live(remoteConfig: RemoteConfigProtocol) -> Self {
		.init(
			configure: { settings in
				let remoteConfigSettings = RemoteConfigSettings()
				if let minimumInterval = settings.minimumInterval {
					remoteConfigSettings.minimumFetchInterval = minimumInterval
				}
				if let timeout = settings.timeout {
					remoteConfigSettings.fetchTimeout = timeout
				}
				remoteConfig.configSettings = remoteConfigSettings
			},

			setDefaultsFromPlist: { string in
				remoteConfig.setDefaults(fromPlist: string)
			},

			lastFetchTime: {
				remoteConfig.lastFetchTime
			},

			lastFetchStatus: {
				switch remoteConfig.lastFetchStatus {
				case .noFetchYet:
					return .noFetchYet
				case .success:
					return .success
				case .failure:
					return .failure
				case .throttled:
					return .throttled
				@unknown default:
					return .failure
				}
			},

			ensureInitialized: {
				try await remoteConfig.ensureInitialized()
			},

			fetch: {
				switch try await remoteConfig.fetch() {
				case .noFetchYet:
					return .noFetchYet
				case .success:
					return .success
				case .failure:
					return .failure
				case .throttled:
					return .throttled
				@unknown default:
					return .failure
				}
			},

			fetchWithExpirationDuration: { duration in
				switch try await remoteConfig.fetch(withExpirationDuration: duration) {
				case .noFetchYet:
					return .noFetchYet
				case .success:
					return .success
				case .failure:
					return .failure
				case .throttled:
					return .throttled
				@unknown default:
					return .failure
				}
			},

			fetchAndActivate: {
				switch try await remoteConfig.fetchAndActivate() {
				case .successFetchedFromRemote:
					return .successFetchedFromRemote
				case .successUsingPreFetchedData:
					return .successUsingPreFetchedData
				case .error:
					return .error
				@unknown default:
					return .error
				}
			},

			activate: {
				try await remoteConfig.activate()
			},

			stringForKey: { key, source in
				remoteConfig.configValue(key: key, source: source).stringValue
			},

			numberForKey: { key, source in
				remoteConfig.configValue(key: key, source: source).numberValue
			},

			dataForKey: { key, source in
				remoteConfig.configValue(key: key, source: source).dataValue
			},

			boolForKey: { key, source in
				remoteConfig.configValue(key: key, source: source).boolValue
			},

			jsonForKey: { key, source in
				remoteConfig.configValue(key: key, source: source).jsonValue as? JSONSerialization
			}
		)
	}
}

extension FirebaseRemoteConfigurationClient: DependencyKey {
	public static var liveValue: FirebaseRemoteConfigurationClient = .live(
		remoteConfig: RemoteConfig
			.remoteConfig()
	)
}

extension RemoteConfig: RemoteConfigProtocol {}

private extension RemoteConfigProtocol {
	func configValue(key: String, source: Source?) -> RemoteConfigValue {
		let value: RemoteConfigValue
		switch source {
		case .none, .some(.default):
			value = configValue(forKey: key, source: .default)
		case .some(.remote):
			value = configValue(forKey: key, source: .remote)
		}
		return value
	}
}
