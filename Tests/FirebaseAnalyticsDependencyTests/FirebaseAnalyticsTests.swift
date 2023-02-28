import XCTest

@testable import FirebaseAnalyticsDependency
@testable import FirebaseAnalyticsDependencyLive

final class FirebaseAnalyticsTests: XCTestCase {
  func testItLogsScreenViews() async throws {
    var analytics = TestAnalytics()
    var receivedEvent: String?
    var receivedParameters: [String: Any]?
    analytics._logEvent = { event, parameters in
      receivedEvent = event
      receivedParameters = parameters
    }

    let sut: FirebaseAnalyticsClient = .live(analytics: analytics)
    try await sut.log(
      .screenView(.init(screenClass: "ViewController", screenName: "SearchResults"))
    )
    XCTAssertEqual(receivedEvent, "screen_view")
    XCTAssertEqual(receivedParameters?["screen_class"] as? String, "ViewController")
    XCTAssertEqual(receivedParameters?["screen_name"] as? String, "SearchResults")
  }

  func testItLogsSignUpEvents() async throws {
    var analytics = TestAnalytics()
    var receivedEvent: String?
    var receivedParameters: [String: Any]?
    analytics._logEvent = { event, parameters in
      receivedEvent = event
      receivedParameters = parameters
    }

    let sut: FirebaseAnalyticsClient = .live(analytics: analytics)
    try await sut.log(.signUp(.init(method: "Google")))
    XCTAssertEqual(receivedEvent, "sign_up")
    XCTAssertEqual(receivedParameters?["method"] as? String, "Google")
  }

  func testItLogsViewPromotionEvents() async throws {
    var analytics = TestAnalytics()
    var receivedEvent: String?
    var receivedParameters: [String: Any]?
    analytics._logEvent = { event, parameters in
      receivedEvent = event
      receivedParameters = parameters
    }

    let sut: FirebaseAnalyticsClient = .live(analytics: analytics)
    try await sut.log(
      .viewPromotion(
        .init(
          creativeName: "Summer Sale", creativeSlot: "Banner", items: nil, locationID: nil,
          promotionID: nil, promotionName: nil
        )
      )
    )
    XCTAssertEqual(receivedEvent, "view_promotion")
    XCTAssertEqual(receivedParameters?["creative_name"] as? String, "Summer Sale")
    XCTAssertEqual(receivedParameters?["creative_slot"] as? String, "Banner")
  }

  func testItLogsSelectPromotionEvents() async throws {
    var analytics = TestAnalytics()
    var receivedEvent: String?
    var receivedParameters: [String: Any]?
    analytics._logEvent = { event, parameters in
      receivedEvent = event
      receivedParameters = parameters
    }

    let sut: FirebaseAnalyticsClient = .live(analytics: analytics)
    try await sut.log(
      .selectPromotion(
        .init(
          creativeName: "Summer Sale", creativeSlot: "Banner", items: nil, locationID: nil,
          promotionID: nil, promotionName: nil
        )
      )
    )
    XCTAssertEqual(receivedEvent, "select_promotion")
    XCTAssertEqual(receivedParameters?["creative_name"] as? String, "Summer Sale")
    XCTAssertEqual(receivedParameters?["creative_slot"] as? String, "Banner")
  }

  func testItLogsAddToCartEvents() async throws {
    var analytics = TestAnalytics()
    var receivedEvent: String?
    var receivedParameters: [String: Any]?
    analytics._logEvent = { event, parameters in
      receivedEvent = event
      receivedParameters = parameters
    }

    let sut: FirebaseAnalyticsClient = .live(analytics: analytics)
    try await sut.log(
      .addToCart(
        .init(
          value: .init(amount: 123, currency: "EUR"),
          items: [
            .init(id: "123")
          ]
        )
      )
    )
    XCTAssertEqual(receivedEvent, "add_to_cart")
    XCTAssertEqual(receivedParameters?["value"] as? Double, 123)
    XCTAssertEqual(receivedParameters?["currency"] as? String, "EUR")
    let items = receivedParameters?["items"] as! [[String: Any]]
    XCTAssertEqual(items.first?["item_id"] as? String, "123")
  }

  func testItLogsAddToWishlistEvents() async throws {
    var analytics = TestAnalytics()
    var receivedEvent: String?
    var receivedParameters: [String: Any]?
    analytics._logEvent = { event, parameters in
      receivedEvent = event
      receivedParameters = parameters
    }

    let sut: FirebaseAnalyticsClient = .live(analytics: analytics)
    try await sut.log(
      .addToWishList(
        .init(
          value: .init(amount: 123, currency: "EUR"),
          items: [
            .init(id: "123")
          ]
        )
      )
    )
    XCTAssertEqual(receivedEvent, "add_to_wishlist")
    XCTAssertEqual(receivedParameters?["value"] as? Double, 123)
    XCTAssertEqual(receivedParameters?["currency"] as? String, "EUR")
    let items = receivedParameters?["items"] as! [[String: Any]]
    XCTAssertEqual(items.first?["item_id"] as? String, "123")
  }

  func testItLogsAddPaymentInfoEvents() async throws {
    var analytics = TestAnalytics()
    var receivedEvent: String?
    var receivedParameters: [String: Any]?
    analytics._logEvent = { event, parameters in
      receivedEvent = event
      receivedParameters = parameters
    }

    let sut: FirebaseAnalyticsClient = .live(analytics: analytics)
    try await sut.log(
      .addPaymentInfo(
        .init(
          coupon: "1",
          items: [
            .init(id: "123")
          ],
          paymentType: "card",
          value: .init(
            amount: 123,
            currency: "EUR"
          )
        )
      )
    )
    XCTAssertEqual(receivedEvent, "add_payment_info")
    XCTAssertEqual(receivedParameters?["value"] as? Double, 123)
    XCTAssertEqual(receivedParameters?["currency"] as? String, "EUR")
    let items = receivedParameters?["items"] as! [[String: Any]]
    XCTAssertEqual(items.first?["item_id"] as? String, "123")
  }

  func testItLogsAddShippingInfoEvents() async throws {
    var analytics = TestAnalytics()
    var receivedEvent: String?
    var receivedParameters: [String: Any]?
    analytics._logEvent = { event, parameters in
      receivedEvent = event
      receivedParameters = parameters
    }

    let sut: FirebaseAnalyticsClient = .live(analytics: analytics)
    try await sut.log(
      .addShippingInfo(
        .init(
          coupon: "1",
          items: [
            .init(id: "123")
          ],
          shippingTier: "1",
          value: .init(
            amount: 123,
            currency: "EUR"
          )
        )
      )
    )
    XCTAssertEqual(receivedEvent, "add_shipping_info")
    XCTAssertEqual(receivedParameters?["value"] as? Double, 123)
    XCTAssertEqual(receivedParameters?["currency"] as? String, "EUR")
    let items = receivedParameters?["items"] as! [[String: Any]]
    XCTAssertEqual(items.first?["item_id"] as? String, "123")
  }
}
