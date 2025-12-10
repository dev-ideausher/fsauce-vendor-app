class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://54.235.14.116:8000/v1/";
  static String mapApiUrl = "https://maps.googleapis.com/maps/api/place/";
  static String placesNewApiUrl = "https://places.googleapis.com/v1/";
  //endpoints
  static const String onboardVendor = "vendor/onboarding";
  static const String fileUpload = "user/uploadFile";

  //subscription endpoints
  static const String getVendorSubscriptionList =
      "vendor/getVendorSubscriptionList";
  static const String addCard = "vendor/addCard";
  static const String vendorSubscription = "vendor/vendorSubscription";
  static const String getSubscriptionPlans = "vendor/getSubscriptionPlans";
  static const String delCard = "vendor/deleteCard?CardId=";
  static const String getCardList = "vendor/getCardList";
  static const String cancelSubscription = "vendor/cancelSubscription";

  //Delete media
  static const String deleteMedia = "vendor/deleteMedia";

  //get features.
  static const String getFeatures = "vendor/getFeatures";
  static const String getCuisine = "vendor/getCuisines";

  //Get Ratings
  static const String getRatings = "vendor/getRatings?";
  static const String deleteRating = "vendor/deleteRating?";

  //Vendor end points
  static const String updateVendor = "vendor/updateVendor";
  static const String getVendor = "vendor/getVendorProfile";
  static const String deleteVendor = "vendor/deleteAccount";

  //Notification end points
  static const String addNotification = "vendor/addNotification";
  static const String getNotification = "vendor/getNotification";
  static const String getVendorNotifications = "vendor/getVendorNotifications";
  static const String deleteNotification = "vendor/deleteNotification";
  static const String editNotification = "vendor/updateNotificationStatus";
  static const String getPrivacyPolicy = "vendor/getPrivacyPolicy";
  static const String getContentPolicy = "vendor/getContentPolicy";
  static const String getTermsAndConditions = "vendor/getTermsAndConditions";
  static const String getFaqList = "vendor/getFaqList";

  //Dashboard end points
  static const String dashboardData = "vendor/DashboardData";

  //Loyalty card end points
  static const String addLoyaltyCard = 'vendor/loyaltycard/addLoyaltycard';
  static const String getLoyaltyCards =
      'vendor/loyaltycard/getLoyaltycardList?';
  static const String editLoyaltyCard = 'vendor/loyaltycard/editLoyaltycard';
  static const String delLoyaltyCard =
      'vendor/loyaltycard/deleteLoyaltyCard?id=';
  static const String getOneLoyaltyCard =
      'vendor/loyaltycard/getOneLoyaltycard?id=';
  static const String scanLoyaltyCard = 'vendor/loyaltycard/scanLoyaltyCard';

  static const String addCategory = "vendor/menu/addCategory";
  static const String getCategory = "vendor/menu/getCategory";
  static const String deleteCategory = "vendor/menu/deleteCategory";
  static const String editCategory = "vendor/menu/editCategory";
  static const String addMenuItem = "vendor/menu/addMenu";
  static const String deleteMenuItem = "vendor/menu/deleteMenu";
  static const String editMenuItem = "vendor/menu/editMenu";
  static const String addJob = "vendor/job/addJob";
  static const String getJobs = "vendor/job/getJobList";
  static const String deleteJob = "vendor/job/deleteJob";
  static const String editJob = "vendor/job/editJob";

  //coupon endpoints
  static const String addCoupon = "vendor/coupon/addCoupon";
  static const String getCouponList = "vendor/coupon/getCouponList?";
  static const String getCoupon = "/vendor/coupon/getOneCoupon?id=";
  static const String editCoupon = "vendor/coupon/editCoupon";
  static const String deleteCoupon = "/vendor/coupon/deleteCoupon?id=";
  static const String redeemCouponCode = "vendor/coupon/redeemCoupon";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
