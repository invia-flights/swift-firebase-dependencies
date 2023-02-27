//
//  File.swift
//  
//
//  Created by Quico Moya on 27.02.23.
//

import Foundation
import Dependencies

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

public struct Settings {
	public init(minimumFetchInterval: TimeInterval? = nil, fetchTimeout: TimeInterval? = nil) {
		self.minimumFetchInterval = minimumFetchInterval
		self.fetchTimeout = fetchTimeout
	}
	
	public let minimumFetchInterval: TimeInterval?
	public let fetchTimeout: TimeInterval?
}

public struct FirebaseRemoteConfigurationClient: Sendable {
	public init(configure: @escaping @Sendable (Settings) -> Void, setDefaultsFromPlist: @escaping @Sendable (String?) -> Void, lastFetchTime: @escaping @Sendable () -> Date?, lastFetchStatus: @escaping @Sendable () -> FetchStatus) {
		self.configure = configure
		self.setDefaultsFromPlist = setDefaultsFromPlist
		self.lastFetchTime = lastFetchTime
		self.lastFetchStatus = lastFetchStatus
	}
	
	let configure: @Sendable (Settings) -> Void
	let setDefaultsFromPlist: @Sendable (String?) -> Void
	let lastFetchTime: @Sendable () -> Date?
	let lastFetchStatus: @Sendable () -> FetchStatus
}

extension FirebaseRemoteConfigurationClient: TestDependencyKey {
	public static var testValue: FirebaseRemoteConfigurationClient = .init(
		configure: unimplemented("configure"),
		setDefaultsFromPlist: unimplemented("setDefaultsFromPlist"),
		lastFetchTime: unimplemented("lastFetchTime"),
		lastFetchStatus: unimplemented("lastFetchStatus")
	)
}
