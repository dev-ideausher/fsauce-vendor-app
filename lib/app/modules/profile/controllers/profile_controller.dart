import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

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

  void gotoProfileDetailsScreen() {
    Get.toNamed(Routes.PROFILE_DETAILS);
  }

  void gotoChangePasswordScreen() {
    Get.toNamed(Routes.CHANGE_PASSWORD_PROFILE);
  }

  void gotoHelpAndSupportScreen() {
    Get.toNamed(Routes.HELP_AND_SUPPORT_SCREEN);
  }

  void showLogoutDialog() {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.confirmLogout,
        subTitle: StringConstant.confirmLogoutSub,
        onYesTap: () {},
        onNoTap: Get.back));
  }

  void increment() => count.value++;
}
