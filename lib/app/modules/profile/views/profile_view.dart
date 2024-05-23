import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/profile_option.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstant.profile,
            style: TextStyleUtil.manrope18w600(),
          ),
          leading: const SizedBox(),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16.kw, right: 16.kw, top: 16.kh),
          child: Column(
            children: [
              Container(
                height: 181.kh,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: context.borderColor1, blurRadius: 16)
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    2.kheightBox,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(44),
                      child: CommonImageView(
                          height: 88,
                          width: 88,
                          fit: BoxFit.cover,
                          url:
                              "https://w7.pngwing.com/pngs/870/682/png-transparent-domino-s-pizza-logo-domino-s-pizza-pizza-delivery-logo-pizza-domino-s-pizza-pizza-pizza-pizza-delivery.png"),
                    ),
                    Text(
                      "Domino’s Pizza",
                      style: TextStyleUtil.manrope16w600(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pizza",
                          style: TextStyleUtil.manrope14w400(
                              color: context.black03),
                        ),
                        5.kwidthBox,
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: context.black01),
                        ),
                        5.kwidthBox,
                        Text(
                          "Italian",
                          style: TextStyleUtil.manrope14w400(
                              color: context.black03),
                        ),
                        5.kwidthBox,
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: context.black01),
                        ),
                        5.kwidthBox,
                        Text(
                          "Fast Food",
                          style: TextStyleUtil.manrope14w400(
                              color: context.black03),
                        )
                      ],
                    ),
                    2.kheightBox,
                  ],
                ),
              ),
              20.kheightBox,
              ProfileOption(
                svgPath: ImageConstant.userDetailsIcon,
                onTap: controller.gotoProfileDetailsScreen,
                text: StringConstant.restaurantDetails,
              ),
              10.kheightBox,
              ProfileOption(
                svgPath: ImageConstant.lockIcon,
                onTap: controller.gotoChangePasswordScreen,
                text: StringConstant.changePassword,
              ),
              10.kheightBox,
              ProfileOption(
                svgPath: ImageConstant.scanRedump,
                onTap: () {},
                text: StringConstant.scanRedemptionRecord,
              ),
              10.kheightBox,
              ProfileOption(
                svgPath: ImageConstant.pushNotificaion,
                onTap: () {},
                text: StringConstant.pushNotifications,
              ),
              ProfileOption(
                svgPath: ImageConstant.helpAndSupport,
                onTap: controller.gotoHelpAndSupportScreen,
                text: StringConstant.helpAndSupport,
              ),
              10.kheightBox,
              ProfileOption(
                svgPath: ImageConstant.logout,
                onTap: controller.showLogoutDialog,
                text: StringConstant.logout,
              ),
              10.kheightBox,
            ],
          ),
        ));
  }
}
