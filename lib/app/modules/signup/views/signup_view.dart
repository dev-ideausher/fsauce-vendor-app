import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(left: 16.kw, right: 16.kw, top: 88.kh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConstant.createAccount,
                style: TextStyleUtil.manrope32w700(),
              ),
              Text(
                StringConstant.enterYourDetails,
                style: TextStyleUtil.manrope16w400(color: context.black03),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp(r'\s')),
                          ],
                          onChanged: (val) {
                            if (val.isEmpty) {
                              controller.isSignupEnabled.value = false;
                            } else {
                              controller.isSignupEnabled.value = true;
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
              20.kheightBox,
              Text(
                StringConstant.password,
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
                        child: Obx(() {
                          return TextField(
                            maxLength: 64,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(r'\s')),
                            ],
                            onChanged: (val) {
                              if (val.isEmpty) {
                                controller.isSignupEnabled.value = false;
                              } else {
                                controller.isSignupEnabled.value = true;
                              }
                            },
                            obscureText: controller.passwordVisible.value,
                            controller: controller.passwordController,
                            decoration: InputDecoration(
                              counterText: "",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.togglePasswordVisible();
                                  },
                                  icon: controller.passwordVisible.value ? Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 18.kw,
                                  ) : Icon(Icons.visibility_off, size: 18.kw,)
                              ),
                              hintText: StringConstant.enterPassword,
                              hintStyle: TextStyleUtil.manrope14w400(
                                  color: context.black04),
                              border: InputBorder.none,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              30.kheightBox,
              Obx(() {
                return CustomRedElevatedButton(
                    buttonText: StringConstant.signup,
                    height: 56.kh,
                    width: 100.w,
                    textStyle: controller.isSignupEnabled.value && controller.termsAndConditionsChecked.value
                        ? null
                        : TextStyleUtil.manrope16w500(color: context.black03),
                    buttonColor: controller.isSignupEnabled.value && controller.termsAndConditionsChecked.value ? context
                        .primary01 : context.primary06,
                    onPressed: controller.isSignupEnabled.value && controller.termsAndConditionsChecked.value ? controller
                        .signup : () {});
              }),
              20.kheightBox,
              Row(
                children: [
                  Expanded(
                      child: Divider(
                        color: context.black07,
                        thickness: 1.5,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      StringConstant.orsignupWith,
                      style: TextStyleUtil.manrope12w500(
                        color: context.black03,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                        color: context.black07,
                        thickness: 1.5,
                      )),
                ],
              ),
              20.kheightBox,
              Obx(() {
                return Row(
                  mainAxisAlignment: controller.isApple.value
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      if (controller.isApple.value) {
                        return GestureDetector(
                          onTap: controller.signupWithApple,
                          child: Container(
                            height: 48.kh,
                            width: 103.kw,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.kw),
                                border: Border.all(
                                  color: context.black07,
                                )),
                            child: Center(
                              child: CommonImageView(
                                svgPath: ImageConstant.appleLogo,
                                width: 24,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return 0.kwidthBox;
                      }
                    }),
                    GestureDetector(
                      onTap: controller.signupWithFacebook,
                      child: Container(
                        height: 48.kh,
                        width: 103.kw,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.kw),
                            border: Border.all(
                              color: context.black07,
                            )),
                        child: Center(
                          child: CommonImageView(
                            svgPath: ImageConstant.facebookLogo,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                    controller.isApple.value ? Container() : 20.kwidthBox,
                    GestureDetector(
                      onTap: controller.signupWithGoogle,
                      child: Container(
                        height: 48.kh,
                        width: 103.kw,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.kw),
                            border: Border.all(
                              color: context.black07,
                            )),
                        child: Center(
                          child: CommonImageView(
                            svgPath: ImageConstant.googleLogo,
                            width: 24,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringConstant.alreadyHaveAcount,
                    style: TextStyleUtil.manrope14w500(
                      color: context.black04,
                    ),
                  ),
                  InkWell(
                    onTap: controller.replaceSignupWithLogin,
                    child: Text(
                      StringConstant.login,
                      style: TextStyleUtil.manrope14w600(
                        color: context.primary01,
                      ),
                    ),
                  ),
                ],
              ),
              20.kheightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return Checkbox(
                      checkColor: Colors.white,
                      activeColor: context.primary01,
                        value: controller.termsAndConditionsChecked.value,
                        onChanged: (bool? value) {
                          if(value != null){
                            controller.termsAndConditionsChecked.value = value;
                          }
                        }
                    );
                  }),
                  InkWell(
                    onTap: (){
                      controller.goToTermsAndConditions();
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          StringConstant.termsAndcons1,
                          style: TextStyleUtil.manrope12w400(
                            color: context.black01,
                          ),
                        ),
                        Text(
                          StringConstant.termsCons2,
                          style: TextStyleUtil.manrope12w400(
                            color: context.primary01,
                          ),
                        ),
                        Text(
                          StringConstant.and,
                          style: TextStyleUtil.manrope12w400(
                            color: context.black01,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  controller.goToTermsAndConditions();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConstant.privacyPolicy,
                      style: TextStyleUtil.manrope12w400(
                        color: context.primary01,
                      ),
                    ),
                    Text(
                      StringConstant.and,
                      style: TextStyleUtil.manrope12w400(
                        color: context.black01,
                      ),
                    ),
                    Text(
                      StringConstant.contentPolicy,
                      style: TextStyleUtil.manrope12w400(
                        color: context.primary01,
                      ),
                    ),
                  ],
                ),
              ),
              30.kheightBox,
            ],
          ),
        ));
  }
}
