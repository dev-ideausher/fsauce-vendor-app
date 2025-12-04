import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

import '../../../models/push_notification_model.dart';

class PushNotificationController extends GetxController {
  //TODO: Implement PushNotificationController

  RxList<PushNotificationData> notificationList = <PushNotificationData>[].obs;
  RxBool isLoad = false.obs;

  Future<void> getNotifications() async {
    try {
      isLoad.value = true;
      var response = await APIManager.getNotifications();
      List<dynamic> data = response.data['data'];
      notificationList.value = [];
      notificationList.value =
          data.map((e) => PushNotificationData.fromJson(e)).toList();
      isLoad.value = false;
    } catch (e) {
      isLoad.value = false;
      print(e.toString());
      DialogHelper.showError(e.toString());
    }
  }

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }

  void showInactiveDialog(String id) {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.inactivateNotification,
        subTitle: StringConstant.inactiveNotificationSub,
        onYesTap: () async {
          try {
            Get.back();
            var response =
                await APIManager.editNotification(id: id, isActive: false);
            if (response.data['status']) {
              DialogHelper.showSuccess(response.data['message']);
              getNotifications();
            } else {
              DialogHelper.showError(response.data['message'] ??
                  StringConstant.somethingWentWrong);
            }
          } catch (e) {
            DialogHelper.showError(e.toString());
          }
        },
        onNoTap: Get.back));
  }

  void showDeleteDialog(String id) {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.deleteNotification,
        subTitle: StringConstant.deleteNotificationSub,
        onYesTap: () async {
          try {
            Get.back();
            var response = await APIManager.deleteNotification(id: id);
            if (response['status']) {
              DialogHelper.showSuccess(StringConstant.deletedSuccessfully);
              getNotifications();
            } else {
              DialogHelper.showError(
                  response['message'] ?? StringConstant.somethingWentWrong);
            }
          } catch (e) {
            DialogHelper.showError(e.toString());
          }
        },
        onNoTap: Get.back));
  }

  void showActiveDialog(String id) {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.activateNotification,
        subTitle: StringConstant.activateNotificationSub,
        onYesTap: () async {
          try {
            Get.back();
            var response =
                await APIManager.editNotification(id: id, isActive: true);
            if (response.data['status']) {
              DialogHelper.showSuccess(response.data['message']);
              getNotifications();
            } else {
              DialogHelper.showError(response.data['message'] ??
                  StringConstant.somethingWentWrong);
            }
          } catch (e) {
            DialogHelper.showError(e.toString());
          }
        },
        onNoTap: Get.back));
  }

  void createPushNotification() {
    Get.toNamed(Routes.CREATE_PUSH_NOTIFICATION);
  }
}
