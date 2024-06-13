import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/modules/changePassword/views/change_password_view.dart';
import 'package:fsauce_vendor_app/app/modules/changePassword/views/password_change_complete.dart';
import 'package:fsauce_vendor_app/app/services/auth.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController

  TextEditingController emailController = TextEditingController();

  Auth auth = Get.put(Auth());

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

  void sendResetPasswordLink() {
    auth.sendResetPasswordMail(email: emailController.text.trim());
  }

  void gotoChangePasswordDoneScreen() {
    Get.to(const ChangePasswordDoneScreen());
  }

  void gotoChangePasswordScreen() {
    Get.to(const ChangePasswordView());
  }

  void increment() => count.value++;
}
