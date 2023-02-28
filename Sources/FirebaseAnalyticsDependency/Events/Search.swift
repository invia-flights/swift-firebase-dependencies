public extension Event {
	struct Search: Equatable {
		public let term: String
		public let startDate: String?
		public let endDate: String?
		public let numberOfNights: Int?
		public let numberOfRooms: Int?
		public let numberOfPassengers: Int?
		public let origin: String?
		public let destination: String?
		public let travelClass: String?
	}
}
