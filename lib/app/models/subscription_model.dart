import 'dart:convert';

class RestaurantDetails {
  final Position? position;
  final String? id;
  final String? name;
  final String? profilePic;
  final String? email;
  final String? phoneNumber;
  final int? age;
  final String? address;
  final String? city;
  final String? restaurantName;
  final String? restaurantLogo;
  final String? restaurantBanner;
  final String? location;
  final int? avgPrice;
  final String? description;
  final List<Cuisine>? features;
  final List<String>? media;
  final String? role;
  final String? firebaseUid;
  final String? firebaseSignInProvider;
  final bool? isActive;
  final bool? isNewUser;
  final List<Cuisine>? cuisine;
  final int? loyaltyCardCount;
  final bool? isPremium;
  final DateTime? premiumValidityFrom;
  final DateTime? premiumValidityTo;
  final String? premiumType;
  final String? stripeCustomerId;
  final dynamic stripeCardId;
  final List<dynamic>? cards;
  final bool? isDeleted;
  final int? rating;
  final List<Timing>? timing;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final Subscription? subscription;

  RestaurantDetails({
    this.position,
    this.id,
    this.name,
    this.profilePic,
    this.email,
    this.phoneNumber,
    this.age,
    this.address,
    this.city,
    this.restaurantName,
    this.restaurantLogo,
    this.restaurantBanner,
    this.location,
    this.avgPrice,
    this.description,
    this.features,
    this.media,
    this.role,
    this.firebaseUid,
    this.firebaseSignInProvider,
    this.isActive,
    this.isNewUser,
    this.cuisine,
    this.loyaltyCardCount,
    this.isPremium,
    this.premiumValidityFrom,
    this.premiumValidityTo,
    this.premiumType,
    this.stripeCustomerId,
    this.stripeCardId,
    this.cards,
    this.isDeleted,
    this.rating,
    this.timing,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.subscription,
  });

  RestaurantDetails copyWith({
    Position? position,
    String? id,
    String? name,
    String? profilePic,
    String? email,
    String? phoneNumber,
    int? age,
    String? address,
    String? city,
    String? restaurantName,
    String? restaurantLogo,
    String? restaurantBanner,
    String? location,
    int? avgPrice,
    String? description,
    List<Cuisine>? features,
    List<String>? media,
    String? role,
    String? firebaseUid,
    String? firebaseSignInProvider,
    bool? isActive,
    bool? isNewUser,
    List<Cuisine>? cuisine,
    int? loyaltyCardCount,
    bool? isPremium,
    DateTime? premiumValidityFrom,
    DateTime? premiumValidityTo,
    String? premiumType,
    String? stripeCustomerId,
    dynamic stripeCardId,
    List<dynamic>? cards,
    bool? isDeleted,
    int? rating,
    List<Timing>? timing,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    Subscription? subscription,
  }) =>
      RestaurantDetails(
        position: position ?? this.position,
        id: id ?? this.id,
        name: name ?? this.name,
        profilePic: profilePic ?? this.profilePic,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        age: age ?? this.age,
        address: address ?? this.address,
        city: city ?? this.city,
        restaurantName: restaurantName ?? this.restaurantName,
        restaurantLogo: restaurantLogo ?? this.restaurantLogo,
        restaurantBanner: restaurantBanner ?? this.restaurantBanner,
        location: location ?? this.location,
        avgPrice: avgPrice ?? this.avgPrice,
        description: description ?? this.description,
        features: features ?? this.features,
        media: media ?? this.media,
        role: role ?? this.role,
        firebaseUid: firebaseUid ?? this.firebaseUid,
        firebaseSignInProvider:
            firebaseSignInProvider ?? this.firebaseSignInProvider,
        isActive: isActive ?? this.isActive,
        isNewUser: isNewUser ?? this.isNewUser,
        cuisine: cuisine ?? this.cuisine,
        loyaltyCardCount: loyaltyCardCount ?? this.loyaltyCardCount,
        isPremium: isPremium ?? this.isPremium,
        premiumValidityFrom: premiumValidityFrom ?? this.premiumValidityFrom,
        premiumValidityTo: premiumValidityTo ?? this.premiumValidityTo,
        premiumType: premiumType ?? this.premiumType,
        stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
        stripeCardId: stripeCardId ?? this.stripeCardId,
        cards: cards ?? this.cards,
        isDeleted: isDeleted ?? this.isDeleted,
        rating: rating ?? this.rating,
        timing: timing ?? this.timing,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        subscription: subscription ?? this.subscription,
      );

  factory RestaurantDetails.fromRawJson(String str) =>
      RestaurantDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      RestaurantDetails(
        position: json["position"] == null
            ? null
            : Position.fromJson(json["position"]),
        id: json["_id"],
        name: json["name"],
        profilePic: json["profilePic"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        age: json["age"],
        address: json["address"],
        city: json["city"],
        restaurantName: json["restaurantName"],
        restaurantLogo: json["restaurantLogo"],
        restaurantBanner: json["restaurantBanner"],
        location: json["location"],
        avgPrice: json["avgPrice"],
        description: json["description"],
        features: json["features"] == null
            ? []
            : List<Cuisine>.from(
                json["features"]!.map((x) => Cuisine.fromJson(x))),
        media: json["media"] == null
            ? []
            : List<String>.from(json["media"]!.map((x) => x)),
        role: json["role"],
        firebaseUid: json["firebaseUid"],
        firebaseSignInProvider: json["firebaseSignInProvider"],
        isActive: json["isActive"],
        isNewUser: json["isNewUser"],
        cuisine: json["cuisine"] == null
            ? []
            : List<Cuisine>.from(
                json["cuisine"]!.map((x) => Cuisine.fromJson(x))),
        loyaltyCardCount: json["loyaltyCardCount"],
        isPremium: json["isPremium"],
        premiumValidityFrom: json["premiumValidityFrom"] == null
            ? null
            : DateTime.parse(json["premiumValidityFrom"]),
        premiumValidityTo: json["premiumValidityTo"] == null
            ? null
            : DateTime.parse(json["premiumValidityTo"]),
        premiumType: json["premiumType"],
        stripeCustomerId: json["stripeCustomerId"],
        stripeCardId: json["stripeCardId"],
        cards: json["cards"] == null
            ? []
            : List<dynamic>.from(json["cards"]!.map((x) => x)),
        isDeleted: json["isDeleted"],
        rating: json["rating"],
        timing: json["timing"] == null
            ? []
            : List<Timing>.from(json["timing"]!.map((x) => Timing.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        subscription: json["subscription"] == null
            ? null
            : Subscription.fromJson(json["subscription"]),
      );

  Map<String, dynamic> toJson() => {
        "position": position?.toJson(),
        "_id": id,
        "name": name,
        "profilePic": profilePic,
        "email": email,
        "phoneNumber": phoneNumber,
        "age": age,
        "address": address,
        "city": city,
        "restaurantName": restaurantName,
        "restaurantLogo": restaurantLogo,
        "restaurantBanner": restaurantBanner,
        "location": location,
        "avgPrice": avgPrice,
        "description": description,
        "features": features == null
            ? []
            : List<dynamic>.from(features!.map((x) => x.toJson())),
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
        "role": role,
        "firebaseUid": firebaseUid,
        "firebaseSignInProvider": firebaseSignInProvider,
        "isActive": isActive,
        "isNewUser": isNewUser,
        "cuisine": cuisine == null
            ? []
            : List<dynamic>.from(cuisine!.map((x) => x.toJson())),
        "loyaltyCardCount": loyaltyCardCount,
        "isPremium": isPremium,
        "premiumValidityFrom": premiumValidityFrom?.toIso8601String(),
        "premiumValidityTo": premiumValidityTo?.toIso8601String(),
        "premiumType": premiumType,
        "stripeCustomerId": stripeCustomerId,
        "stripeCardId": stripeCardId,
        "cards": cards == null ? [] : List<dynamic>.from(cards!.map((x) => x)),
        "isDeleted": isDeleted,
        "rating": rating,
        "timing": timing == null
            ? []
            : List<dynamic>.from(timing!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "subscription": subscription?.toJson(),
      };
}

class Cuisine {
  final String? id;
  final String? name;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Cuisine({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Cuisine copyWith({
    String? id,
    String? name,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Cuisine(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Cuisine.fromRawJson(String str) => Cuisine.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cuisine.fromJson(Map<String, dynamic> json) => Cuisine(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Position {
  final String? type;
  final List<double>? coordinates;

  Position({
    this.type,
    this.coordinates,
  });

  Position copyWith({
    String? type,
    List<double>? coordinates,
  }) =>
      Position(
        type: type ?? this.type,
        coordinates: coordinates ?? this.coordinates,
      );

  factory Position.fromRawJson(String str) =>
      Position.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class Subscription {
  final String? id;
  final String? vendor;
  final String? subscriptionType;
  final String? plan;
  final DateTime? startDate;
  final DateTime? endDate;
  final StripeSubscriptionObj? stripeSubscriptionObj;
  final bool? isActive;
  final bool? isCancelled;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Subscription({
    this.id,
    this.vendor,
    this.subscriptionType,
    this.plan,
    this.startDate,
    this.endDate,
    this.stripeSubscriptionObj,
    this.isActive,
    this.isCancelled,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Subscription copyWith({
    String? id,
    String? vendor,
    String? subscriptionType,
    String? plan,
    DateTime? startDate,
    DateTime? endDate,
    StripeSubscriptionObj? stripeSubscriptionObj,
    bool? isActive,
    bool? isCancelled,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Subscription(
        id: id ?? this.id,
        vendor: vendor ?? this.vendor,
        subscriptionType: subscriptionType ?? this.subscriptionType,
        plan: plan ?? this.plan,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        stripeSubscriptionObj:
            stripeSubscriptionObj ?? this.stripeSubscriptionObj,
        isActive: isActive ?? this.isActive,
        isCancelled: isCancelled ?? this.isCancelled,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Subscription.fromRawJson(String str) =>
      Subscription.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["_id"],
        vendor: json["vendor"],
        subscriptionType: json["subscriptionType"],
        plan: json["plan"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        stripeSubscriptionObj: json["stripeSubscriptionObj"] == null
            ? null
            : StripeSubscriptionObj.fromJson(json["stripeSubscriptionObj"]),
        isActive: json["isActive"],
        isCancelled: json["isCancelled"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vendor": vendor,
        "subscriptionType": subscriptionType,
        "plan": plan,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "stripeSubscriptionObj": stripeSubscriptionObj?.toJson(),
        "isActive": isActive,
        "isCancelled": isCancelled,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class StripeSubscriptionObj {
  final String? id;
  final String? object;
  final dynamic application;
  final dynamic applicationFeePercent;
  final AutomaticTax? automaticTax;
  final int? billingCycleAnchor;
  final dynamic billingCycleAnchorConfig;
  final BillingMode? billingMode;
  final dynamic billingThresholds;
  final dynamic cancelAt;
  final bool? cancelAtPeriodEnd;
  final dynamic canceledAt;
  final CancellationDetails? cancellationDetails;
  final String? collectionMethod;
  final int? created;
  final String? currency;
  final int? currentPeriodEnd;
  final int? currentPeriodStart;
  final String? customer;
  final dynamic customerAccount;
  final dynamic daysUntilDue;
  final dynamic defaultPaymentMethod;
  final String? defaultSource;
  final List<dynamic>? defaultTaxRates;
  final dynamic description;
  final dynamic discount;
  final List<dynamic>? discounts;
  final dynamic endedAt;
  final InvoiceSettings? invoiceSettings;
  final Items? items;
  final String? latestInvoice;
  final bool? livemode;
  final dynamic nextPendingInvoiceItemInvoice;
  final dynamic onBehalfOf;
  final dynamic pauseCollection;
  final PaymentSettings? paymentSettings;
  final dynamic pendingInvoiceItemInterval;
  final dynamic pendingSetupIntent;
  final dynamic pendingUpdate;
  final Plan? plan;
  final int? quantity;
  final dynamic schedule;
  final int? startDate;
  final String? status;
  final dynamic testClock;
  final dynamic transferData;
  final dynamic trialEnd;
  final TrialSettings? trialSettings;
  final dynamic trialStart;

  StripeSubscriptionObj({
    this.id,
    this.object,
    this.application,
    this.applicationFeePercent,
    this.automaticTax,
    this.billingCycleAnchor,
    this.billingCycleAnchorConfig,
    this.billingMode,
    this.billingThresholds,
    this.cancelAt,
    this.cancelAtPeriodEnd,
    this.canceledAt,
    this.cancellationDetails,
    this.collectionMethod,
    this.created,
    this.currency,
    this.currentPeriodEnd,
    this.currentPeriodStart,
    this.customer,
    this.customerAccount,
    this.daysUntilDue,
    this.defaultPaymentMethod,
    this.defaultSource,
    this.defaultTaxRates,
    this.description,
    this.discount,
    this.discounts,
    this.endedAt,
    this.invoiceSettings,
    this.items,
    this.latestInvoice,
    this.livemode,
    this.nextPendingInvoiceItemInvoice,
    this.onBehalfOf,
    this.pauseCollection,
    this.paymentSettings,
    this.pendingInvoiceItemInterval,
    this.pendingSetupIntent,
    this.pendingUpdate,
    this.plan,
    this.quantity,
    this.schedule,
    this.startDate,
    this.status,
    this.testClock,
    this.transferData,
    this.trialEnd,
    this.trialSettings,
    this.trialStart,
  });

  StripeSubscriptionObj copyWith({
    String? id,
    String? object,
    dynamic application,
    dynamic applicationFeePercent,
    AutomaticTax? automaticTax,
    int? billingCycleAnchor,
    dynamic billingCycleAnchorConfig,
    BillingMode? billingMode,
    dynamic billingThresholds,
    dynamic cancelAt,
    bool? cancelAtPeriodEnd,
    dynamic canceledAt,
    CancellationDetails? cancellationDetails,
    String? collectionMethod,
    int? created,
    String? currency,
    int? currentPeriodEnd,
    int? currentPeriodStart,
    String? customer,
    dynamic customerAccount,
    dynamic daysUntilDue,
    dynamic defaultPaymentMethod,
    String? defaultSource,
    List<dynamic>? defaultTaxRates,
    dynamic description,
    dynamic discount,
    List<dynamic>? discounts,
    dynamic endedAt,
    InvoiceSettings? invoiceSettings,
    Items? items,
    String? latestInvoice,
    bool? livemode,
    dynamic nextPendingInvoiceItemInvoice,
    dynamic onBehalfOf,
    dynamic pauseCollection,
    PaymentSettings? paymentSettings,
    dynamic pendingInvoiceItemInterval,
    dynamic pendingSetupIntent,
    dynamic pendingUpdate,
    Plan? plan,
    int? quantity,
    dynamic schedule,
    int? startDate,
    String? status,
    dynamic testClock,
    dynamic transferData,
    dynamic trialEnd,
    TrialSettings? trialSettings,
    dynamic trialStart,
  }) =>
      StripeSubscriptionObj(
        id: id ?? this.id,
        object: object ?? this.object,
        application: application ?? this.application,
        applicationFeePercent:
            applicationFeePercent ?? this.applicationFeePercent,
        automaticTax: automaticTax ?? this.automaticTax,
        billingCycleAnchor: billingCycleAnchor ?? this.billingCycleAnchor,
        billingCycleAnchorConfig:
            billingCycleAnchorConfig ?? this.billingCycleAnchorConfig,
        billingMode: billingMode ?? this.billingMode,
        billingThresholds: billingThresholds ?? this.billingThresholds,
        cancelAt: cancelAt ?? this.cancelAt,
        cancelAtPeriodEnd: cancelAtPeriodEnd ?? this.cancelAtPeriodEnd,
        canceledAt: canceledAt ?? this.canceledAt,
        cancellationDetails: cancellationDetails ?? this.cancellationDetails,
        collectionMethod: collectionMethod ?? this.collectionMethod,
        created: created ?? this.created,
        currency: currency ?? this.currency,
        currentPeriodEnd: currentPeriodEnd ?? this.currentPeriodEnd,
        currentPeriodStart: currentPeriodStart ?? this.currentPeriodStart,
        customer: customer ?? this.customer,
        customerAccount: customerAccount ?? this.customerAccount,
        daysUntilDue: daysUntilDue ?? this.daysUntilDue,
        defaultPaymentMethod: defaultPaymentMethod ?? this.defaultPaymentMethod,
        defaultSource: defaultSource ?? this.defaultSource,
        defaultTaxRates: defaultTaxRates ?? this.defaultTaxRates,
        description: description ?? this.description,
        discount: discount ?? this.discount,
        discounts: discounts ?? this.discounts,
        endedAt: endedAt ?? this.endedAt,
        invoiceSettings: invoiceSettings ?? this.invoiceSettings,
        items: items ?? this.items,
        latestInvoice: latestInvoice ?? this.latestInvoice,
        livemode: livemode ?? this.livemode,
        nextPendingInvoiceItemInvoice:
            nextPendingInvoiceItemInvoice ?? this.nextPendingInvoiceItemInvoice,
        onBehalfOf: onBehalfOf ?? this.onBehalfOf,
        pauseCollection: pauseCollection ?? this.pauseCollection,
        paymentSettings: paymentSettings ?? this.paymentSettings,
        pendingInvoiceItemInterval:
            pendingInvoiceItemInterval ?? this.pendingInvoiceItemInterval,
        pendingSetupIntent: pendingSetupIntent ?? this.pendingSetupIntent,
        pendingUpdate: pendingUpdate ?? this.pendingUpdate,
        plan: plan ?? this.plan,
        quantity: quantity ?? this.quantity,
        schedule: schedule ?? this.schedule,
        startDate: startDate ?? this.startDate,
        status: status ?? this.status,
        testClock: testClock ?? this.testClock,
        transferData: transferData ?? this.transferData,
        trialEnd: trialEnd ?? this.trialEnd,
        trialSettings: trialSettings ?? this.trialSettings,
        trialStart: trialStart ?? this.trialStart,
      );

  factory StripeSubscriptionObj.fromRawJson(String str) =>
      StripeSubscriptionObj.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StripeSubscriptionObj.fromJson(Map<String, dynamic> json) =>
      StripeSubscriptionObj(
        id: json["id"],
        object: json["object"],
        application: json["application"],
        applicationFeePercent: json["application_fee_percent"],
        automaticTax: json["automatic_tax"] == null
            ? null
            : AutomaticTax.fromJson(json["automatic_tax"]),
        billingCycleAnchor: json["billing_cycle_anchor"],
        billingCycleAnchorConfig: json["billing_cycle_anchor_config"],
        billingMode: json["billing_mode"] == null
            ? null
            : BillingMode.fromJson(json["billing_mode"]),
        billingThresholds: json["billing_thresholds"],
        cancelAt: json["cancel_at"],
        cancelAtPeriodEnd: json["cancel_at_period_end"],
        canceledAt: json["canceled_at"],
        cancellationDetails: json["cancellation_details"] == null
            ? null
            : CancellationDetails.fromJson(json["cancellation_details"]),
        collectionMethod: json["collection_method"],
        created: json["created"],
        currency: json["currency"],
        currentPeriodEnd: json["current_period_end"],
        currentPeriodStart: json["current_period_start"],
        customer: json["customer"],
        customerAccount: json["customer_account"],
        daysUntilDue: json["days_until_due"],
        defaultPaymentMethod: json["default_payment_method"],
        defaultSource: json["default_source"],
        defaultTaxRates: json["default_tax_rates"] == null
            ? []
            : List<dynamic>.from(json["default_tax_rates"]!.map((x) => x)),
        description: json["description"],
        discount: json["discount"],
        discounts: json["discounts"] == null
            ? []
            : List<dynamic>.from(json["discounts"]!.map((x) => x)),
        endedAt: json["ended_at"],
        invoiceSettings: json["invoice_settings"] == null
            ? null
            : InvoiceSettings.fromJson(json["invoice_settings"]),
        items: json["items"] == null ? null : Items.fromJson(json["items"]),
        latestInvoice: json["latest_invoice"],
        livemode: json["livemode"],
        nextPendingInvoiceItemInvoice:
            json["next_pending_invoice_item_invoice"],
        onBehalfOf: json["on_behalf_of"],
        pauseCollection: json["pause_collection"],
        paymentSettings: json["payment_settings"] == null
            ? null
            : PaymentSettings.fromJson(json["payment_settings"]),
        pendingInvoiceItemInterval: json["pending_invoice_item_interval"],
        pendingSetupIntent: json["pending_setup_intent"],
        pendingUpdate: json["pending_update"],
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        quantity: json["quantity"],
        schedule: json["schedule"],
        startDate: json["start_date"],
        status: json["status"],
        testClock: json["test_clock"],
        transferData: json["transfer_data"],
        trialEnd: json["trial_end"],
        trialSettings: json["trial_settings"] == null
            ? null
            : TrialSettings.fromJson(json["trial_settings"]),
        trialStart: json["trial_start"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "application": application,
        "application_fee_percent": applicationFeePercent,
        "automatic_tax": automaticTax?.toJson(),
        "billing_cycle_anchor": billingCycleAnchor,
        "billing_cycle_anchor_config": billingCycleAnchorConfig,
        "billing_mode": billingMode?.toJson(),
        "billing_thresholds": billingThresholds,
        "cancel_at": cancelAt,
        "cancel_at_period_end": cancelAtPeriodEnd,
        "canceled_at": canceledAt,
        "cancellation_details": cancellationDetails?.toJson(),
        "collection_method": collectionMethod,
        "created": created,
        "currency": currency,
        "current_period_end": currentPeriodEnd,
        "current_period_start": currentPeriodStart,
        "customer": customer,
        "customer_account": customerAccount,
        "days_until_due": daysUntilDue,
        "default_payment_method": defaultPaymentMethod,
        "default_source": defaultSource,
        "default_tax_rates": defaultTaxRates == null
            ? []
            : List<dynamic>.from(defaultTaxRates!.map((x) => x)),
        "description": description,
        "discount": discount,
        "discounts": discounts == null
            ? []
            : List<dynamic>.from(discounts!.map((x) => x)),
        "ended_at": endedAt,
        "invoice_settings": invoiceSettings?.toJson(),
        "items": items?.toJson(),
        "latest_invoice": latestInvoice,
        "livemode": livemode,
        "next_pending_invoice_item_invoice": nextPendingInvoiceItemInvoice,
        "on_behalf_of": onBehalfOf,
        "pause_collection": pauseCollection,
        "payment_settings": paymentSettings?.toJson(),
        "pending_invoice_item_interval": pendingInvoiceItemInterval,
        "pending_setup_intent": pendingSetupIntent,
        "pending_update": pendingUpdate,
        "plan": plan?.toJson(),
        "quantity": quantity,
        "schedule": schedule,
        "start_date": startDate,
        "status": status,
        "test_clock": testClock,
        "transfer_data": transferData,
        "trial_end": trialEnd,
        "trial_settings": trialSettings?.toJson(),
        "trial_start": trialStart,
      };
}

class AutomaticTax {
  final dynamic disabledReason;
  final bool? enabled;
  final dynamic liability;

  AutomaticTax({
    this.disabledReason,
    this.enabled,
    this.liability,
  });

  AutomaticTax copyWith({
    dynamic disabledReason,
    bool? enabled,
    dynamic liability,
  }) =>
      AutomaticTax(
        disabledReason: disabledReason ?? this.disabledReason,
        enabled: enabled ?? this.enabled,
        liability: liability ?? this.liability,
      );

  factory AutomaticTax.fromRawJson(String str) =>
      AutomaticTax.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AutomaticTax.fromJson(Map<String, dynamic> json) => AutomaticTax(
        disabledReason: json["disabled_reason"],
        enabled: json["enabled"],
        liability: json["liability"],
      );

  Map<String, dynamic> toJson() => {
        "disabled_reason": disabledReason,
        "enabled": enabled,
        "liability": liability,
      };
}

class BillingMode {
  final dynamic flexible;
  final String? type;

  BillingMode({
    this.flexible,
    this.type,
  });

  BillingMode copyWith({
    dynamic flexible,
    String? type,
  }) =>
      BillingMode(
        flexible: flexible ?? this.flexible,
        type: type ?? this.type,
      );

  factory BillingMode.fromRawJson(String str) =>
      BillingMode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillingMode.fromJson(Map<String, dynamic> json) => BillingMode(
        flexible: json["flexible"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "flexible": flexible,
        "type": type,
      };
}

class CancellationDetails {
  final dynamic comment;
  final dynamic feedback;
  final dynamic reason;

  CancellationDetails({
    this.comment,
    this.feedback,
    this.reason,
  });

  CancellationDetails copyWith({
    dynamic comment,
    dynamic feedback,
    dynamic reason,
  }) =>
      CancellationDetails(
        comment: comment ?? this.comment,
        feedback: feedback ?? this.feedback,
        reason: reason ?? this.reason,
      );

  factory CancellationDetails.fromRawJson(String str) =>
      CancellationDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CancellationDetails.fromJson(Map<String, dynamic> json) =>
      CancellationDetails(
        comment: json["comment"],
        feedback: json["feedback"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "feedback": feedback,
        "reason": reason,
      };
}

class InvoiceSettings {
  final dynamic accountTaxIds;
  final Issuer? issuer;

  InvoiceSettings({
    this.accountTaxIds,
    this.issuer,
  });

  InvoiceSettings copyWith({
    dynamic accountTaxIds,
    Issuer? issuer,
  }) =>
      InvoiceSettings(
        accountTaxIds: accountTaxIds ?? this.accountTaxIds,
        issuer: issuer ?? this.issuer,
      );

  factory InvoiceSettings.fromRawJson(String str) =>
      InvoiceSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceSettings.fromJson(Map<String, dynamic> json) =>
      InvoiceSettings(
        accountTaxIds: json["account_tax_ids"],
        issuer: json["issuer"] == null ? null : Issuer.fromJson(json["issuer"]),
      );

  Map<String, dynamic> toJson() => {
        "account_tax_ids": accountTaxIds,
        "issuer": issuer?.toJson(),
      };
}

class Issuer {
  final String? type;

  Issuer({
    this.type,
  });

  Issuer copyWith({
    String? type,
  }) =>
      Issuer(
        type: type ?? this.type,
      );

  factory Issuer.fromRawJson(String str) => Issuer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}

class Items {
  final String? object;
  final List<Datum>? data;
  final bool? hasMore;
  final int? totalCount;
  final String? url;

  Items({
    this.object,
    this.data,
    this.hasMore,
    this.totalCount,
    this.url,
  });

  Items copyWith({
    String? object,
    List<Datum>? data,
    bool? hasMore,
    int? totalCount,
    String? url,
  }) =>
      Items(
        object: object ?? this.object,
        data: data ?? this.data,
        hasMore: hasMore ?? this.hasMore,
        totalCount: totalCount ?? this.totalCount,
        url: url ?? this.url,
      );

  factory Items.fromRawJson(String str) => Items.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        object: json["object"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        hasMore: json["has_more"],
        totalCount: json["total_count"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "has_more": hasMore,
        "total_count": totalCount,
        "url": url,
      };
}

class Datum {
  final String? id;
  final String? object;
  final dynamic billingThresholds;
  final int? created;
  final int? currentPeriodEnd;
  final int? currentPeriodStart;
  final List<dynamic>? discounts;
  final Plan? plan;
  final Price? price;
  final int? quantity;
  final String? subscription;
  final List<dynamic>? taxRates;

  Datum({
    this.id,
    this.object,
    this.billingThresholds,
    this.created,
    this.currentPeriodEnd,
    this.currentPeriodStart,
    this.discounts,
    this.plan,
    this.price,
    this.quantity,
    this.subscription,
    this.taxRates,
  });

  Datum copyWith({
    String? id,
    String? object,
    dynamic billingThresholds,
    int? created,
    int? currentPeriodEnd,
    int? currentPeriodStart,
    List<dynamic>? discounts,
    Plan? plan,
    Price? price,
    int? quantity,
    String? subscription,
    List<dynamic>? taxRates,
  }) =>
      Datum(
        id: id ?? this.id,
        object: object ?? this.object,
        billingThresholds: billingThresholds ?? this.billingThresholds,
        created: created ?? this.created,
        currentPeriodEnd: currentPeriodEnd ?? this.currentPeriodEnd,
        currentPeriodStart: currentPeriodStart ?? this.currentPeriodStart,
        discounts: discounts ?? this.discounts,
        plan: plan ?? this.plan,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        subscription: subscription ?? this.subscription,
        taxRates: taxRates ?? this.taxRates,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        object: json["object"],
        billingThresholds: json["billing_thresholds"],
        created: json["created"],
        currentPeriodEnd: json["current_period_end"],
        currentPeriodStart: json["current_period_start"],
        discounts: json["discounts"] == null
            ? []
            : List<dynamic>.from(json["discounts"]!.map((x) => x)),
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        quantity: json["quantity"],
        subscription: json["subscription"],
        taxRates: json["tax_rates"] == null
            ? []
            : List<dynamic>.from(json["tax_rates"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "billing_thresholds": billingThresholds,
        "created": created,
        "current_period_end": currentPeriodEnd,
        "current_period_start": currentPeriodStart,
        "discounts": discounts == null
            ? []
            : List<dynamic>.from(discounts!.map((x) => x)),
        "plan": plan?.toJson(),
        "price": price?.toJson(),
        "quantity": quantity,
        "subscription": subscription,
        "tax_rates":
            taxRates == null ? [] : List<dynamic>.from(taxRates!.map((x) => x)),
      };
}

class Plan {
  final String? id;
  final String? object;
  final bool? active;
  final dynamic aggregateUsage;
  final int? amount;
  final String? amountDecimal;
  final String? billingScheme;
  final int? created;
  final String? currency;
  final String? interval;
  final int? intervalCount;
  final bool? livemode;
  final dynamic meter;
  final dynamic nickname;
  final String? product;
  final dynamic tiersMode;
  final dynamic transformUsage;
  final dynamic trialPeriodDays;
  final String? usageType;

  Plan({
    this.id,
    this.object,
    this.active,
    this.aggregateUsage,
    this.amount,
    this.amountDecimal,
    this.billingScheme,
    this.created,
    this.currency,
    this.interval,
    this.intervalCount,
    this.livemode,
    this.meter,
    this.nickname,
    this.product,
    this.tiersMode,
    this.transformUsage,
    this.trialPeriodDays,
    this.usageType,
  });

  Plan copyWith({
    String? id,
    String? object,
    bool? active,
    dynamic aggregateUsage,
    int? amount,
    String? amountDecimal,
    String? billingScheme,
    int? created,
    String? currency,
    String? interval,
    int? intervalCount,
    bool? livemode,
    dynamic meter,
    dynamic nickname,
    String? product,
    dynamic tiersMode,
    dynamic transformUsage,
    dynamic trialPeriodDays,
    String? usageType,
  }) =>
      Plan(
        id: id ?? this.id,
        object: object ?? this.object,
        active: active ?? this.active,
        aggregateUsage: aggregateUsage ?? this.aggregateUsage,
        amount: amount ?? this.amount,
        amountDecimal: amountDecimal ?? this.amountDecimal,
        billingScheme: billingScheme ?? this.billingScheme,
        created: created ?? this.created,
        currency: currency ?? this.currency,
        interval: interval ?? this.interval,
        intervalCount: intervalCount ?? this.intervalCount,
        livemode: livemode ?? this.livemode,
        meter: meter ?? this.meter,
        nickname: nickname ?? this.nickname,
        product: product ?? this.product,
        tiersMode: tiersMode ?? this.tiersMode,
        transformUsage: transformUsage ?? this.transformUsage,
        trialPeriodDays: trialPeriodDays ?? this.trialPeriodDays,
        usageType: usageType ?? this.usageType,
      );

  factory Plan.fromRawJson(String str) => Plan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        object: json["object"],
        active: json["active"],
        aggregateUsage: json["aggregate_usage"],
        amount: json["amount"],
        amountDecimal: json["amount_decimal"],
        billingScheme: json["billing_scheme"],
        created: json["created"],
        currency: json["currency"],
        interval: json["interval"],
        intervalCount: json["interval_count"],
        livemode: json["livemode"],
        meter: json["meter"],
        nickname: json["nickname"],
        product: json["product"],
        tiersMode: json["tiers_mode"],
        transformUsage: json["transform_usage"],
        trialPeriodDays: json["trial_period_days"],
        usageType: json["usage_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "active": active,
        "aggregate_usage": aggregateUsage,
        "amount": amount,
        "amount_decimal": amountDecimal,
        "billing_scheme": billingScheme,
        "created": created,
        "currency": currency,
        "interval": interval,
        "interval_count": intervalCount,
        "livemode": livemode,
        "meter": meter,
        "nickname": nickname,
        "product": product,
        "tiers_mode": tiersMode,
        "transform_usage": transformUsage,
        "trial_period_days": trialPeriodDays,
        "usage_type": usageType,
      };
}

class Price {
  final String? id;
  final String? object;
  final bool? active;
  final String? billingScheme;
  final int? created;
  final String? currency;
  final dynamic customUnitAmount;
  final bool? livemode;
  final dynamic lookupKey;
  final dynamic nickname;
  final String? product;
  final Recurring? recurring;
  final String? taxBehavior;
  final dynamic tiersMode;
  final dynamic transformQuantity;
  final String? type;
  final int? unitAmount;
  final String? unitAmountDecimal;

  Price({
    this.id,
    this.object,
    this.active,
    this.billingScheme,
    this.created,
    this.currency,
    this.customUnitAmount,
    this.livemode,
    this.lookupKey,
    this.nickname,
    this.product,
    this.recurring,
    this.taxBehavior,
    this.tiersMode,
    this.transformQuantity,
    this.type,
    this.unitAmount,
    this.unitAmountDecimal,
  });

  Price copyWith({
    String? id,
    String? object,
    bool? active,
    String? billingScheme,
    int? created,
    String? currency,
    dynamic customUnitAmount,
    bool? livemode,
    dynamic lookupKey,
    dynamic nickname,
    String? product,
    Recurring? recurring,
    String? taxBehavior,
    dynamic tiersMode,
    dynamic transformQuantity,
    String? type,
    int? unitAmount,
    String? unitAmountDecimal,
  }) =>
      Price(
        id: id ?? this.id,
        object: object ?? this.object,
        active: active ?? this.active,
        billingScheme: billingScheme ?? this.billingScheme,
        created: created ?? this.created,
        currency: currency ?? this.currency,
        customUnitAmount: customUnitAmount ?? this.customUnitAmount,
        livemode: livemode ?? this.livemode,
        lookupKey: lookupKey ?? this.lookupKey,
        nickname: nickname ?? this.nickname,
        product: product ?? this.product,
        recurring: recurring ?? this.recurring,
        taxBehavior: taxBehavior ?? this.taxBehavior,
        tiersMode: tiersMode ?? this.tiersMode,
        transformQuantity: transformQuantity ?? this.transformQuantity,
        type: type ?? this.type,
        unitAmount: unitAmount ?? this.unitAmount,
        unitAmountDecimal: unitAmountDecimal ?? this.unitAmountDecimal,
      );

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"],
        object: json["object"],
        active: json["active"],
        billingScheme: json["billing_scheme"],
        created: json["created"],
        currency: json["currency"],
        customUnitAmount: json["custom_unit_amount"],
        livemode: json["livemode"],
        lookupKey: json["lookup_key"],
        nickname: json["nickname"],
        product: json["product"],
        recurring: json["recurring"] == null
            ? null
            : Recurring.fromJson(json["recurring"]),
        taxBehavior: json["tax_behavior"],
        tiersMode: json["tiers_mode"],
        transformQuantity: json["transform_quantity"],
        type: json["type"],
        unitAmount: json["unit_amount"],
        unitAmountDecimal: json["unit_amount_decimal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "active": active,
        "billing_scheme": billingScheme,
        "created": created,
        "currency": currency,
        "custom_unit_amount": customUnitAmount,
        "livemode": livemode,
        "lookup_key": lookupKey,
        "nickname": nickname,
        "product": product,
        "recurring": recurring?.toJson(),
        "tax_behavior": taxBehavior,
        "tiers_mode": tiersMode,
        "transform_quantity": transformQuantity,
        "type": type,
        "unit_amount": unitAmount,
        "unit_amount_decimal": unitAmountDecimal,
      };
}

class Recurring {
  final dynamic aggregateUsage;
  final String? interval;
  final int? intervalCount;
  final dynamic meter;
  final dynamic trialPeriodDays;
  final String? usageType;

  Recurring({
    this.aggregateUsage,
    this.interval,
    this.intervalCount,
    this.meter,
    this.trialPeriodDays,
    this.usageType,
  });

  Recurring copyWith({
    dynamic aggregateUsage,
    String? interval,
    int? intervalCount,
    dynamic meter,
    dynamic trialPeriodDays,
    String? usageType,
  }) =>
      Recurring(
        aggregateUsage: aggregateUsage ?? this.aggregateUsage,
        interval: interval ?? this.interval,
        intervalCount: intervalCount ?? this.intervalCount,
        meter: meter ?? this.meter,
        trialPeriodDays: trialPeriodDays ?? this.trialPeriodDays,
        usageType: usageType ?? this.usageType,
      );

  factory Recurring.fromRawJson(String str) =>
      Recurring.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Recurring.fromJson(Map<String, dynamic> json) => Recurring(
        aggregateUsage: json["aggregate_usage"],
        interval: json["interval"],
        intervalCount: json["interval_count"],
        meter: json["meter"],
        trialPeriodDays: json["trial_period_days"],
        usageType: json["usage_type"],
      );

  Map<String, dynamic> toJson() => {
        "aggregate_usage": aggregateUsage,
        "interval": interval,
        "interval_count": intervalCount,
        "meter": meter,
        "trial_period_days": trialPeriodDays,
        "usage_type": usageType,
      };
}

class PaymentSettings {
  final dynamic paymentMethodOptions;
  final dynamic paymentMethodTypes;
  final String? saveDefaultPaymentMethod;

  PaymentSettings({
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.saveDefaultPaymentMethod,
  });

  PaymentSettings copyWith({
    dynamic paymentMethodOptions,
    dynamic paymentMethodTypes,
    String? saveDefaultPaymentMethod,
  }) =>
      PaymentSettings(
        paymentMethodOptions: paymentMethodOptions ?? this.paymentMethodOptions,
        paymentMethodTypes: paymentMethodTypes ?? this.paymentMethodTypes,
        saveDefaultPaymentMethod:
            saveDefaultPaymentMethod ?? this.saveDefaultPaymentMethod,
      );

  factory PaymentSettings.fromRawJson(String str) =>
      PaymentSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentSettings.fromJson(Map<String, dynamic> json) =>
      PaymentSettings(
        paymentMethodOptions: json["payment_method_options"],
        paymentMethodTypes: json["payment_method_types"],
        saveDefaultPaymentMethod: json["save_default_payment_method"],
      );

  Map<String, dynamic> toJson() => {
        "payment_method_options": paymentMethodOptions,
        "payment_method_types": paymentMethodTypes,
        "save_default_payment_method": saveDefaultPaymentMethod,
      };
}

class TrialSettings {
  final EndBehavior? endBehavior;

  TrialSettings({
    this.endBehavior,
  });

  TrialSettings copyWith({
    EndBehavior? endBehavior,
  }) =>
      TrialSettings(
        endBehavior: endBehavior ?? this.endBehavior,
      );

  factory TrialSettings.fromRawJson(String str) =>
      TrialSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TrialSettings.fromJson(Map<String, dynamic> json) => TrialSettings(
        endBehavior: json["end_behavior"] == null
            ? null
            : EndBehavior.fromJson(json["end_behavior"]),
      );

  Map<String, dynamic> toJson() => {
        "end_behavior": endBehavior?.toJson(),
      };
}

class EndBehavior {
  final String? missingPaymentMethod;

  EndBehavior({
    this.missingPaymentMethod,
  });

  EndBehavior copyWith({
    String? missingPaymentMethod,
  }) =>
      EndBehavior(
        missingPaymentMethod: missingPaymentMethod ?? this.missingPaymentMethod,
      );

  factory EndBehavior.fromRawJson(String str) =>
      EndBehavior.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EndBehavior.fromJson(Map<String, dynamic> json) => EndBehavior(
        missingPaymentMethod: json["missing_payment_method"],
      );

  Map<String, dynamic> toJson() => {
        "missing_payment_method": missingPaymentMethod,
      };
}

class Timing {
  final String? day;
  final String? startTime;
  final String? closeTime;
  final bool? isActive;
  final String? id;

  Timing({
    this.day,
    this.startTime,
    this.closeTime,
    this.isActive,
    this.id,
  });

  Timing copyWith({
    String? day,
    String? startTime,
    String? closeTime,
    bool? isActive,
    String? id,
  }) =>
      Timing(
        day: day ?? this.day,
        startTime: startTime ?? this.startTime,
        closeTime: closeTime ?? this.closeTime,
        isActive: isActive ?? this.isActive,
        id: id ?? this.id,
      );

  factory Timing.fromRawJson(String str) => Timing.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
        day: json["day"],
        startTime: json["startTime"],
        closeTime: json["closeTime"],
        isActive: json["isActive"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "startTime": startTime,
        "closeTime": closeTime,
        "isActive": isActive,
        "_id": id,
      };
}
