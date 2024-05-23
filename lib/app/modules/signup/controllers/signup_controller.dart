import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

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

  void gotoVerificationScreen() {
    Get.toNamed(Routes.VERIFICATION);
  }

  void increment() => count.value++;
}
