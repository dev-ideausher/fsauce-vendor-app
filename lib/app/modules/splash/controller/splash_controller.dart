import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../services/storage.dart';

class SplashController extends GetxController {
  RxBool isLogin = false.obs;

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offAllNamed(Get.find<GetStorageService>().isLoggedIn
          ? Routes.PROFILE_SETUP
          : Routes.ONBOARDING);
    });
    super.onInit();
  }
}
