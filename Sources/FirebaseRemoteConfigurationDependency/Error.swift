import Foundation

public extension FirebaseRemoteConfigClient {
	enum Error: Equatable {
		/// Unknown or no error.
		case unknown

		/// Frequency of fetch requests exceeds throttled limit.
		case throttled

		/// Internal error that covers all internal HTTP errors.
		case `internal`
	}
}
