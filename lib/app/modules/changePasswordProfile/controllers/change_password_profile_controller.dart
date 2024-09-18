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

  void updatePassword(String newPassword) async {
    try {
      DialogHelper.showLoading();
      final bool status = await auth.updatePassword(newPassword: newPassword);
      if (status) {
        DialogHelper.hideDialog();
        Get.back();
        Get.bottomSheet(const AddedSuccessfullBottomSheet(
            subTitle: StringConstant.passwordChangedSuccessfully));
      } else {
        DialogHelper.hideDialog();
        Get.snackbar("Password not changed",
            "This operation is sensitive and requires recent authentication. Log in again before retrying this request.");
      }
    } catch (e) {
      print("An error occurred while updating password!: $e");
      Get.snackbar("Error", e.toString());
    }
  }

  String? oldPasswordValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return StringConstant.oldPasswordCannotBeEmpty;
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

    if (value.length > 15) {
      return StringConstant.max15CharsAllowed;
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

  String? newPasswordValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return StringConstant.newPasswordCannotBeEmpty;
    }

    if (value == oldPasswordController.value.text) {
      return StringConstant.newPasswordCannotBeSameAsOldPassword;
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

    if (value.length > 15) {
      return StringConstant.max15CharsAllowed;
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

  String? confirmPasswordValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return StringConstant.confirmPasswordCannotBeEmpty;
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

    if (value.length > 15) {
      return StringConstant.max15CharsAllowed;
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

    if (value != newPasswordController.text) {
      return StringConstant.passwordsDoNotMatch;
    }
    return null; // Return null if the value is valid
  }
}
