import Foundation

public extension FirebaseRemoteConfigClient {
	/// A data structure that can be used to configure the fetch settings.
	struct Settings {
		public init(minimumFetchInterval: TimeInterval? = nil, fetchTimeout: TimeInterval? = nil) {
			self.minimumFetchInterval = minimumFetchInterval
			self.fetchTimeout = fetchTimeout
		}
		
		/// Indicates the default value in seconds to set for the minimum interval that needs to elapse
		/// before a fetch request can again be made to the Remote Config backend. After a fetch request
		/// to
		/// the backend has succeeded, no additional fetch requests to the backend will be allowed until
		/// the
		/// minimum fetch interval expires. Note that you can override this default on a per-fetch request
		/// basis using `fetchWithExpirationDuration`. For example, setting
		/// the expiration duration to 0 in the fetch request will override the `minimumInterval` and
		/// allow the request to proceed.
		public let minimumFetchInterval: TimeInterval?

		/// Indicates the default value in seconds to abandon a pending fetch request made to the backend.
		/// This value is set for outgoing requests as the `timeoutIntervalForRequest` as well as the
		/// `timeoutIntervalForResource` on the `NSURLSession`'s configuration.
		public let fetchTimeout: TimeInterval?
	}
}
