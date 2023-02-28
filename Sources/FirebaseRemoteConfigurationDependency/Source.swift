//
//  File.swift
//
//
//  Created by Quico Moya on 28.02.23.
//

import Foundation

/// Enumerated value that indicates the source of Remote Config data. Data can come from the Remote
/// Config service, the DefaultConfig that is available when the app is first installed, or a static
/// initialized value if data is not available from the service or DefaultConfig.
extension FirebaseRemoteConfigClient {
  public enum Source {
    /// The data source is the Remote Config service.
    case remote

    /// The data source is the DefaultConfig defined for this app.
    case `default`

    /// The data doesn’t exist, return a static initialized value.
    case `static`
  }
}
