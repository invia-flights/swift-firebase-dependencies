
extension Event {
public struct Refund: Equatable {
		public let affiliation: String?
		public let coupon: String?
		public let value: Money?
		public let items: [Item]?
		public let shipping: Double?
		public let tax: Double?
		public let transactionID: String?
	}
}
