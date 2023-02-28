import Dependencies
import FirebaseAnalytics
import FirebaseAnalyticsDependency

extension FirebaseAnalyticsClient {
  public static func live(analytics: AnalyticsProtocol = AnalyticsWrapper()) -> Self {
    .init(
      log: { event in
        analytics.logEvent(event.name, parameters: event.parameters)
      },

      setAnalyticsCollectionEnabled: { enabled in
        analytics.setAnalyticsCollectionEnabled(enabled)
      }
    )
  }
}

extension FirebaseAnalyticsClient: DependencyKey {
  public static var liveValue: FirebaseAnalyticsClient = .live()
}

extension Event {
  var name: String {
    switch self {
    case let .custom(event):
      return event.name
    case .adImpression:
      return AnalyticsEventAdImpression
    case .addPaymentInfo:
      return AnalyticsEventAddPaymentInfo
    case .addShippingInfo:
      return AnalyticsEventAddShippingInfo
    case .addToCart:
      return AnalyticsEventAddToCart
    case .addToWishList:
      return AnalyticsEventAddToWishlist
    case .appOpen:
      return AnalyticsEventAppOpen
    case .beginCheckout:
      return AnalyticsEventBeginCheckout
    case .campaignDetails:
      return AnalyticsEventCampaignDetails
    case .earnVirtualCurrency:
      return AnalyticsEventEarnVirtualCurrency
    case .generateLead:
      return AnalyticsEventGenerateLead
    case .joinGroup:
      return AnalyticsEventJoinGroup
    case .levelEnd:
      return AnalyticsEventLevelEnd
    case .levelStart:
      return AnalyticsEventLevelStart
    case .levelUp:
      return AnalyticsEventLevelUp
    case .login:
      return AnalyticsEventLogin
    case .postScore:
      return AnalyticsEventPostScore
    case .purchase:
      return AnalyticsEventPurchase
    case .refund:
      return AnalyticsEventRefund
    case .removeFromCart:
      return AnalyticsEventRemoveFromCart
    case .screenView:
      return AnalyticsEventScreenView
    case .search:
      return AnalyticsEventSearch
    case .selectContent:
      return AnalyticsEventSelectContent
    case .selectItem:
      return AnalyticsEventSelectItem
    case .selectPromotion:
      return AnalyticsEventSelectPromotion
    case .share:
      return AnalyticsEventShare
    case .signUp:
      return AnalyticsEventSignUp
    case .spendVirtualCurrency:
      return AnalyticsEventSpendVirtualCurrency
    case .tutorialBegin:
      return AnalyticsEventTutorialBegin
    case .tutorialComplete:
      return AnalyticsEventTutorialComplete
    case .unlockAchievement:
      return AnalyticsEventUnlockAchievement
    case .viewCart:
      return AnalyticsEventViewCart
    case .viewItem:
      return AnalyticsEventViewItem
    case .viewItemList:
      return AnalyticsEventViewItemList
    case .viewPromotion:
      return AnalyticsEventViewPromotion
    case .viewSearchResults:
      return AnalyticsEventViewSearchResults
    }
  }
}

func transform(_ element: Event.Custom.Value) -> Any? {
  switch element {
  case let .string(string):
    return string
  case let .double(double):
    return double
  case let .int(int):
    return int
  case let .bool(bool):
    return bool
  case let .array(array):
    return array
  case let .dictionary(dictionary):
    return dictionary
  }
}

func transform(_ elements: [Event.Custom.Value]) -> [Any] {
  elements.compactMap { transform($0) }
}

func transform(_ dict: [String: Event.Custom.Value?]) -> [String: Any] {
  dict.compactMapValues {
    guard let value = $0 else {
      return nil
    }

    return transform(value)
  }
}

extension Event {
  var parameters: [String: Any]? {
    switch self {
    case let .custom(custom):
      return transform(custom.parameters)
    case let .adImpression(adImpression):
      return adImpression.parameters
    case let .addPaymentInfo(addPaymentInfo):
      return addPaymentInfo.parameters
    case let .addShippingInfo(addShippingInfo):
      return addShippingInfo.parameters
    case let .addToCart(addToCart):
      return addToCart.parameters
    case let .addToWishList(addToWishList):
      return addToWishList.parameters
    case .appOpen:
      return nil
    case let .beginCheckout(beginCheckout):
      return beginCheckout.parameters
    case let .campaignDetails(campaignDetails):
      return campaignDetails.parameters
    case let .earnVirtualCurrency(earnVirtualCurrency):
      return earnVirtualCurrency.parameters
    case let .generateLead(generateLead):
      return generateLead.parameters
    case let .joinGroup(joinGroup):
      return joinGroup.parameters
    case let .levelEnd(levelEnd):
      return levelEnd.parameters
    case let .levelStart(levelStart):
      return levelStart.parameters
    case let .levelUp(levelUp):
      return levelUp.parameters
    case .login:
      return nil
    case let .postScore(postScore):
      return postScore.parameters
    case let .purchase(purchase):
      return purchase.parameters
    case let .refund(refund):
      return refund.parameters
    case let .removeFromCart(removeFromCart):
      return removeFromCart.parameters
    case let .screenView(screenView):
      return screenView.parameters
    case let .search(search):
      return search.parameters
    case let .selectContent(selectContent):
      return selectContent.parameters
    case let .selectItem(selectItem):
      return selectItem.parameters
    case let .selectPromotion(selectPromotion):
      return selectPromotion.parameters
    case let .share(share):
      return share.parameters
    case let .signUp(signUp):
      return signUp.parameters
    case let .spendVirtualCurrency(spendVirtualCurrency):
      return spendVirtualCurrency.parameters
    case .tutorialBegin:
      return nil
    case .tutorialComplete:
      return nil
    case let .unlockAchievement(unlockAchievement):
      return unlockAchievement.parameters
    case let .viewCart(viewCart):
      return viewCart.parameters
    case let .viewItem(viewItem):
      return viewItem.parameters
    case let .viewItemList(viewItemList):
      return viewItemList.parameters
    case let .viewPromotion(viewPromotion):
      return viewPromotion.parameters
    case let .viewSearchResults(viewSearchResults):
      return viewSearchResults.parameters
    }
  }
}

extension Event.AdImpression {
  var parameters: [String: Any] {
    [
      AnalyticsParameterAdPlatform: adPlatform as Any,
      AnalyticsParameterAdFormat: adFormat as Any,
      AnalyticsParameterAdSource: adSource as Any,
      AnalyticsParameterAdUnitName: adUnitName as Any,
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.AddPaymentInfo {
  var parameters: [String: Any] {
    [
      AnalyticsParameterCoupon: coupon as Any,
      AnalyticsParameterItems: items.map(\.parameters),
      AnalyticsParameterPaymentType: paymentType as Any,
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.AddShippingInfo {
  var parameters: [String: Any] {
    [
      AnalyticsParameterCoupon: coupon as Any,
      AnalyticsParameterItems: items.map(\.parameters),
      AnalyticsParameterShippingTier: shippingTier as Any,
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.AddToCart {
  var parameters: [String: Any] {
    [
      AnalyticsParameterItems: items.map(\.parameters),
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.AddToWishList {
  var parameters: [String: Any] {
    [
      AnalyticsParameterItems: items.map(\.parameters),
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.BeginCheckout {
  var parameters: [String: Any] {
    [
      AnalyticsParameterCoupon: coupon as Any,
      AnalyticsParameterItems: items.map(\.parameters),
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.ViewSearchResults {
  var parameters: [String: Any] {
    [
      AnalyticsParameterSearchTerm: searchTerm as Any
    ]
  }
}

extension Event.CampaignDetails {
  var parameters: [String: Any] {
    [
      AnalyticsParameterSource: source as Any,
      AnalyticsParameterMedium: medium as Any,
      AnalyticsParameterCampaign: campaign as Any,
      AnalyticsParameterTerm: term as Any,
      AnalyticsParameterContent: content as Any,
      AnalyticsParameterAdNetworkClickID: adNetworkClickID as Any,
      AnalyticsParameterCP1: cp1 as Any,
      AnalyticsParameterCampaignID: campaignID as Any,
      AnalyticsParameterCreativeFormat: creativeFormat as Any,
      AnalyticsParameterMarketingTactic: marketingTactic as Any,
      AnalyticsParameterSourcePlatform: sourcePlatform as Any,
    ]
  }
}

extension Event.EarnVirtualCurrency {
  var parameters: [String: Any] {
    [
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.GenerateLead {
  var parameters: [String: Any] {
    [
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.JoinGroup {
  var parameters: [String: Any] {
    [
      AnalyticsParameterGroupID: groupID as Any
    ]
  }
}

extension Event.LevelEnd {
  var parameters: [String: Any] {
    [
      AnalyticsParameterLevelName: levelName as Any,
      AnalyticsParameterSuccess: success as Any,
    ]
  }
}

extension Event.LevelStart {
  var parameters: [String: Any] {
    [
      AnalyticsParameterLevelName: levelName as Any
    ]
  }
}

extension Event.LevelUp {
  var parameters: [String: Any] {
    [
      AnalyticsEventLevelUp: level as Any,
      AnalyticsParameterCharacter: character as Any,
    ]
  }
}

extension Event.PostScore {
  var parameters: [String: Any] {
    [
      AnalyticsParameterScore: score as Any,
      AnalyticsParameterLevel: level as Any,
      AnalyticsParameterCharacter: character as Any,
    ]
  }
}

extension Event.ScreenView {
  var parameters: [String: Any] {
    [
      AnalyticsParameterScreenClass: screenClass as Any,
      AnalyticsParameterScreenName: screenName as Any,
    ]
  }
}

extension Event.Refund {
  var parameters: [String: Any] {
    [
      AnalyticsParameterAffiliation: affiliation as Any,
      AnalyticsParameterCoupon: coupon as Any,
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
      AnalyticsParameterItems: items?.map(\.parameters) as Any,
      AnalyticsParameterShipping: shipping as Any,
      AnalyticsParameterTax: tax as Any,
      AnalyticsParameterTransactionID: transactionID as Any,
    ]
  }
}

extension Event.Purchase {
  var parameters: [String: Any] {
    [
      AnalyticsParameterAffiliation: affiliation as Any,
      AnalyticsParameterCoupon: coupon as Any,
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
      AnalyticsParameterEndDate: endDate as Any,
      AnalyticsParameterItemID: itemID as Any,
      AnalyticsParameterItems: items.map(\.parameters),
      AnalyticsParameterShipping: shipping as Any,
      AnalyticsParameterStartDate: startDate as Any,
      AnalyticsParameterTax: tax as Any,
      AnalyticsParameterTransactionID: transactionID as Any,
    ]
  }
}

extension Event.RemoveFromCart {
  var parameters: [String: Any] {
    [
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.Search {
  var parameters: [String: Any] {
    [
      AnalyticsParameterTerm: term as Any,
      AnalyticsParameterStartDate: startDate as Any,
      AnalyticsParameterEndDate: endDate as Any,
      AnalyticsParameterNumberOfNights: numberOfNights as Any,
      AnalyticsParameterNumberOfRooms: numberOfRooms as Any,
      AnalyticsParameterNumberOfPassengers: numberOfPassengers as Any,
      AnalyticsParameterOrigin: origin as Any,
      AnalyticsParameterDestination: destination as Any,
      AnalyticsParameterTravelClass: travelClass as Any,
    ]
  }
}

extension Event.SelectItem {
  var parameters: [String: Any] {
    [
      AnalyticsParameterItems: items.map(\.parameters),
      AnalyticsParameterItemListID: itemListID as Any,
      AnalyticsParameterItemListName: itemListName as Any,
    ]
  }
}

extension Event.SelectPromotion {
  var parameters: [String: Any] {
    [
      AnalyticsParameterCreativeName: creativeName as Any,
      AnalyticsParameterCreativeSlot: creativeSlot as Any,
      AnalyticsParameterItems: items?.map(\.parameters) as Any,
      AnalyticsParameterLocationID: locationID as Any,
      AnalyticsParameterPromotionID: promotionID as Any,
      AnalyticsParameterPromotionName: promotionName as Any,
    ]
  }
}

extension Event.SelectContent {
  var parameters: [String: Any] {
    [
      AnalyticsParameterContentType: contentType as Any,
      AnalyticsParameterItemID: itemID as Any,
    ]
  }
}

extension Event.Share {
  var parameters: [String: Any] {
    [
      AnalyticsParameterContentType: contentType as Any,
      AnalyticsParameterItemID: itemID as Any,
    ]
  }
}

extension Event.SignUp {
  var parameters: [String: Any] {
    [
      AnalyticsParameterMethod: method as Any
    ]
  }
}

extension Event.SpendVirtualCurrency {
  var parameters: [String: Any] {
    [
      AnalyticsParameterItemName: itemName as Any,
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.UnlockAchievement {
  var parameters: [String: Any] {
    [
      AnalyticsParameterAchievementID: achievementID as Any
    ]
  }
}

extension Event.ViewCart {
  var parameters: [String: Any] {
    [
      AnalyticsParameterItems: items?.map(\.parameters) as Any,
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.ViewItem {
  var parameters: [String: Any] {
    [
      AnalyticsParameterItems: items?.map(\.parameters) as Any,
      AnalyticsParameterValue: value?.amount as Any,
      AnalyticsParameterCurrency: value?.currency as Any,
    ]
  }
}

extension Event.ViewItemList {
  var parameters: [String: Any] {
    [
      AnalyticsParameterItems: items?.map(\.parameters) as Any,
      AnalyticsParameterItemListID: itemListID as Any,
      AnalyticsParameterItemListName: itemListName as Any,
    ]
  }
}

extension Event.ViewPromotion {
  var parameters: [String: Any] {
    [
      AnalyticsParameterCreativeName: creativeName as Any,
      AnalyticsParameterCreativeSlot: creativeSlot as Any,
      AnalyticsParameterItems: items?.map(\.parameters) as Any,
      AnalyticsParameterLocationID: locationID as Any,
      AnalyticsParameterPromotionID: promotionID as Any,
      AnalyticsParameterPromotionName: promotionName as Any,
    ]
  }
}

extension Item {
  var parameters: [String: Any] {
    [
      AnalyticsParameterItemID: id as Any,
      AnalyticsParameterItemName: name as Any,
      AnalyticsParameterItemCategory: category as Any,
      AnalyticsParameterItemVariant: variant as Any,
      AnalyticsParameterItemBrand: brand as Any,
      AnalyticsParameterPrice: price?.amount as Any,
      AnalyticsParameterItemListID: listID as Any,
      AnalyticsParameterItemListName: listName as Any,
    ]
  }
}
