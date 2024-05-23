import 'package:fsauce_vendor_app/app/modules/changePassword/views/change_password_view.dart';
import 'package:fsauce_vendor_app/app/modules/changePassword/views/password_change_complete.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController

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

  void gotoChangePasswordDoneScreen() {
    Get.to(const ChangePasswordDoneScreen());
  }

  void gotoChangePasswordScreen() {
    Get.to(const ChangePasswordView());
  }

  void increment() => count.value++;
}
