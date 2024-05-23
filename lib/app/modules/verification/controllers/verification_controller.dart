import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  //TODO: Implement VerificationController

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

  void gotoProfileSetupScreen() {
    Get.toNamed(Routes.PROFILE_SETUP);
  }

  void increment() => count.value++;
}
