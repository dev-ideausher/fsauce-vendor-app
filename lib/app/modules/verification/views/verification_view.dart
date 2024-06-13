import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/signup/controllers/signup_controller.dart';
import 'package:fsauce_vendor_app/app/modules/verification/views/verification_done_screen.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/verification_controller.dart';

class VerificationView extends GetView<VerificationController> {
  const VerificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "",
        ),
        body: Padding(
          padding: EdgeInsets.all(16.kw),
          child: SizedBox(
            width: 100.w,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      StringConstant.verify,
                      style: TextStyleUtil.manrope32w700(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      StringConstant.verifyYourAccount,
                      style: TextStyleUtil.manrope16w400(
                        color: context.black03,
                      ),
                    ),
                  ],
                ),
                80.kheightBox,
                Text(
                  StringConstant.verificationCodeSent,
                  textAlign: TextAlign.center,
                  style: TextStyleUtil.manrope16w400(
                    color: context.black03,
                  ),
                ),
                6.kheightBox,
                Text(
                  Get.find<SignupController>().emailController.text,
                  style: TextStyleUtil.manrope16w500(),
                ),
                90.kheightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConstant.didntGetCode,
                      style: TextStyleUtil.manrope14w500(
                        color: context.black04,
                      ),
                    ),
                    InkWell(
                      onTap: controller.resendVerificationEmail,
                      child: Text(
                        StringConstant.resend,
                        style: TextStyleUtil.manrope14w600(
                          color: context.primary01,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
