import Foundation

public extension FirebaseRemoteConfigClient {
	/// Indicates whether updated data was successfully fetched.
	enum FetchStatus {
		/// Config has never been fetched.
		case noFetchYet

		/// Config fetch succeeded.
		case success

		/// Config fetch failed.
		case failure

		/// Config fetch was throttled.
		case throttled
	}
}
