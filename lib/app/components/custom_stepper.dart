import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({super.key, required this.activeStep});
  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      activeStepTextColor: Colors.black87,
      finishedStepTextColor: Colors.white,
      activeStepBackgroundColor: context.primary01,
      finishedStepBackgroundColor: context.primary01,
      unreachedStepBackgroundColor: context.primary07,
      internalPadding: 0,
      lineStyle: LineStyle(
          defaultLineColor: context.primary07,
          finishedLineColor: context.primary01,
          lineLength: 28.w,
          lineType: LineType.normal),
      showLoadingAnimation: false,
      stepRadius: 20,
      showStepBorder: false,
      steps: [
        EasyStep(
            customStep: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Text(
            "1",
            style: TextStyleUtil.manrope18w500(
              color: activeStep >= 0 ? Colors.white : context.primary04,
            ),
          ),
        )),
        EasyStep(
            customStep: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Text(
            "2",
            style: TextStyleUtil.manrope18w500(
              color: activeStep >= 1 ? Colors.white : context.primary04,
            ),
          ),
        )),
        EasyStep(
            customStep: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Text(
            "3",
            style: TextStyleUtil.manrope18w500(
              color: activeStep >= 2 ? Colors.white : context.primary04,
            ),
          ),
        )),
      ],
    );
  }
}
