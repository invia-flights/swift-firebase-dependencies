import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct FirebaseAnalyticsClient {
	public init(
		log: @escaping (Event) async throws -> Event,
		setAnalyticsCollectionEnabled: @escaping (Bool) -> Bool,
		setUserProperty: @escaping (_ value: String?, _ name: String) -> (
			name: String,
			value: String?
		)
	) {
		self.log = log
		self.setAnalyticsCollectionEnabled = setAnalyticsCollectionEnabled
		self.setUserProperty = setUserProperty
	}

	public var log: (Event) async throws -> Event
	public var setAnalyticsCollectionEnabled: (Bool) -> Bool
	public var setUserProperty: (_ value: String?, _ name: String) -> (
		name: String,
		value: String?
	)
}

public extension FirebaseAnalyticsClient {
	func custom(_ eventable: any Eventable) async throws -> Event {
		let event: Event = .custom(Event.Custom.build(from: eventable))
		return try await log(event)
	}
}

extension FirebaseAnalyticsClient: TestDependencyKey {
	public static var testValue: FirebaseAnalyticsClient = .init(
		log: unimplemented("log"),
		setAnalyticsCollectionEnabled: unimplemented(
			"setAnalyticsCollectionEnabled",
			placeholder: false
		),
		setUserProperty: unimplemented("setUserProperty", placeholder: ("", nil))
	)
}

public extension DependencyValues {
	var firebaseAnalytics: FirebaseAnalyticsClient {
		get { self[FirebaseAnalyticsClient.self] }
		set { self[FirebaseAnalyticsClient.self] = newValue }
	}
}
