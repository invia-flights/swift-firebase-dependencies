import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct FirebaseAnalyticsClient: Sendable {
	public init(
		log: @Sendable @escaping (Event) async throws -> Void,
		setAnalyticsCollectionEnabled: @Sendable @escaping (Bool) -> Void,
		setUserProperty: @Sendable @escaping (_ value: String?, _ name: String) -> Void
	) {
		self.log = log
		self.setAnalyticsCollectionEnabled = setAnalyticsCollectionEnabled
		self.setUserProperty = setUserProperty
	}

	public var log: @Sendable (Event) async throws -> Void
	public var setAnalyticsCollectionEnabled: @Sendable (Bool) -> Void
	public var setUserProperty: @Sendable (_ value: String?, _ name: String) -> Void
}

extension FirebaseAnalyticsClient: TestDependencyKey {
	public static var testValue: FirebaseAnalyticsClient = .init(
		log: unimplemented("log"),
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
