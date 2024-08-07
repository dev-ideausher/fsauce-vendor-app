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
  RxBool passwordVisible = false.obs;
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
        gotoHomeScreen();
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
      gotoHomeScreen();
    } catch (e) {
      print("Error : ${e.toString()}");
      Get.snackbar(StringConstant.error, e.toString());
    }
  }

  void loginWithFacebook() async {
    try {
      await auth.facebook();
      gotoHomeScreen();
    } catch (e) {
      Get.snackbar(StringConstant.error, e.toString());
    }
  }

  void loginWithApple() async {
    try {
      await auth.apple();
      gotoHomeScreen();
    } catch (e) {
      Get.snackbar(StringConstant.error, e.toString());
    }
  }

  void gotoHomeScreen() async {
    try {
      final response = await APIManager.onboardVendor();
      final LoginModel loginModel = LoginModel.fromJson(response.data);
      if (loginModel.status ?? false) {
        if ((loginModel.user?.restaurantName ?? "").isEmpty) {
          Get.offAllNamed(Routes.PROFILE_SETUP);
        } else if ((loginModel.user?.restaurantLogo ?? "").isEmpty) {
          Get.offAllNamed(Routes.PROFILE_SETUP);
        } else if ((loginModel.user?.restaurantBanner ?? "").isEmpty) {
          Get.offAllNamed(Routes.PROFILE_SETUP);
        } else if ((loginModel.user?.avgPrice.toString() ?? "").isEmpty) {
          Get.offAllNamed(Routes.PROFILE_SETUP);
        } else if ((loginModel.user?.location ?? "").isEmpty) {
          Get.offAllNamed(Routes.PROFILE_SETUP);
        } else if ((loginModel.user?.features ?? []).isEmpty) {
          Get.offAllNamed(Routes.PROFILE_SETUP);
        } else if ((loginModel.user?.timing ?? []).isEmpty) {
          Get.offAllNamed(Routes.PROFILE_SETUP);
        } else if ((loginModel.user?.media ?? []).isEmpty) {
          Get.offAllNamed(Routes.PROFILE_SETUP);
        } else {
          Get.find<GetStorageService>().isLoggedIn = true;
          Get.offAllNamed(Routes.NAV_BAR);
        }
      } else {
        showMySnackbar(msg: loginModel.message ?? "Login message");
      }
    } catch (e) {
      debugPrint(e.toString());
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
}
