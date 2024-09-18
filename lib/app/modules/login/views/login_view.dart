import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/custom_button.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../../../components/fsv_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(left: 16.kw, right: 16.kw, top: 88.kh),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringConstant.login,
                  style: TextStyleUtil.manrope32w700(),
                ),
                Text(
                  StringConstant.enterYourLoginDetails,
                  style: TextStyleUtil.manrope16w400(color: context.black03),
                ),
                40.kheightBox,
                Text(
                  StringConstant.emailId,
                  style: TextStyleUtil.manrope14w500(),
                ),
                6.kheightBox,
                FsvTextfield(
                  hintText: StringConstant.enterEmailId,
                  controller: controller.emailController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s'))
                  ],
                  onchanged: (val) {
                    if (val != null) {
                      controller.isLoginEnabled.value = true;
                    } else {
                      controller.isLoginEnabled.value = false;
                    }
                  },
                  validator: (val) => controller.validateEmail(val),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                20.kheightBox,
                Text(
                  StringConstant.password,
                  style: TextStyleUtil.manrope14w500(),
                ),
                6.kheightBox,
                Obx(
                  () => FsvTextfield(
                    hintText: StringConstant.enterPassword,
                    onchanged: (val) {
                      if (val != null) {
                        controller.isLoginEnabled.value = true;
                      } else {
                        controller.isLoginEnabled.value = false;
                      }
                    },
                    obscureText: controller.passwordVisible.value,
                    controller: controller.passwordController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ],
                    isSuffixPaddingNeeded: false,
                    validator: (val) => controller.passwordValidator(val),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    suffix: controller.passwordVisible.value
                        ? Icon(
                            Icons.visibility_off,
                            size: 18.kw,
                          )
                        : Icon(
                            Icons.remove_red_eye_rounded,
                            size: 18.kw,
                          ),
                    onPressedSuffix: () {
                      controller.togglePasswordVisible();
                    },
                  ),
                ),
                6.kheightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: controller.gotoForgotPasswordScreen,
                        child: Text(
                          StringConstant.forgotPassword,
                          style: TextStyleUtil.manrope14w400(
                            color: context.black03,
                          ),
                        )),
                  ],
                ),
                20.kheightBox,
                Obx(
                  () => FsvButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.isLoginEnabled.value
                            ? controller.login()
                            : () {};
                      } else {
                        () {};
                      }
                    },
                    isActive: controller.isLoginEnabled.value,
                    label: StringConstant.login,
                  ),
                ),
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
                          return InkWell(
                            onTap: () {
                              controller.loginWithApple();
                            },
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
                      InkWell(
                        onTap: () {
                          controller.loginWithFacebook();
                        },
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
                      InkWell(
                        onTap: () {
                          controller.loginWithGoogle();
                        },
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
                    Column(
                      children: [
                        Text(
                          StringConstant.dontHaveAccount,
                          style: TextStyleUtil.manrope14w500(
                            color: context.black04,
                          ),
                        ),
                        InkWell(
                          onTap: controller.replaceLoginWithSignup,
                          child: Text(
                            StringConstant.createAccount,
                            style: TextStyleUtil.manrope14w600(
                              color: context.primary01,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                30.kheightBox,
              ],
            ),
          ),
        ));
  }
}
