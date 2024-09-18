import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

import '../../../models/push_notification_model.dart';

class PushNotificationController extends GetxController {
  //TODO: Implement PushNotificationController

  RxList<PushNotification> notificationList = <PushNotification>[].obs;
  RxBool isLoad = false.obs;

  Future<void> getNotifications() async{
    try{
      isLoad.value = true;
      var response = await APIManager.getNotifications();
      List<dynamic> data = response.data['data'];
      notificationList.value = [];
      notificationList.value = data.map((e) => PushNotification.fromJson(e)).toList();
      isLoad.value = false;
    } catch(e){
      print(e.toString());
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onInit() {
    getNotifications();
    super.onInit();
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
