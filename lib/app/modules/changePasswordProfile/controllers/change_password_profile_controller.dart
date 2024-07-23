import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../constants/string_constant.dart';
import '../../../services/auth.dart';
import '../../../services/dialog_helper.dart';

class ChangePasswordProfileController extends GetxController {
  //TODO: Implement ChangePasswordProfileController

  final Auth auth = Get.put(Auth()); // Retrieve the Auth service

  final formKey = GlobalKey<FormState>();

  RxBool isOldPasswordVisible = true.obs;
  RxBool isNewPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  void updatePassword(String newPassword) async{
    try{
      DialogHelper.showLoading();
      await auth.updatePassword(newPassword: newPassword);
      DialogHelper.showSuccess(StringConstant.passwordChangedSuccessfully);
      DialogHelper.hideDialog();
    } catch(e){
      print("An error occurred while updating password!: $e");
      DialogHelper.showError(e.toString());
    }
  }
}
