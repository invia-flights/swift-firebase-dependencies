import Foundation

public extension FirebaseRemoteConfigClient {
	/// Indicates whether updated data was successfully fetched and activated.
	enum FetchAndActivateStatus {
		public enum Success {
			/// The remote fetch succeeded and fetched data was activated.
			case fetchedFromRemote
			
			/// The fetch and activate succeeded from already fetched but yet unexpired config data. You can
			/// control this using minimumFetchInterval property in FIRRemoteConfigSettings.
			case usingPreFetchedData
		}
		
		/// The remote fetch succeeded.
		case success(Success)
		
		/// The fetch and activate failed.
		case error
	}
}
