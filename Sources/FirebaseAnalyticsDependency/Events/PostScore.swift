public extension Event {
	struct PostScore: Equatable {
		public let score: Int
		public let level: Int?
		public let character: String?
	}
}
