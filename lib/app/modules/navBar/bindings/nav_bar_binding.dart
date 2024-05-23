import 'package:fsauce_vendor_app/app/modules/menuPage/controllers/menu_page_controller.dart';
import 'package:fsauce_vendor_app/app/modules/profile/controllers/profile_controller.dart';
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
  }
}
