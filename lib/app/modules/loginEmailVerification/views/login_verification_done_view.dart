import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/modules/loginEmailVerification/controllers/login_email_verification_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';

import 'package:get/get.dart';

import '../../../components/common_image_view.dart';
import '../../../components/custom_red_elevated_button.dart';
import '../../../constants/image_constant.dart';
import '../../../constants/string_constant.dart';
import '../../../services/text_style_util.dart';

class LoginEmailVerificationDone extends GetView<LoginEmailVerificationController> {
  const LoginEmailVerificationDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16), // Adjust padding as needed
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              30.kheightBox,
              CommonImageView(
                svgPath: ImageConstant.completeTick,
              ),
              20.kheightBox,
              Text(
                StringConstant.woohoo,
                style: TextStyleUtil.manrope24w600(),
              ),
              10.kheightBox,
              Text(
                StringConstant.registrationComplete,
                textAlign: TextAlign.center,
                style: TextStyleUtil.manrope16w400(color: context.black03),
              ),
              Spacer(),
              CustomRedElevatedButton(
                buttonText: StringConstant.continuee,
                height: 56.kh,
                width: double.infinity,
                onPressed: () {
                  controller.gotoProfileSetupScreen();
                },
              ),
              20.kheightBox,
            ],
          ),
        ),
      ),
    );
  }
}
