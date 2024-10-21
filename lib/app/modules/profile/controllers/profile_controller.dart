import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/custom_button.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../services/auth.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final auth = Get.find<Auth>();

  void gotoProfileDetailsScreen() {
    Get.toNamed(Routes.PROFILE_SETUP);
  }

  void gotoChangePasswordScreen() {
    Get.toNamed(Routes.CHANGE_PASSWORD_PROFILE);
  }

  void gotoSubscriptionScreen() {
    Get.toNamed(Routes.SUBSCRIPTION);
  }

  void gotoHelpAndSupportScreen() {
    Get.toNamed(Routes.HELP_AND_SUPPORT_SCREEN);
  }

  void gotoScanRedemptionRecord() {
    Get.toNamed(Routes.SCAN_REDEMPTION_RECORD);
  }

  void showLogoutDialog() {
    Get.dialog(
      useSafeArea: true,
      Center(
        child: Container(
          padding: EdgeInsets.all(16.kh),
          height: 192.kh,
          width: 80.w,
          decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.circular(8.kh),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.close),
                ),
              ),
              Text(
                StringConstant.confirmLogout,
                style: TextStyleUtil.manrope18w600(
                    textDecoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ).paddingSymmetric(vertical: 4.kh),
              Text(
                StringConstant.sureWantToLogout,
                style: TextStyleUtil.manrope14w400(
                    color: ColorUtil.kBlack04,
                    textDecoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ).paddingOnly(bottom: 40.kh),
              Container(
                alignment: Alignment.centerRight,
                child: FsvButton(
                  onPressed: () async {
                    // Get.find<GetStorageService>().logout();
                    await Get.find<Auth>().logOutUser();
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  height: 40.kh,
                  width: 144.kw,
                  label: StringConstant.logout,
                  fontSize: 14.kh,
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    /*Get.dialog(ConfrimationDialog(
        title: StringConstant.confirmLogout,
        subTitle: StringConstant.confirmLogoutSub,
        onYesTap: () async {
          // Get.find<GetStorageService>().logout();
          await Get.find<Auth>().logOutUser();
          Get.offAllNamed(Routes.LOGIN);
        },
        onNoTap: Get.back));*/
  }

  void showDeleteAccountDialog() {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.deleteAccount,
        subTitle: StringConstant.confirmDelAcccountSub,
        onYesTap: () async {
          //ToDo: Delete account.
          delAccount();
        },
        onNoTap: Get.back));
  }

  Future<void> delAccount() async {
    try {
      var response = await APIManager.deleteAccount();
      auth.auth.currentUser!.delete();
      print(
          "Response of the delete account api: ${response['status']}, ${response['message']}");
      if (response['status']) {
        await Get.find<Auth>().logOutUser();
        Get.offAllNamed(Routes.SIGNUP);
      } else {
        print("Message from del account: ${response['message']}");
        Get.snackbar("Message", response['message']);
      }
    } catch (e) {
      print("An error occurred while deleting account! $e");
      Get.snackbar("Error", "Error occurred while deleting account!");
      return;
    }
  }

  void gotoPushNotification() {
    Get.toNamed(Routes.PUSH_NOTIFICATION);
  }
}
