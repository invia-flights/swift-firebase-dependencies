extension Event {
  public struct PostScore: Equatable {
    public let score: Int
    public let level: Int?
    public let character: String?
  }
}
