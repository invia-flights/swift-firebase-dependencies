extension Event {
  public struct SelectPromotion: Equatable {
    public let creativeName: String?
    public let creativeSlot: String?
    public let items: [Item]?
    public let locationID: String?
    public let promotionID: String?
    public let promotionName: String?
  }
}
