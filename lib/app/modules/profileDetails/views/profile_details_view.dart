import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/profile_option.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/profile_details_controller.dart';

class ProfileDetailsView extends GetView<ProfileDetailsController> {
  const ProfileDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstant.profile,
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
                        style:
                            TextStyleUtil.manrope14w400(color: context.black03),
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
                        style:
                            TextStyleUtil.manrope14w400(color: context.black03),
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
                        style:
                            TextStyleUtil.manrope14w400(color: context.black03),
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
              onTap: controller.gotoEditRestaurantDetailsScreen,
              text: StringConstant.restaurantDetails,
            ),
            10.kheightBox,
            ProfileOption(
              svgPath: ImageConstant.lockIcon,
              onTap: controller.gotoFeaturesAndTimingScreen,
              text: StringConstant.featuresTimings,
            ),
            10.kheightBox,
            ProfileOption(
              svgPath: ImageConstant.imageIcon2,
              onTap: () {},
              text: StringConstant.allPhotosAndVideos,
            ),
            10.kheightBox,
          ],
        ),
      ),
    );
  }
}
