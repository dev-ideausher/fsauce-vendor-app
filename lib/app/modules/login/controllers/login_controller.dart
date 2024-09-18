import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/models/login_model.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/auth.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:fsauce_vendor_app/app/services/snackbar.dart';
import 'package:fsauce_vendor_app/app/services/storage.dart';
import 'package:get/get.dart';

import '../../../constants/string_constant.dart';

class LoginController extends GetxController {
  final Auth auth = Get.find<Auth>();
  User? user = FirebaseAuth.instance.currentUser;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isApple = false.obs;
  RxBool passwordVisible = true.obs;
  RxBool isLoginEnabled = false.obs;

  final formKey = GlobalKey<FormState>();

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
    passwordController.dispose();
    emailController.dispose();
  }

  void getOS() {
    if (Platform.isAndroid) {
      isApple.value = false;
    } else if (Platform.isIOS) {
      isApple.value = true;
    }
  }

  void toggleIsEnabled() {
    isLoginEnabled.value = !isLoginEnabled.value;
  }

  void togglePasswordVisible() {
    passwordVisible.value = !passwordVisible.value;
  }

  void login() async {
    DialogHelper.showLoading();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!_isEmailValid(email)) {
      await DialogHelper.hideDialog();
      Get.snackbar(StringConstant.error, StringConstant.plsEnterValidEmail);
      return;
    }

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await auth.loginEmailPass(email: email, pass: password);
        DialogHelper.hideDialog();
        return;
      } catch (e) {
        await DialogHelper.hideDialog();
        Get.snackbar(StringConstant.error, e.toString());
        return;
      }
    } else {
      await DialogHelper.hideDialog();
      Get.snackbar(StringConstant.error, StringConstant.emailPasswordEmpty);
      return;
    }
  }

  void loginWithGoogle() async {
    try {
      await auth.google();
      auth.gotoHomeScreen();
    } catch (e) {
      print("Error : ${e.toString()}");
      Get.snackbar(StringConstant.error, e.toString());
    }
  }

  void loginWithFacebook() async {
    try {
      await auth.facebook();
    } catch (e) {
      Get.snackbar(StringConstant.error, e.toString());
    }
  }

  void loginWithApple() async {
    try {
      await auth.apple();
    } catch (e) {
      Get.snackbar(StringConstant.error, e.toString());
    }
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

  String? validateEmail(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter your email';
    } else if (!GetUtils.isEmail(val)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    // Check if the password meets the criteria (e.g., length, complexity)
    // For example, let's enforce a minimum length of 8 characters and at least one uppercase letter, one lowercase letter, one digit, and one special character.
    final RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    final RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    final RegExp digitRegExp = RegExp(r'[0-9]');
    final RegExp specialCharacterRegExp = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (value.length > 25) {
      return 'Password cannot be of more than 25 characters';
    }

    if (!upperCaseRegExp.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!lowerCaseRegExp.hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!digitRegExp.hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    if (!specialCharacterRegExp.hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null; // Return null if the value is valid
  }
}
