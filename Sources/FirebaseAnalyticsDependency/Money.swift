//
//  File.swift
//
//
//  Created by Quico Moya on 28.02.23.
//

import Foundation

public struct Money: Equatable {
  public init(amount: Double, currency: String) {
    self.amount = amount
    self.currency = currency
  }

  public let amount: Double
  public let currency: String
}
