import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/profile_option.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/home/views/analysis_screen.dart';
import 'package:fsauce_vendor_app/app/modules/home/views/monthly_analysis.dart';
import 'package:fsauce_vendor_app/app/modules/home/views/weekly_analysis.dart';
import 'package:fsauce_vendor_app/app/modules/home/views/yearly_analysis.dart';
import 'package:fsauce_vendor_app/app/modules/navBar/controllers/nav_bar_controller.dart';
import 'package:fsauce_vendor_app/app/modules/navBar/views/nav_bar_view.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getRestaurantDetails();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 155.kh,
              width: 100.w,
              child: Stack(
                children: [
                  Container(
                    height: 155.kh,
                    width: 100.w,
                    padding:
                    EdgeInsets.only(top: 79.kh, left: 16.kw, right: 16.kw),
                    decoration: BoxDecoration(
                      color: context.primary02,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.kw),
                        bottomRight: Radius.circular(8.kw),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      StringConstant.welcome,
                                      style: TextStyleUtil.manrope24w600(
                                          color: Colors.white),
                                    ),
                                    4.kwidthBox,
                                    Obx(() {
                                      return Text(
                                        controller.restaurantDetails.value
                                            .restaurantName,
                                        style: TextStyleUtil.manrope24w600(
                                            color: Colors.white),
                                      );
                                    }),
                                  ],
                                ),
                                InkWell(
                                  onTap: Get
                                      .find<HomeController>()
                                      .showLocationBottomSheet,
                                  child: Row(
                                    children: [
                                      CommonImageView(
                                        svgPath: ImageConstant.locationIcon,
                                      ),
                                      4.kwidthBox,
                                      Obx(() {
                                        return Text(
                                          controller.restaurantDetails.value
                                              .location,
                                          style: TextStyleUtil.manrope14w400(
                                            color: Colors.white,
                                            textDecoration:
                                            TextDecoration.underline,
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed:
                              Get
                                  .find<HomeController>()
                                  .gotoNotifications,
                              padding: const EdgeInsets.all(0),
                              icon: CommonImageView(
                                svgPath: ImageConstant.notificationIcon,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            20.kheightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.kw),
              child: Column(
                children: [
                  InkWell(
                    onTap: controller.gotoScanQr,
                    child: Container(
                      height: 103.kh,
                      width: 100.w,
                      padding: EdgeInsets.all(16.kw),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.kh),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2.kh,
                            color: context.borderColor1.withOpacity(0.5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                StringConstant.scanQRCode,
                                style: TextStyleUtil.manrope18w600(),
                              ),
                              5.kheightBox,
                              Text(
                                StringConstant.scanQrSub,
                                style: TextStyleUtil.manrope14w400(),
                              ),
                            ],
                          ),
                          const Spacer(),
                          CommonImageView(
                            svgPath: ImageConstant.scanQr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.kheightBox,
                  ProfileOption(
                    svgPath: ImageConstant.jobs,
                    onTap: controller.gotoJobsScreen,
                    text: StringConstant.jobs,
                  ),
                  10.kheightBox,
                  ProfileOption(
                    svgPath: ImageConstant.rating,
                    onTap: controller.goToRestaurantDetails,
                    text: StringConstant.ratingAndFeedbackManagement,
                  ),
                  20.kheightBox,
                  DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        Container(
                          height: 37.kh,
                          decoration: BoxDecoration(
                            color: context.primary07,
                            border: Border.all(color: context.primary06),
                            borderRadius: BorderRadius.circular(20.kh),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 4.kh),
                          child: TabBar(
                            padding: EdgeInsets.zero,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(50.kh), // Creates border
                              color: Colors.white,
                            ),
                            tabs: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.kw, vertical: 4.kh),
                                child: Text(
                                  StringConstant.week,
                                  style: TextStyleUtil.manrope14w500(
                                      color: context.black02),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.kw, vertical: 4.kh),
                                child: Text(
                                  StringConstant.month,
                                  style: TextStyleUtil.manrope14w500(
                                      color: context.black02),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.kw, vertical: 4.kh),
                                child: Text(
                                  StringConstant.year,
                                  style: TextStyleUtil.manrope14w500(
                                      color: context.black02),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                          100.h - 200, // Set a fixed height for TabBarView
                          child: TabBarView(
                            children: [
                              SingleChildScrollView(child: WeeklyAnalysis()),
                              SingleChildScrollView(child: MonthlyAnalysis()),
                              SingleChildScrollView(child: YearlyAnalysis()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
