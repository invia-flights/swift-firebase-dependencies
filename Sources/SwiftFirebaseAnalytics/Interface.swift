import Foundation
import Dependencies

public struct FirebaseTracking<Item: Equatable> {
	public init(log: @escaping (Event<Item>) async throws -> Void) {
		self.log = log
	}
	
	public var log: (Event<Item>) async throws -> Void
}
