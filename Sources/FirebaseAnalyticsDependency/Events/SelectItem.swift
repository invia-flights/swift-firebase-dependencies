public extension Event {
	struct SelectItem: Equatable {
		public let items: [Item]
		public let itemListID: String?
		public let itemListName: String?
	}
}
