import FirebaseAnalytics
import SwiftFirebaseAnalytics

extension FirebaseTracking {
	static var live: Self {
		.init(
			log: { event in
				Analytics.logEvent(event.name, parameters: event.parameters)
			}
		)
	}
}

extension Event {
	var name: String {
		switch self {
		case let .custom(event):
			return event.name
		case .adImpression(_):
			return AnalyticsEventAdImpression
		case .addPaymentInfo(_):
			return AnalyticsEventAddPaymentInfo
		case .addShippingInfo(_):
			return AnalyticsEventAddShippingInfo
		case .addToCart(_):
			return AnalyticsEventAddToCart
		case .addToWishList(_):
			return AnalyticsEventAddToWishlist
		case .appOpen:
			return AnalyticsEventAppOpen
		case .beginCheckout(_):
			return AnalyticsEventBeginCheckout
		case .campaignDetails(_):
			return AnalyticsEventCampaignDetails
		case .earnVirtualCurrency(_):
			return AnalyticsEventEarnVirtualCurrency
		case .generateLead(_):
			return AnalyticsEventGenerateLead
		case .joinGroup(_):
			return AnalyticsEventJoinGroup
		case .levelEnd(_):
			return AnalyticsEventLevelEnd
		case .levelStart(_):
			return AnalyticsEventLevelStart
		case .levelUp(_):
			return AnalyticsEventLevelUp
		case .login:
			return AnalyticsEventLogin
		case .postScore(_):
			return AnalyticsEventPostScore
		case .purchase(_):
			return AnalyticsEventPurchase
		case .refund(_):
			return AnalyticsEventRefund
		case .removeFromCart(_):
			return AnalyticsEventRemoveFromCart
		case .screenView(_):
			return AnalyticsEventScreenView
		case .search(_):
			return AnalyticsEventSearch
		case .selectContent(_):
			return AnalyticsEventSelectContent
		case .selectItem(_):
			return AnalyticsEventSelectItem
		case .selectPromotion(_):
			return AnalyticsEventSelectPromotion
		case .share(_):
			return AnalyticsEventShare
		case .signUp(_):
			return AnalyticsEventSignUp
		case .spendVirtualCurrency(_):
			return AnalyticsEventSpendVirtualCurrency
		case .tutorialBegin:
			return AnalyticsEventTutorialBegin
		case .tutorialComplete:
			return AnalyticsEventTutorialComplete
		case .unlockAchievement(_):
			return AnalyticsEventUnlockAchievement
		case .viewCart(_):
			return AnalyticsEventViewCart
		case .viewItem(_):
			return AnalyticsEventViewItem
		case .viewItemList(_):
			return AnalyticsEventViewItemList
		case .viewPromotion(_):
			return AnalyticsEventViewPromotion
		case .viewSearchResults(_):
			return AnalyticsEventViewSearchResults
		}
	}
}

extension Event {
	var parameters: [String: Any]? {
		switch self {
		case .custom(let custom):
			return custom.parameters
		case .adImpression(let adImpression):
			return adImpression.parameters
		case .addPaymentInfo(let addPaymentInfo):
			return addPaymentInfo.parameters
		case .addShippingInfo(let addShippingInfo):
			return addShippingInfo.parameters
		case .addToCart(let addToCart):
			return addToCart.parameters
		case .addToWishList(let addToWishList):
			return addToWishList.parameters
		case .appOpen:
			return nil
		case .beginCheckout(let beginCheckout):
			return beginCheckout.parameters
		case .campaignDetails(let campaignDetails):
			return campaignDetails.parameters
		case .earnVirtualCurrency(let earnVirtualCurrency):
			return earnVirtualCurrency.parameters
		case .generateLead(let generateLead):
			return generateLead.parameters
		case .joinGroup(let joinGroup):
			return joinGroup.parameters
		case .levelEnd(let levelEnd):
			return levelEnd.parameters
		case .levelStart(let levelStart):
			return levelStart.parameters
		case .levelUp(let levelUp):
			return levelUp.parameters
		case .login:
			return nil
		case .postScore(let postScore):
			return postScore.parameters
		case .purchase(let purchase):
			return purchase.parameters
		case .refund(let refund):
			return refund.parameters
		case .removeFromCart(let removeFromCart):
			return removeFromCart.parameters
		case .screenView(let screenView):
			return screenView.parameters
		case .search(let search):
			return search.parameters
		case .selectContent(let selectContent):
			return selectContent.parameters
		case .selectItem(let selectItem):
			return nil
		case .selectPromotion(let selectPromotion):
			return nil
		case .share(let share):
			return nil
		case .signUp(let signUp):
			return nil
		case .spendVirtualCurrency(let spendVirtualCurrency):
			return nil
		case .tutorialBegin:
			return nil
		case .tutorialComplete:
			return nil
		case .unlockAchievement(let unlockAchievement):
			return nil
		case .viewCart(let viewCart):
			return nil
		case .viewItem(let viewItem):
			return nil
		case .viewItemList(let viewItemList):
			return nil
		case .viewPromotion(let viewPromotion):
			return nil
		case .viewSearchResults(let viewSearchResults):
			return nil
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
			AnalyticsParameterCurrency: value?.currency as Any
		]
	}
}


extension Event.AddPaymentInfo {
	var parameters: [String: Any] {
		[
			AnalyticsParameterCoupon: coupon as Any,
			AnalyticsParameterItems: items as Any,
			AnalyticsParameterPaymentType: paymentType as Any,
			AnalyticsParameterValue: value?.amount as Any,
			AnalyticsParameterCurrency: value?.currency as Any
		]
	}
}

extension Event.AddShippingInfo {
	var parameters: [String: Any] {
		[
			AnalyticsParameterCoupon: coupon as Any,
			AnalyticsParameterItems: items as Any,
			AnalyticsParameterShippingTier: shippingTier as Any,
			AnalyticsParameterValue: value?.amount as Any,
			AnalyticsParameterCurrency: value?.currency as Any
		]
	}
}

extension Event.AddToCart {
	var parameters: [String: Any] {
		[
			AnalyticsParameterItems: items as Any,
			AnalyticsParameterValue: value?.amount as Any,
			AnalyticsParameterCurrency: value?.currency as Any
		]
	}
}

extension Event.AddToWishList {
	var parameters: [String: Any] {
		[
			AnalyticsParameterItems: items as Any,
			AnalyticsParameterValue: value?.amount as Any,
			AnalyticsParameterCurrency: value?.currency as Any
		]
	}
}

extension Event.BeginCheckout {
	var parameters: [String: Any] {
		[
			AnalyticsParameterCoupon: coupon as Any,
			AnalyticsParameterItems: items as Any,
			AnalyticsParameterValue: value?.amount as Any,
			AnalyticsParameterCurrency: value?.currency as Any
		]
	}
}

extension Event.ViewSearchResults {
	var parameters: [String: Any] {
		[
			AnalyticsParameterSearchTerm: searchTerm as Any,
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
			AnalyticsParameterSourcePlatform: sourcePlatform as Any
		]
	}
}

extension Event.EarnVirtualCurrency {
	var parameters: [String: Any] {
		[
			AnalyticsParameterValue: value?.amount as Any,
			AnalyticsParameterCurrency: value?.currency as Any
		]
	}
}

extension Event.GenerateLead {
	var parameters: [String: Any] {
		[
			AnalyticsParameterValue: value?.amount as Any,
			AnalyticsParameterCurrency: value?.currency as Any
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
			AnalyticsParameterSuccess: success as Any
		]
	}
}

extension Event.LevelStart {
	var parameters: [String: Any] {
		[
			AnalyticsParameterLevelName: levelName as Any,
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
			AnalyticsParameterCharacter: character as Any
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
			AnalyticsParameterItems: items as Any,
			AnalyticsParameterShipping: shipping as Any,
			AnalyticsParameterTax: tax as Any,
			AnalyticsParameterTransactionID: transactionID as Any
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
			AnalyticsParameterItems: items as Any,
			AnalyticsParameterShipping: shipping as Any,
			AnalyticsParameterStartDate: startDate as Any,
			AnalyticsParameterTax: tax as Any,
			AnalyticsParameterTransactionID: transactionID as Any
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
			AnalyticsParameterItems: items as Any,
			AnalyticsParameterItemListID: itemListID as Any,
			AnalyticsParameterItemListName: itemListName as Any
		]
	}
}

extension Event.SelectPromotion {
	var parameters: [String: Any] {
		[
			AnalyticsParameterCreativeName: creativeName as Any,
			AnalyticsParameterCreativeSlot: creativeSlot as Any,
			AnalyticsParameterItems: parameterItems as Any,
			AnalyticsParameterLocationID: locationID as Any,
			AnalyticsParameterPromotionID: promotionID as Any,
			AnalyticsParameterPromotionName: promotionName as Any
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
			AnalyticsParameterMethod: method as Any,
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
			AnalyticsParameterAchievementID: achievementID as Any,
		]
	}
}

extension Event.ViewCart {
	var parameters: [String: Any] {
		[
			AnalyticsParameterItems: items as Any,
			AnalyticsParameterValue: value?.amount as Any,
			AnalyticsParameterCurrency: value?.currency as Any,
		]
	}
}

extension Event.ViewItem {
	var parameters: [String: Any] {
		[
			AnalyticsParameterItems: items as Any,
			AnalyticsParameterValue: value?.amount as Any,
			AnalyticsParameterCurrency: value?.currency as Any,
		]
	}
}

extension Event.ViewItemList {
	var parameters: [String: Any] {
		[
			AnalyticsParameterItems: items as Any,
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
			AnalyticsParameterItems: parameterItems as Any,
			AnalyticsParameterLocationID: locationID as Any,
			AnalyticsParameterPromotionID: promotionID as Any,
			AnalyticsParameterPromotionName: promotionName as Any
		]
	}
}
