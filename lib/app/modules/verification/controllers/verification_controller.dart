import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/constants/urls.dart';
import 'package:fsauce_vendor_app/app/modules/verification/views/verification_done_screen.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/auth.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:fsauce_vendor_app/app/services/dio/client.dart';
import 'package:fsauce_vendor_app/app/services/storage.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  Timer? _timer;
  final Auth auth = Get.put(Auth());

  @override
  void onInit() {
    super.onInit();
    _startEmailVerificationCheck();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }

  void _startEmailVerificationCheck() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await _checkEmailVerified();
    });
  }

  Future<void> _checkEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload(); // Refresh user data
    if (user != null && user.emailVerified) {
      _timer?.cancel();
      DialogHelper.showLoading();

      var response = await APIManager.onboardVendor();
      DialogHelper.hideDialog();
      if (response.data['status']) {
        print(response.data.toString());
        print("vendor onboarded");
        gotoVerificationDoneScreen();
      } else {
        Get.snackbar("Error", response.data['message']);
      }
    }
  }

  void resendVerificationEmail() async {
    try {
      DialogHelper.showLoading();
      await auth.sendVerificationMail();
      await DialogHelper.hideDialog();
      Get.snackbar(StringConstant.success, StringConstant.verifEmailSent);
      _checkEmailVerified();
    } catch (e) {
      await DialogHelper.hideDialog();
      Get.snackbar(StringConstant.error, e.toString());
    }
  }

  void gotoProfileSetupScreen() {
    Get.toNamed(Routes.PROFILE_SETUP);
  }

  //VerificationDoneScreen

  void gotoVerificationDoneScreen() {
    Get.offAll(const VerificationDoneScreen());
  }
}
