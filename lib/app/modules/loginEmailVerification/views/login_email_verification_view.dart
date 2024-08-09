import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/modules/login/controllers/login_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';

import 'package:get/get.dart';

import '../../../components/custom_app_bar.dart';
import '../../../constants/string_constant.dart';
import '../../../services/text_style_util.dart';
import '../controllers/login_email_verification_controller.dart';

class LoginEmailVerificationView extends GetView<LoginEmailVerificationController> {
  const LoginEmailVerificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "",
          leading: Container(),
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
                  Get.find<LoginController>().emailController.text,
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