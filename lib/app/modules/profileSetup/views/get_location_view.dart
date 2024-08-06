import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/profileSetup/controllers/profile_setup_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

class GetLocationView extends StatelessWidget {
  const GetLocationView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileSetupController>();
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.kw),
          child: SizedBox(
            width: 100.w,
            child: Column(
              children: [
                30.kheightBox,
                Image.asset(ImageConstant.enableLocation),
                20.kheightBox,
                Text(
                  StringConstant.enableLocation,
                  style: TextStyleUtil.manrope24w600(),
                ),
                10.kheightBox,
                Text(
                  StringConstant.enableLocationText,
                  textAlign: TextAlign.center,
                  style: TextStyleUtil.manrope16w400(color: context.black03),
                ),
                const Spacer(),
                CustomRedElevatedButton(
                    buttonText: StringConstant.allowAccess,
                    height: 56.kh,
                    width: 100.w,
                    onPressed: (){}),
                20.kheightBox,
              ],
            ),
          ),
        ));
  }
}
