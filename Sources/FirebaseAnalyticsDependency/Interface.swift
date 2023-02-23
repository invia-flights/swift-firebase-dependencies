import Foundation
import Dependencies
import XCTestDynamicOverlay

public struct FirebaseAnalyticsClient {
	public init(log: @escaping (Event) async throws -> Void, setAnalyticsCollectionEnabled: @escaping (Bool) -> Void) {
		self.log = log
		self.setAnalyticsCollectionEnabled = setAnalyticsCollectionEnabled
	}
	
	public var log: (Event) async throws -> Void
	public var setAnalyticsCollectionEnabled: (Bool) -> Void
}

extension FirebaseAnalyticsClient: TestDependencyKey {
	public static var testValue: FirebaseAnalyticsClient = .init(
		log: unimplemented("log"),
		setAnalyticsCollectionEnabled: unimplemented("setAnalyticsCollectionEnabled")
	)
}

public extension DependencyValues {
	var firebaseAnalytics: FirebaseAnalyticsClient {
		get { self[FirebaseAnalyticsClient.self] }
		set { self[FirebaseAnalyticsClient.self] = newValue }
	}
}
