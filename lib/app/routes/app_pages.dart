import 'package:fsauce_vendor_app/app/modules/qrScan/views/redeem_coupon_code.dart';
import 'package:fsauce_vendor_app/app/modules/splash/view/splash_view.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/bindings/subscription_binding.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/views/card_details_view.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/views/payment_methods_view.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/views/purchase_plan_view.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/views/subscription_view.dart';
import 'package:get/get.dart';

import '../modules/addItemDetails/bindings/add_item_details_binding.dart';
import '../modules/addItemDetails/views/add_item_details_view.dart';
import '../modules/allPhotosAndVideos/bindings/all_photos_and_videos_binding.dart';
import '../modules/allPhotosAndVideos/views/all_photos_and_videos_view.dart';
import '../modules/changePassword/bindings/change_password_binding.dart';
import '../modules/changePassword/views/change_password_view.dart';
import '../modules/changePassword/views/verify_account_view.dart';
import '../modules/changePasswordProfile/bindings/change_password_profile_binding.dart';
import '../modules/changePasswordProfile/views/change_password_profile_view.dart';
import '../modules/createOrEditVipOffer/bindings/create_or_edit_vip_offer_binding.dart';
import '../modules/createOrEditVipOffer/views/create_or_edit_vip_offer_view.dart';
import '../modules/createPushNotification/bindings/create_push_notification_binding.dart';
import '../modules/createPushNotification/views/create_push_notification_view.dart';
import '../modules/editResturantDetails/bindings/edit_resturant_details_binding.dart';
import '../modules/editResturantDetails/views/edit_resturant_details_view.dart';
import '../modules/enableLocation/bindings/enable_location_binding.dart';
import '../modules/enableLocation/views/enable_location_view.dart';
import '../modules/featuresAndTimings/bindings/features_and_timings_binding.dart';
import '../modules/featuresAndTimings/views/features_and_timings_view.dart';
import '../modules/helpAndSupportScreen/bindings/help_and_support_screen_binding.dart';
import '../modules/helpAndSupportScreen/views/help_and_support_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/jobEditOrAdd/bindings/job_edit_or_add_binding.dart';
import '../modules/jobEditOrAdd/views/job_edit_or_add_view.dart';
import '../modules/jobs/bindings/jobs_binding.dart';
import '../modules/jobs/views/jobs_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/loyalty/bindings/loyalty_binding.dart';
import '../modules/loyalty/views/loyalty_view.dart';
import '../modules/loyaltyCardPreview/bindings/loyalty_card_preview_binding.dart';
import '../modules/loyaltyCardPreview/views/loyalty_card_preview_view.dart';
import '../modules/loyaltyCards/bindings/loyalty_cards_binding.dart';
import '../modules/loyaltyCards/views/loyalty_cards_view.dart';
import '../modules/menuPage/bindings/menu_page_binding.dart';
import '../modules/menuPage/views/menu_page_view.dart';
import '../modules/navBar/bindings/nav_bar_binding.dart';
import '../modules/navBar/views/nav_bar_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profileDetails/bindings/profile_details_binding.dart';
import '../modules/profileDetails/views/profile_details_view.dart';
import '../modules/profileSetup/bindings/profile_setup_binding.dart';
import '../modules/profileSetup/views/profile_setup_view.dart';
import '../modules/pushNotification/bindings/push_notification_binding.dart';
import '../modules/pushNotification/views/push_notification_view.dart';
import '../modules/qrScan/bindings/qr_scan_binding.dart';
import '../modules/qrScan/views/qr_scan_view.dart';
import '../modules/ratingAndFeedbackManagement/bindings/rating_and_feedback_management_binding.dart';
import '../modules/ratingAndFeedbackManagement/views/rating_and_feedback_management_view.dart';
import '../modules/scanHistory/bindings/scan_history_binding.dart';
import '../modules/scanHistory/views/scan_history_view.dart';
import '../modules/scanRedemptionRecord/bindings/scan_redemption_record_binding.dart';
import '../modules/scanRedemptionRecord/views/scan_redemption_record_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/signup/views/terms_conditions_view.dart';
import '../modules/splash/binding/splash_binding.dart';
import '../modules/verification/bindings/verification_binding.dart';
import '../modules/verification/views/verification_view.dart';
import '../modules/vipOffers/bindings/vip_offers_binding.dart';
import '../modules/vipOffers/views/vip_offers_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHVIEW;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REDEEMCOUPONCODE,
      page: () => RedeemCouponCode(),
      binding: QrScanBinding(),
    ),
    GetPage(
      name: _Paths.TERMSANDCONDITIONS,
      page: () => TermsConditionsView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => const VerificationView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordVerifyView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETUP,
      page: () => const ProfileSetupView(),
      binding: ProfileSetupBinding(),
    ),
    GetPage(
      name: _Paths.ENABLE_LOCATION,
      page: () => const EnableLocationView(),
      binding: EnableLocationBinding(),
    ),
    GetPage(
      name: _Paths.NAV_BAR,
      page: () => const NavBarView(),
      binding: NavBarBinding(),
    ),
    GetPage(
      name: _Paths.MENU_PAGE,
      page: () => const MenuPageView(),
      binding: MenuPageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ITEM_DETAILS,
      page: () => const AddItemDetailsView(),
      binding: AddItemDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_RESTURANT_DETAILS,
      page: () => const EditResturantDetailsView(),
      binding: EditResturantDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD_PROFILE,
      page: () => const ChangePasswordProfileView(),
      binding: ChangePasswordProfileBinding(),
    ),
    GetPage(
      name: _Paths.HELP_AND_SUPPORT_SCREEN,
      page: () => const HelpAndSupportScreenView(),
      binding: HelpAndSupportScreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_DETAILS,
      page: () => const ProfileDetailsView(),
      binding: ProfileDetailsBinding(),
    ),
    GetPage(
      name: _Paths.FEATURES_AND_TIMINGS,
      page: () => const FeaturesAndTimingsView(),
      binding: FeaturesAndTimingsBinding(),
    ),
    GetPage(
      name: _Paths.ALL_PHOTOS_AND_VIDEOS,
      page: () => const AllPhotosAndVideosView(),
      binding: AllPhotosAndVideosBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_REDEMPTION_RECORD,
      page: () => const ScanRedemptionRecordView(),
      binding: ScanRedemptionRecordBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_HISTORY,
      page: () => const ScanHistoryView(),
      binding: ScanHistoryBinding(),
    ),
    GetPage(
      name: _Paths.VIP_OFFERS,
      page: () => const VipOffersView(),
      binding: VipOffersBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_OR_EDIT_VIP_OFFER,
      page: () => const CreateOrEditVipOfferView(),
      binding: CreateOrEditVipOfferBinding(),
    ),
    GetPage(
      name: _Paths.LOYALTY,
      page: () => const LoyaltyView(),
      binding: LoyaltyBinding(),
    ),
    GetPage(
      name: _Paths.LOYALTY_CARD_PREVIEW,
      page: () => const LoyaltyCardPreviewView(),
      binding: LoyaltyCardPreviewBinding(),
    ),
    GetPage(
      name: _Paths.LOYALTY_CARDS,
      page: () => const LoyaltyCardsView(),
      binding: LoyaltyCardsBinding(),
    ),
    GetPage(
      name: _Paths.JOBS,
      page: () => JobsView(),
      binding: JobsBinding(),
    ),
    GetPage(
      name: _Paths.JOB_EDIT_OR_ADD,
      page: () => const JobEditOrAddView(),
      arguments: [],
      binding: JobEditOrAddBinding(),
    ),
    GetPage(
      name: _Paths.PUSH_NOTIFICATION,
      page: () => const PushNotificationView(),
      binding: PushNotificationBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PUSH_NOTIFICATION,
      page: () => const CreatePushNotificationView(),
      binding: CreatePushNotificationBinding(),
    ),
    GetPage(
      name: _Paths.RATING_AND_FEEDBACK_MANAGEMENT,
      page: () => const RatingAndFeedbackManagementView(),
      binding: RatingAndFeedbackManagementBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.QR_SCAN,
      page: () => const QrScanView(),
      binding: QrScanBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => const SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASEPLAN,
      page: () => PurchasePlanView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENTDETAILS,
      page: () => PaymentMethodsView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.CARDDETAILS,
      page: () => CardDetailsView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHVIEW,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
