public extension Event {
	struct SpendVirtualCurrency: Equatable {
		public let itemName: String
		public let value: Money?
	}
}
