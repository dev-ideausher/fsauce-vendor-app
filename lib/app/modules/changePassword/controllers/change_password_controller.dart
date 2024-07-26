import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/modules/changePassword/views/change_password_view.dart';
import 'package:fsauce_vendor_app/app/modules/changePassword/views/password_change_complete.dart';
import 'package:fsauce_vendor_app/app/services/auth.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController

  TextEditingController emailController = TextEditingController();

  Auth auth = Get.find<Auth>();

  RxBool isEmailEmpty = true.obs;
  RxBool isOldPasswordVisible = false.obs;
  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
  }

  void sendResetPasswordLink() {
    auth.sendResetPasswordMail(email: emailController.text.trim());
  }

  void toggleOldPasswordVisible(){
    isOldPasswordVisible.value = !isOldPasswordVisible.value;
  }

  void toggleNewPasswordVisible(){
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisible(){
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void gotoChangePasswordDoneScreen() {
    Get.to(const ChangePasswordDoneScreen());
  }

  void gotoChangePasswordScreen() {
    Get.to(const ChangePasswordView());
  }
}
