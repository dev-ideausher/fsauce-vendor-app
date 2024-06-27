import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  void gotoSubscriptionScreen() {
    Get.toNamed(Routes.SUBSCRIPTION);
  }

  void gotoHelpAndSupportScreen() {
    Get.toNamed(Routes.HELP_AND_SUPPORT_SCREEN);
  }

  void gotoScanRedemptionRecord() {
    Get.toNamed(Routes.SCAN_REDEMPTION_RECORD);
  }

  void showLogoutDialog() {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.confirmLogout,
        subTitle: StringConstant.confirmLogoutSub,
        onYesTap: () {
          Get.find<GetStorageService>().logout();
          Get.offAllNamed(Routes.LOGIN);
        },
        onNoTap: Get.back));
  }

  void gotoPushNotification() {
    Get.toNamed(Routes.PUSH_NOTIFICATION);
  }

  void increment() => count.value++;
}
