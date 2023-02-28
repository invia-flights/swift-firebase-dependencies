import Foundation

/// An Event is an important occurrence in your app that you want to measure. You can report up to
/// 500 different types of Events per app and you can associate up to 25 unique parameters with each
/// Event type. Some common events are suggested below, but you may also choose to specify custom
/// Event types that are associated with your specific app. Each event type is identified by a
/// unique name. Event names can be up to 40 characters long, may only contain alphanumeric
/// characters and underscores ("_"), and must start with an alphabetic character. The "firebase_",
/// "google_", and "ga_" prefixes are reserved and should not be used.
public enum Event: Equatable {
  case custom(Custom)

  /// Ad Impression event. This event signifies when a user sees an ad impression. Note: If you
  /// supply
  /// the @c AnalyticsParameterValue parameter, you must also supply the @c
  /// AnalyticsParameterCurrency
  /// parameter so that revenue metrics can be computed accurately.
  case adImpression(AdImpression)

  /// Add Payment Info event. This event signifies that a user has submitted their payment
  /// information. Note: If you supply the @c AnalyticsParameterValue parameter, you must also supply
  /// the @c AnalyticsParameterCurrency parameter so that revenue metrics can be computed accurately.
  case addPaymentInfo(AddPaymentInfo)

  /// Add Shipping Info event. This event signifies that a user has submitted their shipping
  /// information. Note: If you supply the @c AnalyticsParameterValue parameter, you must also supply
  /// the @c AnalyticsParameterCurrency parameter so that revenue metrics can be computed accurately.
  case addShippingInfo(AddShippingInfo)

  /// E-Commerce Add To Cart event. This event signifies that an item(s) was added to a cart for
  /// purchase. Add this event to a funnel with @c AnalyticsEventPurchase to gauge the effectiveness
  /// of your checkout process. Note: If you supply the @c AnalyticsParameterValue parameter, you
  /// must
  /// also supply the @c AnalyticsParameterCurrency parameter so that revenue metrics can be computed
  /// accurately.
  case addToCart(AddToCart)

  /// E-Commerce Add To Wishlist event. This event signifies that an item was added to a wishlist.
  /// Use
  /// this event to identify popular gift items.
  case addToWishList(AddToWishList)

  /// App Open event. By logging this event when an App becomes active, developers can understand how
  /// often users leave and return during the course of a Session. Although Sessions are
  /// automatically
  /// reported, this event can provide further clarification around the continuous engagement of
  /// app-users.
  ///
  case appOpen

  /// E-Commerce Begin Checkout event. This event signifies that a user has begun the process of
  /// checking out. Add this event to a funnel with your @c AnalyticsEventPurchase event to gauge the
  /// effectiveness of your checkout process.
  case beginCheckout(BeginCheckout)

  /// Campaign Detail event. Log this event to supply the referral details of a re-engagement
  /// campaign. Note: you must supply at least one of the required parameters
  /// AnalyticsParameterSource, AnalyticsParameterMedium or AnalyticsParameterCampaign.
  case campaignDetails(CampaignDetails)

  /// Earn Virtual Currency event. This event tracks the awarding of virtual currency in your app.
  /// Log
  /// this along with @c AnalyticsEventSpendVirtualCurrency to better understand your virtual
  /// economy.
  case earnVirtualCurrency(EarnVirtualCurrency)

  /// Generate Lead event. Log this event when a lead has been generated in the app to understand the
  /// efficacy of your install and re-engagement campaigns. Note: If you supply the
  /// @c AnalyticsParameterValue parameter, you must also supply the @c AnalyticsParameterCurrency
  /// parameter so that revenue metrics can be computed accurately.
  case generateLead(GenerateLead)

  /// Join Group event. Log this event when a user joins a group such as a guild, team or family. Use
  /// this event to analyze how popular certain groups or social features are in your app.
  case joinGroup(JoinGroup)

  /// Level End event. Log this event when the user finishes a level.
  case levelEnd(LevelEnd)

  /// Level Start event. Log this event when the user starts a new level.
  case levelStart(LevelStart)
  /// Level Up event. This event signifies that a player has leveled up in your gaming app. It can
  /// help you gauge the level distribution of your userbase and help you identify certain levels
  /// that
  /// are difficult to pass.

  case levelUp(LevelUp)
  /// Login event. Apps with a login feature can report this event to signify that a user has logged
  /// in.
  case login
  /// Post Score event. Log this event when the user posts a score in your gaming app. This event can
  /// help you understand how users are actually performing in your game and it can help you
  /// correlate
  /// high scores with certain audiences or behaviors.
  case postScore(PostScore)

  /// E-Commerce Purchase event. This event signifies that an item(s) was purchased by a user. Note:
  /// This is different from the in-app purchase event, which is reported automatically for App
  /// Store-based apps. Note: If you supply the @c AnalyticsParameterValue parameter, you must also
  /// supply the @c AnalyticsParameterCurrency parameter so that revenue metrics can be computed
  /// accurately.
  case purchase(Purchase)

  /// E-Commerce Refund event. This event signifies that a refund was issued. Note: If you supply the
  /// @c AnalyticsParameterValue parameter, you must also supply the @c AnalyticsParameterCurrency
  /// parameter so that revenue metrics can be computed accurately.
  case refund(Refund)

  /// E-Commerce Remove from Cart event. This event signifies that an item(s) was removed from a
  /// cart.
  /// Note: If you supply the @c AnalyticsParameterValue parameter, you must also supply the @c
  /// AnalyticsParameterCurrency parameter so that revenue metrics can be computed accurately.
  case removeFromCart(RemoveFromCart)

  /// Screen View event. This event signifies a screen view. Use this when a screen transition
  /// occurs.
  /// This event can be logged irrespective of whether automatic screen tracking is enabled.
  case screenView(ScreenView)

  /// Search event. Apps that support search features can use this event to contextualize search
  /// operations by supplying the appropriate, corresponding parameters. This event can help you
  /// identify the most popular content in your app.
  case search(Search)

  /// Select Content event. This general purpose event signifies that a user has selected some
  /// content
  /// of a certain type in an app. The content can be any object in your app. This event can help you
  /// identify popular content and categories of content in your app.
  case selectContent(SelectContent)

  /// Select Item event. This event signifies that an item was selected by a user from a list. Use
  /// the
  /// appropriate parameters to contextualize the event. Use this event to discover the most popular
  /// items selected.
  case selectItem(SelectItem)

  /// Select promotion event. This event signifies that a user has selected a promotion offer. Use
  /// the
  /// appropriate parameters to contextualize the event, such as the item(s) for which the promotion
  /// applies.
  case selectPromotion(SelectPromotion)

  /// Share event. Apps with social features can log the Share event to identify the most viral
  /// content.
  case share(Share)

  /// Sign Up event. This event indicates that a user has signed up for an account in your app. The
  /// parameter signifies the method by which the user signed up. Use this event to understand the
  /// different behaviors between logged in and logged out users.
  case signUp(SignUp)

  /// Spend Virtual Currency event. This event tracks the sale of virtual goods in your app and can
  /// help you identify which virtual goods are the most popular objects of purchase.
  case spendVirtualCurrency(SpendVirtualCurrency)

  /// Tutorial Begin event. This event signifies the start of the on-boarding process in your app.
  /// Use
  /// this in a funnel with @c AnalyticsEventTutorialComplete to understand how many users complete
  /// this process and move on to the full app experience.
  case tutorialBegin

  /// Tutorial End event. Use this event to signify the user's completion of your app's on-boarding
  /// process. Add this to a funnel with @c AnalyticsEventTutorialBegin to gauge the completion rate
  /// of your on-boarding process.
  case tutorialComplete

  /// Unlock Achievement event. Log this event when the user has unlocked an achievement in your
  /// game. Since achievements generally represent the breadth of a gaming experience, this event can
  /// help you understand how many users are experiencing all that your game has to offer.
  case unlockAchievement(UnlockAchievement)

  /// E-commerce View Cart event. This event signifies that a user has viewed their cart. Use this to
  /// analyze your purchase funnel. Note: If you supply the @c AnalyticsParameterValue parameter, you
  /// must also supply the @c AnalyticsParameterCurrency parameter so that revenue metrics can be
  /// computed accurately.
  case viewCart(ViewCart)

  /// View Item event. This event signifies that a user has viewed an item. Use the appropriate
  /// parameters to contextualize the event. Use this event to discover the most popular items viewed
  /// in your app. Note: If you supply the @c AnalyticsParameterValue parameter, you must also supply
  /// the @c AnalyticsParameterCurrency parameter so that revenue metrics can be computed accurately.
  case viewItem(ViewItem)

  /// View Item List event. Log this event when a user sees a list of items or offerings.
  case viewItemList(ViewItemList)

  /// View Promotion event. This event signifies that a promotion was shown to a user. Add this event
  /// to a funnel with the @c AnalyticsEventAddToCart and @c AnalyticsEventPurchase to gauge your
  /// conversion process.
  case viewPromotion(ViewPromotion)

  /// View Search Results event. Log this event when the user has been presented with the results of
  /// a search.
  case viewSearchResults(ViewSearchResults)
}
