import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/changePassword/controllers/change_password_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

class ChangePasswordDoneScreen extends GetView<ChangePasswordController> {
  const ChangePasswordDoneScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(16.kw),
      child: SizedBox(
        width: 100.w,
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            CommonImageView(
              svgPath: ImageConstant.completeTick,
            ),
            20.kheightBox,
            Text(
              StringConstant.passwordChanged,
              style: TextStyleUtil.manrope24w600(),
            ),
            10.kheightBox,
            Text(
              StringConstant.passwordChangeComplete,
              textAlign: TextAlign.center,
              style: TextStyleUtil.manrope16w400(color: context.black03),
            ),
            const Spacer(),
            CustomRedElevatedButton(
                buttonText: StringConstant.login,
                height: 56.kh,
                width: 100.w,
                onPressed: () {}),
            20.kheightBox,
          ],
        ),
      ),
    ));
  }
}
