//
//  File.swift
//  
//
//  Created by Quico Moya on 27.02.23.
//

import Foundation
import FirebaseRemoteConfigurationDependency
import FirebaseRemoteConfig
import Dependencies

extension FirebaseRemoteConfigurationClient {
	static func live(remoteConfig: RemoteConfigProtocol) -> Self {
		return .init(
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
			
			stringForKey: { key in
				let value = remoteConfig.configValue(forKey: key)
				return value.stringValue
			},
			
			numberForKey: { key in
				let value = remoteConfig.configValue(forKey: key)
				return value.numberValue
			},
			
			dataForKey: { key in
				let value = remoteConfig.configValue(forKey: key)
				return value.dataValue
			},
			
			boolForKey: { key in
				let value = remoteConfig.configValue(forKey: key)
				let boolValue = value.boolValue
				return boolValue
			},
			
			jsonForKey: { key in
				let value = remoteConfig.configValue(forKey: key)
				return value.jsonValue as? JSONSerialization
			}
		)
	}
}

extension FirebaseRemoteConfigurationClient: DependencyKey {
	public static var liveValue: FirebaseRemoteConfigurationClient = .live(remoteConfig: RemoteConfig.remoteConfig())
}

extension RemoteConfig: RemoteConfigProtocol {}
