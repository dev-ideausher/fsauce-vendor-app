import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final count = 0.obs;
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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
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
      if (response.statusCode == 200) {
        print("vendor onboarded");
        gotoVerificationDoneScreen();
      } else {
        Get.snackbar("Error", "Something went wrong!");
      }
    }
  }

  void resendVerificationEmail() async {
    try {
      DialogHelper.showLoading();
      await auth.sendVerificationMail();
      await DialogHelper.hideDialog();
      Get.snackbar("Success", "Verification email send successfully");
      _checkEmailVerified();
    } catch (e) {
      await DialogHelper.hideDialog();
      Get.snackbar("Error", e.toString());
    }
  }

  void gotoProfileSetupScreen() {
    Get.toNamed(Routes.PROFILE_SETUP);
  }

  void gotoVerificationDoneScreen() {
    Get.to(const VerificationDoneScreen());
  }

  void increment() => count.value++;
}
