import 'package:flutter/cupertino.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
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
      DialogHelper.hideDialog();
      Get.back();
      Get.bottomSheet(const AddedSuccessfullBottomSheet(subTitle: StringConstant.passwordChangedSuccessfully));
    } catch(e){
      print("An error occurred while updating password!: $e");
      Get.snackbar("Error", e.toString());
    }
  }
}
