import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/modules/changePassword/views/change_password_view.dart';
import 'package:fsauce_vendor_app/app/modules/changePassword/views/password_change_complete.dart';
import 'package:fsauce_vendor_app/app/services/auth.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
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

  bool _isEmailValid(String email) {
    return GetUtils.isEmail(email);
    // final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    // return regex.hasMatch(email);
  }

  void sendResetPasswordLink() async{
    if(_isEmailValid(emailController.text.trim())){
      DialogHelper.showLoading();
      final result = await auth.sendResetPasswordMail(email: emailController.text.trim());
      if(result){
        DialogHelper.hideDialog();
        Get.back();
        Get.bottomSheet(const AddedSuccessfullBottomSheet(subTitle: "You will receive a reset password link shortly"));
        return;
      } else {
        DialogHelper.hideDialog();
        Get.snackbar("Error","Something went wrong!");
        return;
      }
    } else if(!_isEmailValid(emailController.text.trim())){
      Get.snackbar("Error","Invalid email");
    }
    else{
      return;
    }
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
