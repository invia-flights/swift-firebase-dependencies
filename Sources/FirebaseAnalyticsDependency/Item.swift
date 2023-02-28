import Foundation

public struct Item: Equatable {
  public init(
    id: String? = nil,
    name: String? = nil,
    category: String? = nil,
    variant: String? = nil,
    brand: String? = nil,
    price: Money? = nil,
    listID: String? = nil,
    listName _: String? = nil
  ) {
    self.id = id
    self.name = name
    self.category = category
    self.variant = variant
    self.brand = brand
    self.price = price
    self.listID = listID
    listName = listID
  }

  public let id: String?
  public let name: String?
  public let category: String?
  public let variant: String?
  public let brand: String?
  public let price: Money?
  public let listID: String?
  public let listName: String?
}
