import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/auth.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final Auth auth = Get.put(Auth()); // Retrieve the Auth service

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    DialogHelper.showLoading();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!_isEmailValid(email)) {
      await DialogHelper.hideDialog();
      Get.snackbar('Error', 'Please enter a valid email');
      return;
    }

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await auth.loginEmailPass(email: email, pass: password);
        await DialogHelper.hideDialog();
        gotoHomeScreen();
      } catch (e) {
        await DialogHelper.hideDialog();
        Get.snackbar('Error', e.toString());
      }
    } else {
      await DialogHelper.hideDialog();
      Get.snackbar('Error', 'Email and Password cannot be empty');
    }
  }

  void loginWithGoogle() async {
    try {
      await auth.google();
      gotoHomeScreen();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void loginWithFacebook() async {
    try {
      await auth.facebook();
      gotoHomeScreen();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void loginWithApple() async {
    try {
      await auth.apple();
      gotoHomeScreen();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void gotoHomeScreen() {
    Get.offNamed(Routes.HOME);
  }

  bool _isEmailValid(String email) {
    // Basic email validation regex
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  void replaceLoginWithSignup() {
    Get.offNamed(Routes.SIGNUP);
  }

  void gotoForgotPasswordScreen() {
    Get.toNamed(Routes.CHANGE_PASSWORD);
  }
}
