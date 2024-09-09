import 'package:dotted_border/dotted_border.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_stepper.dart';
import 'package:fsauce_vendor_app/app/components/custom_text_box.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../controllers/profile_setup_controller.dart';

class ProfileSetupView extends GetView<ProfileSetupController> {
  const ProfileSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.kw),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  54.kheightBox,
                  Text(
                    StringConstant.profileSetup,
                    style: TextStyleUtil.manrope32w700(),
                  ),
                  Text(
                    StringConstant.enterProfileDetails,
                    style: TextStyleUtil.manrope16w400(
                      color: context.black03,
                    ),
                  ),
                  20.kheightBox,
                  CustomStepper(activeStep: controller.stepCount.value),
                  controller.steps[controller.stepCount.value],
                  40.kheightBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
