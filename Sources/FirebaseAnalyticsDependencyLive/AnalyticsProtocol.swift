import Dependencies
import FirebaseAnalytics
import Foundation

public protocol AnalyticsProtocol {
	func logEvent(_ name: String, parameters: [String: Any]?)
	func setAnalyticsCollectionEnabled(_ enabled: Bool)
	func setUserProperty(_ value: String?, forName name: String)
}

public struct AnalyticsWrapper: AnalyticsProtocol {
	public init() {}

	public func logEvent(_ name: String, parameters: [String: Any]?) {
		Analytics.logEvent(name, parameters: parameters)
	}

	public func setAnalyticsCollectionEnabled(_ enabled: Bool) {
		Analytics.setAnalyticsCollectionEnabled(enabled)
	}

	public func setUserProperty(_ value: String?, forName name: String) {
		Analytics.setUserProperty(value, forName: name)
	}
}

struct TestAnalytics: AnalyticsProtocol {
	var _logEvent: (String, [String: Any]?) -> Void = unimplemented("_logEvent")
	var _setAnalyticsCollectionEnabled: (Bool) -> Void = unimplemented(
		"_setAnalyticsCollectionEnabled"
	)
	var _setUserProperty: (String?, String) -> Void = unimplemented(
		"_setUserProperty"
	)

	func logEvent(_ name: String, parameters: [String: Any]?) {
		_logEvent(name, parameters)
	}

	func setAnalyticsCollectionEnabled(_ enabled: Bool) {
		_setAnalyticsCollectionEnabled(enabled)
	}

	func setUserProperty(_ value: String?, forName name: String) {
		_setUserProperty(value, name)
	}
}
