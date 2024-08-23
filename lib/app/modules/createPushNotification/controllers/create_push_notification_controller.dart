import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/models/push_notification_model.dart';
import 'package:fsauce_vendor_app/app/modules/pushNotification/controllers/push_notification_controller.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';

import '../../../constants/string_constant.dart';

import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';

class CreatePushNotificationController extends GetxController {
  //TODO: Implement CreatePushNotificationController

  @override
  void onInit(){
    super.onInit();
    Get.find<HomeController>().getRestaurantDetails();
  }

  @override
  void onClose() {
    titleController.dispose();
    scheduledDateController.dispose();
    super.onClose();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController scheduledDateController = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;

  final formKey = GlobalKey<FormState>();

  Future<void> addNotification() async{
    if(Get.find<HomeController>().restaurantDetails.value.subscriptionModel != null){
      if(titleController.text.isEmpty){
        Get.snackbar("Error", StringConstant.titleEmpty);
        return;
      }
      else{
        try{
          PushNotification notification = PushNotification(title: titleController.text, sheduledDate: scheduledDateController.text.isEmpty ? null : selectedDate.value.toString());
          var response = await APIManager.addPushNotification(data: notification.toJson());
          if(response.data['status']){
            Get.back();
            DialogHelper.showSuccess(StringConstant.notificationSentSuccessfully);
            Get.find<PushNotificationController>().getNotifications();
            Get.find<PushNotificationController>().notificationList.add(notification);
            return;
          } else{
            Get.snackbar("Error", response.data['message']);
            return;
          }
        } catch(e){
          Get.snackbar("Error", e.toString());
          return;
        }
      }
    } else{
      Get.snackbar("Subscription Required", "Kindly subscribe to a plan to access this feature!");
      return;
    }
  }
}
