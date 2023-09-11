import Foundation

public extension Event {
	struct Purchase: Equatable {
		public init(
			affiliation: String? = nil,
			coupon: String? = nil,
			value: Money? = nil,
			endDate: Date? = nil,
			itemID: String? = nil,
			items: [Item],
			shipping: Double,
			startDate: Date? = nil,
			tax: Double? = nil,
			transactionID: String? = nil
		) {
			self.affiliation = affiliation
			self.coupon = coupon
			self.value = value
			self.endDate = endDate
			self.itemID = itemID
			self.items = items
			self.shipping = shipping
			self.startDate = startDate
			self.tax = tax
			self.transactionID = transactionID
		}

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
