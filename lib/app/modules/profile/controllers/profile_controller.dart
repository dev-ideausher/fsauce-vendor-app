import 'package:fsauce_vendor_app/app/components/confirmation_dialog.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:fsauce_vendor_app/app/services/storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../services/auth.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  void gotoProfileDetailsScreen() {
    Get.toNamed(Routes.PROFILE_DETAILS);
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
        ConfrimationDialog(
        title: StringConstant.confirmLogout,
        subTitle: StringConstant.confirmLogoutSub,
        onYesTap: () async{
          // Get.find<GetStorageService>().logout();
          await Get.find<Auth>().logOutUser();
          Get.offAllNamed(Routes.LOGIN);
        },
        onNoTap: Get.back)
    );
  }

  void showDeleteAccountDialog() {
    Get.dialog(ConfrimationDialog(
        title: StringConstant.deleteAccount,
        subTitle: StringConstant.confirmDelAcccountSub,
        onYesTap: () async{
          //ToDo: Delete account.
          delAccount();
        },
        onNoTap: Get.back));
  }

  Future<void> delAccount() async{
    try{
      var response = await APIManager.deleteAccount();
      print("Response of the delete account api: ${response['status']}, ${response['message']}");
      if(response['status']){
        await Get.find<Auth>().logOutUser();
        Get.offAllNamed(Routes.SIGNUP);
      } else{
        print("Message from del account: ${response['message']}");
        Get.snackbar("Message", response['message']);
      }
    } catch(e){
      print("An error occurred while deleting account! $e");
      Get.snackbar("Error", "Error occurred while deleting account!");
      return;
    }
  }

  void gotoPushNotification() {
    Get.toNamed(Routes.PUSH_NOTIFICATION);
  }
}
