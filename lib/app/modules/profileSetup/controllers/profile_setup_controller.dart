import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/views/step_one.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/views/step_three.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/views/step_two.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileSetupController extends GetxController {
  //TODO: Implement ProfileSetupController

  final stepCount = 0.obs;
  final List<Widget> steps = [
    const StepOne(),
    const StepTwo(),
    const StepThree()
  ];
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

  void gotoEnableLocationScreen() {
    Get.toNamed(Routes.ENABLE_LOCATION);
  }

  void increment() => stepCount.value++;
}
