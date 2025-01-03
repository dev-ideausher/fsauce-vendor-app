import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/filer_animated_options.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/controllers/profile_setup_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../components/custom_red_elevated_button.dart';
import '../../../models/feature_model.dart';

class StepTwo extends GetView<ProfileSetupController> {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              StringConstant.features,
              style: TextStyleUtil.manrope14w500(),
            ),
            Text(
              "*",
              style: TextStyleUtil.manrope14w500(color: context.primary01),
            )
          ],
        ),
        8.kheightBox,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: context.loginSignupTextfieldColor,
              borderRadius: BorderRadius.circular(8.kw),
              border: Border.all(color: context.black07)),
          child: MultiSelectDialogField(
            items: controller.multiSelectFeatures,
            title: Text(
              StringConstant.enterFeatures,
              style: TextStyleUtil.manrope16w400(),
            ),
            selectedColor: context.primary01,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.kw),
              border: Border.all(color: Colors.transparent),
            ),
            buttonIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
            ),
            buttonText: Text(
              StringConstant.enterFeatures,
              style: TextStyleUtil.manrope14w400(color: context.black04),
            ),
            onConfirm: (results) {
              controller.selectedFeatures.value = results;
            },
          ),
        ),
        10.kheightBox,
        Row(
          children: [
            Text(
              StringConstant.timings,
              style: TextStyleUtil.manrope14w500(),
            ),
            Text(
              "*",
              style: TextStyleUtil.manrope14w500(color: context.primary01),
            )
          ],
        ),
        8.kheightBox,
        ...[
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday"
        ].map((e) =>
            FilterAnimatedOption(
              title: e,
              controller: controller.timingControllers[e]!,
            )),
        40.kheightBox,
        Obx(() {
          return CustomRedElevatedButton(
              buttonText: controller.stepCount.value < 2
                  ? StringConstant.next
                  : StringConstant.continuee,
              height: 56.kh,
              width: 100.w,
              onPressed: () {
                if (controller.selectedFeatures.isNotEmpty) {
                  controller.stepCount.value < 2
                      ? controller.gotoNextStep()
                      : controller.gotoEnableLocationScreen();
                } else {
                  Get.snackbar("Error",
                      StringConstant.plsSelectFeaturesAndTimings);
                }
              });
        }),
        30.kheightBox,
      ],
    );
  }
}
