import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class PushNotificationController extends GetxController {
  //TODO: Implement PushNotificationController

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

  void showInactiveDialog() {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.inactivateNotification,
        subTitle: StringConstant.inactiveNotificationSub,
        onYesTap: () {},
        onNoTap: Get.back));
  }

  void showDeleteDialog() {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.deleteNotification,
        subTitle: StringConstant.deleteNotificationSub,
        onYesTap: () {},
        onNoTap: Get.back));
  }

  void showActiveDialog() {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.activateNotification,
        subTitle: StringConstant.activateNotificationSub,
        onYesTap: () {},
        onNoTap: Get.back));
  }

  void createPushNotification() {
    Get.toNamed(Routes.CREATE_PUSH_NOTIFICATION);
  }
}
