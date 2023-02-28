public extension Event {
	struct AddToWishList: Equatable {
		public init(value: Money? = nil, items: [Item]) {
			self.value = value
			self.items = items
		}

		public let value: Money?
		public let items: [Item]
	}
}
