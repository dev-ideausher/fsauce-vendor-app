import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
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
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              StringConstant.changePassword,
              style: TextStyleUtil.manrope32w700(),
            ),
            Text(
              StringConstant.enterNewPassword,
              style: TextStyleUtil.manrope16w400(
                color: context.black03,
              ),
            ),
            90.kheightBox,
            Text(
              StringConstant.newPassword,
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
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.remove_red_eye_rounded,
                                size: 18.kw,
                              )),
                          hintText: StringConstant.password,
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
            20.kheightBox,
            Text(
              StringConstant.reEnterNewPassword,
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
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.remove_red_eye_rounded,
                                size: 18.kw,
                              )),
                          hintText: StringConstant.password,
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
            CustomRedElevatedButton(
                buttonText: StringConstant.continuee,
                height: 56.kh,
                width: 100.w,
                onPressed: controller.gotoChangePasswordDoneScreen),
            20.kheightBox,
          ]),
        ));
  }
}
