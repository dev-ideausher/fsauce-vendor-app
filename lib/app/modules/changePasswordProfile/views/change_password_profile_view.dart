import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
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
              Container(
                height: 53.kh,
                width: 100.w,
                decoration: BoxDecoration(
                    color: context.loginSignupTextfieldColor,
                    borderRadius: BorderRadius.circular(8.0.kw),
                    border: Border.all(color: context.black07)),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4.kh),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return TextFormField(
                            obscureText: controller.isOldPasswordVisible.value,
                            controller: controller.oldPasswordController,
                            validator: (String? val) {
                              if (val == null || val.isEmpty) {
                                return StringConstant.oldPasswordCannotBeEmpty;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isOldPasswordVisible.value =
                                    !controller.isOldPasswordVisible.value;
                                  },
                                  icon: Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 18.kw,
                                  )),
                              hintText: StringConstant.enterPassword,
                              hintStyle: TextStyleUtil.manrope14w400(
                                  color: context.black04),
                              border: InputBorder.none,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
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
                    style: TextStyleUtil.manrope14w400(
                        color: context.primary01),
                  )
                ],
              ),
              6.kheightBox,
              Container(
                height: 53.kh,
                width: 100.w,
                decoration: BoxDecoration(
                    color: context.loginSignupTextfieldColor,
                    borderRadius: BorderRadius.circular(8.0.kw),
                    border: Border.all(color: context.black07)),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4.kh),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return TextFormField(
                            controller: controller.newPasswordController,
                            validator: (String? val) {
                              if (val == null || val.isEmpty) {
                                return StringConstant.newPasswordCannotBeEmpty;
                              }
                              return null;
                            },
                            obscureText: controller.isNewPasswordVisible.value,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isNewPasswordVisible.value =
                                    !controller.isNewPasswordVisible.value;
                                  },
                                  icon: Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 18.kw,
                                  )),
                              hintText: StringConstant.enterNewPassword,
                              hintStyle: TextStyleUtil.manrope14w400(
                                  color: context.black04),
                              border: InputBorder.none,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
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
                    style: TextStyleUtil.manrope14w400(
                        color: context.primary01),
                  )
                ],
              ),
              6.kheightBox,
              Container(
                height: 53.kh,
                width: 100.w,
                decoration: BoxDecoration(
                    color: context.loginSignupTextfieldColor,
                    borderRadius: BorderRadius.circular(8.0.kw),
                    border: Border.all(color: context.black07)),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4.kh),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return TextFormField(
                            controller: controller.confirmPasswordController,
                            validator: (String? val){
                              if(val == null || val.isEmpty){
                                return StringConstant.confirmPasswordCannotBeEmpty;
                              } else if(val != controller.newPasswordController.text){
                                return StringConstant.passwordsDoNotMatch;
                              }
                              return null;
                            },
                            obscureText: controller.isConfirmPasswordVisible
                                .value,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isConfirmPasswordVisible.value =
                                    !controller.isConfirmPasswordVisible.value;
                                  },
                                  icon: Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 18.kw,
                                  )),
                              hintText: StringConstant.confirmPassword,
                              hintStyle: TextStyleUtil.manrope14w400(
                                  color: context.black04),
                              border: InputBorder.none,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              CustomRedElevatedButton(
                  buttonText: StringConstant.save,
                  height: 56.kh,
                  width: 100.w,
                  onPressed: (){
                    if(controller.formKey.currentState!.validate()){

                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
