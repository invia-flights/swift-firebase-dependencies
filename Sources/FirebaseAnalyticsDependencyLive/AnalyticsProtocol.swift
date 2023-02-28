import Dependencies
import FirebaseAnalytics
import Foundation

public protocol AnalyticsProtocol {
	func logEvent(_ name: String, parameters: [String: Any]?)
	func setAnalyticsCollectionEnabled(_ enabled: Bool)
}

public struct AnalyticsWrapper: AnalyticsProtocol {
	public init() {}

	public func logEvent(_ name: String, parameters: [String: Any]?) {
		Analytics.logEvent(name, parameters: parameters)
	}

	public func setAnalyticsCollectionEnabled(_ enabled: Bool) {
		Analytics.setAnalyticsCollectionEnabled(enabled)
	}
}

struct TestAnalytics: AnalyticsProtocol {
	var _logEvent: (String, [String: Any]?) -> Void = unimplemented("_logEvent")
	var _setAnalyticsCollectionEnabled: (Bool) -> Void = unimplemented(
		"_setAnalyticsCollectionEnabled"
	)

	func logEvent(_ name: String, parameters: [String: Any]?) {
		_logEvent(name, parameters)
	}

	func setAnalyticsCollectionEnabled(_ enabled: Bool) {
		_setAnalyticsCollectionEnabled(enabled)
	}
}
