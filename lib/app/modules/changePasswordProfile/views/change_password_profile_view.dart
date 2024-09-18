import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/fsv_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/change_password_profile_controller.dart';

class ChangePasswordProfileView
    extends GetView<ChangePasswordProfileController> {
  const ChangePasswordProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstant.changePassword,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.kw),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConstant.oldPassword,
                style: TextStyleUtil.manrope14w500(),
              ),
              6.kheightBox,
              Obx(
                () => FsvTextfield(
                  obscureText: controller.isOldPasswordVisible.value,
                  controller: controller.oldPasswordController,
                  hintText: StringConstant.enterPassword,
                  validator: (value) => controller.oldPasswordValidator(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onPressedSuffix: () {
                    controller.isOldPasswordVisible.value =
                        !controller.isOldPasswordVisible.value;
                  },
                  suffix: controller.isOldPasswordVisible.value
                      ? Icon(Icons.visibility_off, size: 18.kw)
                      : Icon(Icons.remove_red_eye_rounded, size: 18.kw),
                ),
              ),
              20.kheightBox,
              Row(
                children: [
                  Text(
                    StringConstant.newPassword,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                        TextStyleUtil.manrope14w400(color: context.primary01),
                  )
                ],
              ),
              6.kheightBox,
              Obx(
                () => FsvTextfield(
                  hintText: StringConstant.enterNewPassword,
                  controller: controller.newPasswordController,
                  obscureText: controller.isNewPasswordVisible.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => controller.newPasswordValidator(value),
                  onPressedSuffix: () {
                    controller.isNewPasswordVisible.value =
                        !controller.isNewPasswordVisible.value;
                  },
                  suffix: controller.isNewPasswordVisible.value
                      ? Icon(Icons.visibility_off, size: 18.kw)
                      : Icon(Icons.remove_red_eye_rounded, size: 18.kw),
                ),
              ),
              20.kheightBox,
              Row(
                children: [
                  Text(
                    StringConstant.confirmPassword,
                    style: TextStyleUtil.manrope14w500(),
                  ),
                  Text(
                    "*",
                    style:
                        TextStyleUtil.manrope14w400(color: context.primary01),
                  )
                ],
              ),
              6.kheightBox,
              Obx(
                () => FsvTextfield(
                  hintText: StringConstant.confirmPassword,
                  controller: controller.confirmPasswordController,
                  validator: (value) =>
                      controller.confirmPasswordValidator(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: controller.isConfirmPasswordVisible.value,
                  onPressedSuffix: () {
                    controller.isConfirmPasswordVisible.value =
                        !controller.isConfirmPasswordVisible.value;
                  },
                  suffix: controller.isConfirmPasswordVisible.value
                      ? Icon(Icons.visibility_off, size: 18.kw)
                      : Icon(Icons.remove_red_eye_rounded, size: 18.kw),
                ),
              ),
              const Spacer(),
              CustomRedElevatedButton(
                  buttonText: StringConstant.save,
                  height: 56.kh,
                  width: 100.w,
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      if (controller.newPasswordController.text ==
                          controller.confirmPasswordController.text) {
                        controller.updatePassword(
                            controller.newPasswordController.text);
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
