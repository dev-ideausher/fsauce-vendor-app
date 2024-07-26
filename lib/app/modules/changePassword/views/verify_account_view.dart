import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordVerifyView extends GetView<ChangePasswordController> {
  const ChangePasswordVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.kw),
          child:
          Form(
            key: controller.formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                StringConstant.resetPassword,
                style: TextStyleUtil.manrope32w700(),
              ),
              90.kheightBox,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    StringConstant.resetPasswordLinkEmail,
                    style: TextStyleUtil.manrope16w400(
                      color: context.black03,
                    ),
                  ),
                ],
              ),
              40.kheightBox,
              Text(
                StringConstant.emailId,
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
                        child: TextField(
                          onChanged: (val) {
                            if (val.isEmpty) {
                              controller.isEmailEmpty.value = true;
                            } else if (val.isNotEmpty) {
                              controller.isEmailEmpty.value = false;
                            }
                          },
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            hintText: StringConstant.enterEmailId,
                            hintStyle: TextStyleUtil.manrope14w400(
                                color: context.black04),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Obx(() {
                return CustomRedElevatedButton(
                    buttonText: StringConstant.sendResetPasswordLink,
                    textStyle: controller.isEmailEmpty.value ? TextStyleUtil.manrope16w500(color: context.black03) : null,
                    buttonColor: controller.isEmailEmpty.value ? context.primary06 : context.primary01,
                    height: 56.kh,
                    width: 100.w,
                    onPressed: () {
                      if(controller.formKey.currentState!.validate()){
                        controller.sendResetPasswordLink();
                      }
                    });
              }),
              20.kheightBox,
            ]),
          ),
        ));
  }
}
