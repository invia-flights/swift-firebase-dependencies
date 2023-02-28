public extension Event {
	struct AddShippingInfo: Equatable {
		public init(
			coupon: String,
			items: [Item],
			shippingTier: String,
			value: Money? = nil
		) {
			self.coupon = coupon
			self.items = items
			self.shippingTier = shippingTier
			self.value = value
		}

		public let coupon: String
		public let items: [Item]
		public let shippingTier: String
		public let value: Money?
	}
}
