import Foundation

public extension Event {
	struct Purchase: Equatable {
		public let affiliation: String?
		public let coupon: String?
		public let value: Money?
		public let endDate: Date?
		public let itemID: String?
		public let items: [Item]
		public let shipping: Double
		public let startDate: Date?
		public let tax: Double?
		public let transactionID: String?
	}
}
