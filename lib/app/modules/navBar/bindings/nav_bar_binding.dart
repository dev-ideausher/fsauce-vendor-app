import 'package:fsauce_vendor_app/app/modules/loyalty/controllers/loyalty_controller.dart';
import 'package:fsauce_vendor_app/app/modules/loyaltyCards/controllers/loyalty_cards_controller.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/controllers/menu_page_controller.dart';
import 'package:fsauce_vendor_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/controllers/vip_offers_controller.dart';
import 'package:get/get.dart';

import '../controllers/nav_bar_controller.dart';

class NavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavBarController>(
      () => NavBarController(),
    );

    Get.lazyPut<MenuPageController>(
      () => MenuPageController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );

    Get.lazyPut<VipOffersController>(
      () => VipOffersController(),
    );

    Get.lazyPut<LoyaltyController>(
      () => LoyaltyController(),
    );
    Get.lazyPut<LoyaltyCardsController>(
      () => LoyaltyCardsController(),
    );
  }
}
