extension Event {
public struct BeginCheckout: Equatable {
		public init(coupon: String, items: [Item], value: Money? = nil) {
			self.coupon = coupon
			self.items = items
			self.value = value
		}

		public let coupon: String
		public let items: [Item]
		public let value: Money?
	}
}
