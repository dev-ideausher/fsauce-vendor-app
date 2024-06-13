import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/auth.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final Auth auth = Get.put(Auth()); // Retrieve the Auth service

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signup() async {
    DialogHelper.showLoading();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!_isEmailValid(email)) {
      await DialogHelper.hideDialog();
      Get.snackbar('Error', 'Please enter a valid email');
      return;
    }

    if (!_isPasswordValid(password)) {
      await DialogHelper.hideDialog();
      Get.snackbar('Error', 'Password must be at least 6 characters long');
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
        Get.snackbar('Error', e.toString());
      }
    } else {
      await DialogHelper.hideDialog();
      Get.snackbar('Error', 'Email and Password cannot be empty');
    }
  }

  void signupWithGoogle() async {
    try {
      await auth.google();
      gotoVerificationScreen();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void signupWithFacebook() async {
    try {
      await auth.facebook();
      gotoVerificationScreen();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void signupWithApple() async {
    try {
      await auth.apple();
      gotoVerificationScreen();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void gotoVerificationScreen() {
    Get.toNamed(Routes.VERIFICATION);
  }

  bool _isEmailValid(String email) {
    // Basic email validation regex
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  void replaceSignupWithLogin() {
    Get.offNamed(Routes.LOGIN);
  }
}
