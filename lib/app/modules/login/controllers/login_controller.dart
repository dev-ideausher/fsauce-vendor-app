import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void gotoSignupScreen() {
    Get.toNamed(Routes.SIGNUP);
  }

  void gotoChangePasswordScreen() {
    Get.toNamed(Routes.CHANGE_PASSWORD);
  }

  void increment() => count.value++;
}
