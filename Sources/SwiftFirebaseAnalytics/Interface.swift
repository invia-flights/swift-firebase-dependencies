import Foundation

public struct FirebaseTracking<Item: Equatable> {
	var log: (Event<Item>) async throws -> Void
}
