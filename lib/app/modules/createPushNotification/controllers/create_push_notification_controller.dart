import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/models/push_notification_model.dart';
import 'package:fsauce_vendor_app/app/modules/pushNotification/controllers/push_notification_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

import '../../../constants/string_constant.dart';

class CreatePushNotificationController extends GetxController {
  //TODO: Implement CreatePushNotificationController

  TextEditingController titleController = TextEditingController();
  TextEditingController scheduledDateController = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;

  Future<void> addNotification() async{
    if(titleController.text.isEmpty){
      DialogHelper.showError(StringConstant.titleEmpty);
    } else if(scheduledDateController.text.isEmpty){
      DialogHelper.showError(StringConstant.scheduledDateEmpty);
    } else{
      try{
        PushNotification notification = PushNotification(title: titleController.text, sheduledDate: selectedDate.value.toString());
        var response = await APIManager.addPushNotification(data: notification.toJson());
        if(response.data['status']){
          DialogHelper.showSuccess(StringConstant.notificationSentSuccessfully);
          Get.find<PushNotificationController>().getNotifications();
          Get.find<PushNotificationController>().notificationList.add(notification);
          Get.back();
        } else{
          DialogHelper.showError(response.data['message']);
        }
      } catch(e){
        DialogHelper.showError(e.toString());
      }
    }
  }

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
    titleController.dispose();
    scheduledDateController.dispose();
    super.onClose();
  }
}
