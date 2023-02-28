
extension Event {
public struct ViewPromotion: Equatable {
		public let creativeName: String ///     <li>@c AnalyticsParameterCreativeName (String)
		/// (optional)</li>
		public let creativeSlot: String ///     <li>@c AnalyticsParameterCreativeSlot (String)
		/// (optional)</li>
		public let items: [Item]? ///     <li>@c AnalyticsParameterItems ([[String:
		/// Any]])
		/// (optional)</li>
		public let locationID: String?
		public let promotionID: String?
		public let promotionName: String?
	}
}
