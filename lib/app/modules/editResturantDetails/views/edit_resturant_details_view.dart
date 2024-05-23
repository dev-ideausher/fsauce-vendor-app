import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/custom_button_with_border.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../controllers/edit_resturant_details_controller.dart';

class EditResturantDetailsView extends GetView<EditResturantDetailsController> {
  const EditResturantDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: StringConstant.restaurantDetails,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.kw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.kheightBox,
                Row(
                  children: [
                    Text(
                      StringConstant.restaurantName,
                      style: TextStyleUtil.manrope14w500(),
                    ),
                    Text(
                      "*",
                      style:
                          TextStyleUtil.manrope14w500(color: context.primary01),
                    )
                  ],
                ),
                6.kheightBox,
                CustomTextField(
                    fillColor: context.loginSignupTextfieldColor,
                    border: Border.all(color: context.black07),
                    hintText: StringConstant.enterRestaurantName),
                20.kheightBox,
                Row(
                  children: [
                    Text(
                      StringConstant.restaurantLogo,
                      style: TextStyleUtil.manrope14w500(),
                    ),
                    Text(
                      "*",
                      style:
                          TextStyleUtil.manrope14w500(color: context.primary01),
                    )
                  ],
                ),
                Text(
                  StringConstant.pngJpgJpeg,
                  style: TextStyleUtil.manrope14w500(color: context.black03),
                ),
                6.kheightBox,
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 100.w,
                    height: 100.kh,
                    decoration: BoxDecoration(
                      color: context.loginSignupTextfieldColor,
                      borderRadius: BorderRadius.circular(8.kw),
                      border: RDottedLineBorder.all(
                        color: context.black07,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.file_upload_outlined),
                        10.kheightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              StringConstant.uploadFile,
                              style: TextStyleUtil.manrope14w500(
                                  color: context.primary01),
                            ),
                            4.kwidthBox,
                            Text(
                              StringConstant.or,
                              style: TextStyleUtil.manrope14w500(
                                  color: context.black04),
                            ),
                            4.kwidthBox,
                            Text(
                              StringConstant.selectFile,
                              style: TextStyleUtil.manrope14w500(
                                  color: context.primary01),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                10.kheightBox,
                Row(
                  children: [
                    Text(
                      StringConstant.restaurantBannerImage,
                      style: TextStyleUtil.manrope14w500(),
                    ),
                    Text(
                      "*",
                      style:
                          TextStyleUtil.manrope14w500(color: context.primary01),
                    )
                  ],
                ),
                6.kheightBox,
                Container(
                  height: 160.kh,
                  width: 100.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: context.black07),
                      borderRadius: BorderRadius.circular(8.kw),
                      color: context.loginSignupTextfieldColor),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_upload_outlined),
                        2.kwidthBox,
                        Text(
                          StringConstant.uploadPhoto,
                          style: TextStyleUtil.manrope14w400(
                              color: context.black03),
                        )
                      ],
                    ),
                  ),
                ),
                20.kheightBox,
                Row(
                  children: [
                    Text(
                      StringConstant.address,
                      style: TextStyleUtil.manrope14w500(),
                    ),
                    Text(
                      "*",
                      style:
                          TextStyleUtil.manrope14w500(color: context.primary01),
                    )
                  ],
                ),
                10.kheightBox,
                CustomTextField(
                    fillColor: context.loginSignupTextfieldColor,
                    border: Border.all(color: context.black07),
                    hintText: StringConstant.enterAddress),
                20.kheightBox,
                Row(
                  children: [
                    Text(
                      StringConstant.avgPriceFor2,
                      style: TextStyleUtil.manrope14w500(),
                    ),
                    Text(
                      "*",
                      style:
                          TextStyleUtil.manrope14w500(color: context.primary01),
                    )
                  ],
                ),
                10.kheightBox,
                CustomTextField(
                    fillColor: context.loginSignupTextfieldColor,
                    border: Border.all(color: context.black07),
                    hintText: StringConstant.enterAddress),
                20.kheightBox,
                Row(
                  children: [
                    Text(
                      StringConstant.description,
                      style: TextStyleUtil.manrope14w500(),
                    ),
                  ],
                ),
                10.kheightBox,
                CustomTextField(
                    fillColor: context.loginSignupTextfieldColor,
                    border: Border.all(color: context.black07),
                    hintText: StringConstant.enterDescription),
                40.kheightBox,
                CustomRedElevatedButton(
                    buttonText: StringConstant.save,
                    height: 56.kh,
                    width: 100.w,
                    onPressed: Get.back),
                16.kheightBox,
                CustomRedElevatedButtonWithBorder(
                    buttonText: StringConstant.deleteAccount,
                    width: 100.w,
                    height: 56.kh,
                    onPressed: () {}),
                40.kheightBox,
              ],
            ),
          ),
        ));
  }
}
