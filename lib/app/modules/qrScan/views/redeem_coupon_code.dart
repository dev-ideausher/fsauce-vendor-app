import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/components/fsv_textfield.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:get/get.dart';

import '../../../constants/string_constant.dart';
import '../../../services/text_style_util.dart';
import '../controllers/qr_scan_controller.dart';

class RedeemCouponCode extends GetView<QrScanController> {
  RedeemCouponCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstant.redeemCouponCode,
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              75.kheightBox,
              Text(StringConstant.enterCodeBelow,
                  style: TextStyleUtil.manrope14w500(color: context.black04)),
              75.kheightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    StringConstant.couponCode,
                    style: TextStyleUtil.manrope14w500(color: context.black01),
                  )),
              5.kheightBox,
              FsvTextfield(
                hintText: StringConstant.enterCouponCode,
                controller: controller.couponCodeController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onchanged: (String? val) {
                  if (val == null || val.isEmpty) {
                    controller.canRedeem.value = false;
                  } else if (val.isNotEmpty) {
                    controller.canRedeem.value = true;
                  }
                },
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return "Coupon code empty!";
                  }
                  return null;
                },
              ),
              const Expanded(child: SizedBox()),
              Obx(() {
                return CustomRedElevatedButton(
                    buttonColor:
                        controller.canRedeem.value ? null : context.primary06,
                    textStyle: controller.canRedeem.value
                        ? null
                        : TextStyleUtil.manrope16w500(color: context.black03),
                    buttonText: StringConstant.redeem,
                    height: 56.kh,
                    width: 100.w,
                    onPressed: () {
                      if (controller.formKey.currentState!.validate() &&
                          controller.canRedeem.value) {
                        //ToDo: Implement code redemption.
                        controller.redeemCode();
                      }
                    });
              }).paddingOnly(bottom: 40.kh),
            ],
          ),
        ),
      ),
    );
  }
}
