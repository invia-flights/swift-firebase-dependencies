public extension Event {
	struct CampaignDetails: Equatable {
		public init(
			source: String,
			medium: String,
			campaign: String,
			term: String? = nil,
			content: String? = nil,
			adNetworkClickID: String? = nil,
			cp1: String? = nil,
			campaignID: String? = nil,
			creativeFormat: String? = nil,
			marketingTactic: String? = nil,
			sourcePlatform: String? = nil
		) {
			self.source = source
			self.medium = medium
			self.campaign = campaign
			self.term = term
			self.content = content
			self.adNetworkClickID = adNetworkClickID
			self.cp1 = cp1
			self.campaignID = campaignID
			self.creativeFormat = creativeFormat
			self.marketingTactic = marketingTactic
			self.sourcePlatform = sourcePlatform
		}

		public let source: String
		public let medium: String
		public let campaign: String
		public let term: String?
		public let content: String?
		public let adNetworkClickID: String?
		public let cp1: String?
		public let campaignID: String?
		public let creativeFormat: String?
		public let marketingTactic: String?
		public let sourcePlatform: String?
	}
}
