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
				if let minimumFetchInterval = settings.minimumFetchInterval {
					remoteConfigSettings.minimumFetchInterval = minimumFetchInterval
				}
				if let fetchTimeout = settings.fetchTimeout {
					remoteConfigSettings.fetchTimeout = fetchTimeout
				}
				remoteConfig.configSettings = remoteConfigSettings
			},
			
			setDefaultsFromPlist: { string in
				remoteConfig.setDefaults(fromPlist: string)
			},
			
			lastFetchTime: {
				remoteConfig._lastFetchTime
			},
			
			lastFetchStatus: {
				remoteConfig._lastFetchStatus
			}
		)
	}
}

extension FirebaseRemoteConfigurationClient: DependencyKey {
	public static var liveValue: FirebaseRemoteConfigurationClient = .live(remoteConfig: RemoteConfig.remoteConfig())
}

extension RemoteConfig: RemoteConfigProtocol {
	public var _lastFetchTime: Date? {
		lastFetchTime
	}
	
	public var _lastFetchStatus: FirebaseRemoteConfigurationDependency.FetchStatus {
		switch lastFetchStatus {
		case .noFetchYet:
			return .noFetchYet
		case .success:
			return .success
		case .failure:
			return .failure
		case .throttled:
			return .throttled
		default:
			return .failure
		}
	}
}
