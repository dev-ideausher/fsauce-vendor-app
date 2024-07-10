import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/auth.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:get/get.dart';

import '../../../constants/string_constant.dart';

class SignupController extends GetxController {
  final Auth auth = Get.put(Auth()); // Retrieve the Auth service

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isApple = false.obs;
  RxBool passwordVisible = false.obs;
  RxBool isSignupEnabled = false.obs;
  RxBool termsAndConditionsChecked = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOS();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  void getOS(){
    if(Platform.isAndroid){
      isApple.value = false;
    } else if(Platform.isIOS){
      isApple.value = true;
    }
  }

  void togglePasswordVisible(){
    passwordVisible.value = !passwordVisible.value;
  }

  void signup() async {
    DialogHelper.showLoading();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!_isEmailValid(email)) {
      await DialogHelper.hideDialog();
      Get.snackbar(StringConstant.error, StringConstant.plsEnterValidEmail);
      return;
    }

    if (!_isPasswordValid(password)) {
      await DialogHelper.hideDialog();
      Get.snackbar(StringConstant.error, StringConstant.password6characters);
      return;
    }

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await auth.createEmailPass(email: email, pass: password);
        await DialogHelper.hideDialog();
        await auth.sendVerificationMail();
        gotoVerificationScreen();
      } catch (e) {
        await DialogHelper.hideDialog();
        // Handle error (show a message to the user)
        Get.snackbar(StringConstant.error, e.toString());
      }
    } else {
      await DialogHelper.hideDialog();
      Get.snackbar(StringConstant.error, StringConstant.emailPasswordEmpty);
    }
  }

  void signupWithGoogle() async {
    try {
      await auth.google();
      gotoVerificationScreen();
    } catch (e) {
      Get.snackbar(StringConstant.error, e.toString());
    }
  }

  void signupWithFacebook() async {
    try {
      await auth.facebook();
      gotoVerificationScreen();
    } catch (e) {
      Get.snackbar(StringConstant.error, e.toString());
    }
  }

  void signupWithApple() async {
    try {
      await auth.apple();
      gotoVerificationScreen();
    } catch (e) {
      Get.snackbar(StringConstant.error, e.toString());
    }
  }

  void gotoVerificationScreen() {
    Get.offAllNamed(Routes.VERIFICATION);
  }

  bool _isEmailValid(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  void goToTermsAndConditions(){
    Get.toNamed(Routes.TERMSANDCONDITIONS);
  }

  void replaceSignupWithLogin() {
    Get.offNamed(Routes.LOGIN);
  }
}
