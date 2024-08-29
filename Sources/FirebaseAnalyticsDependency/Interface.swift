import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct FirebaseAnalyticsClient: Sendable {
	public init(
		log: @Sendable @escaping (Event) async throws -> Event,
		custom: @Sendable @escaping (any Eventable) async throws -> Event,
		setAnalyticsCollectionEnabled: @Sendable @escaping (Bool) -> Bool,
		setUserProperty: @Sendable @escaping (_ value: String?, _ name: String) -> (
			name: String,
			value: String?
		)
	) {
		self.log = log
		self.custom = custom
		self.setAnalyticsCollectionEnabled = setAnalyticsCollectionEnabled
		self.setUserProperty = setUserProperty
	}

	public var log: @Sendable (Event) async throws -> Event
	public var custom: @Sendable (any Eventable) async throws -> Event
	public var setAnalyticsCollectionEnabled: @Sendable (Bool) -> Bool
	public var setUserProperty: @Sendable (_ value: String?, _ name: String) -> (
		name: String,
		value: String?
	)
}

extension FirebaseAnalyticsClient: TestDependencyKey {
	public static var testValue: FirebaseAnalyticsClient = .init(
		log: unimplemented("log"),
		custom: unimplemented("custom"),
		setAnalyticsCollectionEnabled: unimplemented("setAnalyticsCollectionEnabled"),
		setUserProperty: unimplemented("setUserProperty")
	)
}

public extension DependencyValues {
	var firebaseAnalytics: FirebaseAnalyticsClient {
		get { self[FirebaseAnalyticsClient.self] }
		set { self[FirebaseAnalyticsClient.self] = newValue }
	}
}
