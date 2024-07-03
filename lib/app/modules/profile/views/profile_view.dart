import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/profile_option.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
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
                  borderRadius: BorderRadius.circular(8.kh),
                  boxShadow: [
                    BoxShadow(color: context.borderColor1, blurRadius: 16.kh)
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    2.kheightBox,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(44),
                      child: Obx(() {
                        return CommonImageView(
                          height: 88,
                          width: 88,
                          fit: BoxFit.cover,
                          url: Get
                              .find<HomeController>()
                              .restaurantDetails
                              .value
                              .restaurantLogo,
                        );
                      }),
                    ),
                    Obx(() {
                      return Text(
                        Get
                            .find<HomeController>()
                            .restaurantDetails
                            .value
                            .restaurantName,
                        style: TextStyleUtil.manrope16w600(),
                      );
                    }),
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
                          height: 5.kh,
                          width: 5.kh,
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
                          height: 5.kh,
                          width: 5.kh,
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
                onTap: controller.gotoScanRedemptionRecord,
                text: StringConstant.scanRedemptionRecord,
              ),
              10.kheightBox,
              ProfileOption(
                svgPath: ImageConstant.pushNotificaion,
                onTap: controller.gotoPushNotification,
                text: StringConstant.pushNotifications,
              ),
              10.kheightBox,
          InkWell(
            onTap: () {
              controller.gotoSubscriptionScreen();
            },
            child: Container(
              height: 56.kh,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 20.kw),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border(bottom: BorderSide(color: context.borderColor2))),
              child: Row(
                children: [
                  Icon(Icons.monetization_on_outlined, color: context.primary01, size: 22.kh,),
                  16.kwidthBox,
                  Text(
                    StringConstant.subscriptions,
                    style: TextStyleUtil.manrope14w400(),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: context.black01,
                  )
                ],
              ),
            ),
          ),
              10.kheightBox,
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
              InkWell(
                onTap: () {
                  //ToDo: Delete Account
                  controller.showDeleteAccountDialog();
                },
                child: Container(
                  height: 56.kh,
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 20.kw),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border(bottom: BorderSide(color: context.borderColor2))),
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: context.primary01, size: 22.kh,),
                      16.kwidthBox,
                      Text(
                        StringConstant.deleteAccount,
                        style: TextStyleUtil.manrope14w400(),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20.kh,
                        color: context.black01,
                      )
                    ],
                  ),
                ),
              ),
              10.kheightBox,
            ],
          ),
        ));
  }
}
