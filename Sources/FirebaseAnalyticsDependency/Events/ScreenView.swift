public extension Event {
	struct ScreenView: Equatable {
		public init(screenClass: String, screenName: String) {
			self.screenClass = screenClass
			self.screenName = screenName
		}

		public let screenClass: String
		public let screenName: String
	}
}
