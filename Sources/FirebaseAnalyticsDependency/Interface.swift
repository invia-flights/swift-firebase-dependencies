import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct FirebaseAnalyticsClient {
	public init(
		log: @escaping (Event) async throws -> Void,
		setAnalyticsCollectionEnabled: @escaping (Bool) -> Void,
		setUserProperty: @escaping (_ value: String?, _ name: String) -> Void
	) {
		self.log = log
		self.setAnalyticsCollectionEnabled = setAnalyticsCollectionEnabled
		self.setUserProperty = setUserProperty
	}

	public var log: (Event) async throws -> Void
	public var setAnalyticsCollectionEnabled: (Bool) -> Void
	public var setUserProperty: (_ value: String?, _ name: String) -> Void
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
