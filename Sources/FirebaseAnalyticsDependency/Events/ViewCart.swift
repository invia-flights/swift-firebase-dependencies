extension Event {
  public struct ViewCart: Equatable {
    public let items: [Item]?
    public let value: Money?
  }
}
