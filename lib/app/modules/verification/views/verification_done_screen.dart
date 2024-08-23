import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/verification_controller.dart';

class VerificationDoneScreen extends GetView<VerificationController> {
  const VerificationDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16), // Adjust padding as needed
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(child: Container()),
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
                  Get.offAllNamed(Routes.PROFILE_SETUP);
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
