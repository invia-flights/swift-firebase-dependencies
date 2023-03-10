public extension Event {
	struct ViewSearchResults: Equatable {
		public init(searchTerm: String) {
			self.searchTerm = searchTerm
		}

		public let searchTerm: String
	}
}
