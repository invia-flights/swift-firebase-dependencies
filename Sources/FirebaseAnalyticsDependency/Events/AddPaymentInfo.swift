extension Event {
  public struct AddPaymentInfo: Equatable {
    public init(
      coupon: String,
      items: [Item],
      paymentType: String,
      value: Money? = nil
    ) {
      self.coupon = coupon
      self.items = items
      self.paymentType = paymentType
      self.value = value
    }

    public let coupon: String
    public let items: [Item]
    public let paymentType: String
    public let value: Money?
  }
}
