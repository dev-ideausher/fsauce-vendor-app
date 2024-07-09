import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_button_with_border.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.kw),
          child: Column(
            children: [
              30.kheightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 4, // adjust elevation as needed
                      backgroundColor: context.primary06, // background color
                    ),
                    onPressed: controller.gotoSignupScreen,
                    child: SizedBox(
                      height: 37.kh,
                      width: 77.kw,
                      child: Center(
                        child: Text(
                          StringConstant.skip,
                          style: TextStyleUtil.manrope14w500(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 56.h,
                width: 100.w,
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: (value) {
                    controller.changePageCount(n: value);
                  },
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        30.kheightBox,
                        const Spacer(),
                        Text(
                          StringConstant.onboardingHeading1,
                          textAlign: TextAlign.start,
                          style: TextStyleUtil.manrope24w700(),
                        ),
                        16.kheightBox,
                        Text(
                          StringConstant.onboardingSubHeading1,
                          textAlign: TextAlign.start,
                          style: TextStyleUtil.manrope16w400(
                            color: context.black03,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        30.kheightBox,
                        const Spacer(),
                        Text(
                          StringConstant.onboardingHeading1,
                          textAlign: TextAlign.start,
                          style: TextStyleUtil.manrope24w700(),
                        ),
                        16.kheightBox,
                        Text(
                          StringConstant.onboardingSubHeading1,
                          textAlign: TextAlign.start,
                          style: TextStyleUtil.manrope16w400(
                            color: context.black03,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        30.kheightBox,
                        const Spacer(),
                        Text(
                          StringConstant.onboardingHeading1,
                          textAlign: TextAlign.start,
                          style: TextStyleUtil.manrope24w700(),
                        ),
                        16.kheightBox,
                        Text(
                          StringConstant.onboardingSubHeading1,
                          textAlign: TextAlign.start,
                          style: TextStyleUtil.manrope16w400(
                            color: context.black03,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              30.kheightBox,
              const PageIndicator(),
              50.kheightBox,
              CustomRedElevatedButton(
                onPressed: controller.gotoLoginScreen,
                buttonText: StringConstant.login,
                textStyle: TextStyleUtil.manrope16w500(color: Colors.white),
                height: 56.kh,
                width: 100.w,
              ),
              10.kheightBox,
              CustomRedElevatedButtonWithBorder(
                onPressed: controller.gotoSignupScreen,
                buttonText: StringConstant.signup,
                textStyle: TextStyleUtil.manrope16w500(color: context.primary01),
                height: 56.kh,
                width: 100.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    return Obx(() => Row(
          children: [0, 1, 2]
              .map((e) => Padding(
                    padding: EdgeInsets.only(right: 10.kw),
                    child: Container(
                      height: 10.kh,
                      width: 10.kw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.kw),
                          color: controller.pageCount.value == e
                              ? context.primary03
                              : context.primary07),
                    ),
                  ))
              .toList(),
        ));
  }
}
