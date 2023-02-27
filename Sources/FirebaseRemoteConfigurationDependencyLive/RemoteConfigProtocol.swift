//
//  File.swift
//  
//
//  Created by Quico Moya on 27.02.23.
//

import Foundation
import FirebaseRemoteConfig
import FirebaseRemoteConfigurationDependency

public protocol RemoteConfigProtocol: AnyObject {
	var configSettings: RemoteConfigSettings { get set }
	func setDefaults(fromPlist: String?)
	var _lastFetchTime: Date? { get }
	var _lastFetchStatus: FetchStatus { get }
}
