import Foundation

/// Indicates whether updated data was successfully fetched and activated.
public enum FetchAndActivateStatus {
	/// The remote fetch succeeded and fetched data was activated.
	case successFetchedFromRemote

	/// The fetch and activate succeeded from already fetched but yet unexpired config data. You can
	/// control this using minimumFetchInterval property in FIRRemoteConfigSettings.
	case successUsingPreFetchedData

	/// The fetch and activate failed.
	case error
}
