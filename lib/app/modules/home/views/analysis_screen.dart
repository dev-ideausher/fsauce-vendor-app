import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/dashboard_weekly_data_model.dart';
import 'package:fsauce_vendor_app/app/models/dashboard_yearly_data_model.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

import '../../../models/dashboard_monthly_data_model.dart';

class AnalysisScreen extends GetView<HomeController> {
  Rx<DashboardWeeklyData?>? weeklyData;
  Rx<DashboardData?>? monthlyData;
  Rx<DashboardYearlyData?>? yearlyData;

  AnalysisScreen({
    super.key,
    this.weeklyData,
    this.monthlyData,
    this.yearlyData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.kheightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 113.kh,
              width: 44.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        color: context.borderColor1.withOpacity(0.4))
                  ]),
              child: Center(
                child: Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      weeklyData != null
                          ? Text(
                              weeklyData!.value!.cards!.totalCoupons
                                      .toString() ??
                                  "0",
                              style: TextStyleUtil.manrope24w700(
                                  color: context.primary01),
                            )
                          : monthlyData != null
                              ? Text(
                                  monthlyData!.value!.cards!.totalCoupons
                                          .toString() ??
                                      "0",
                                  style: TextStyleUtil.manrope24w700(
                                      color: context.primary01),
                                )
                              : yearlyData != null
                                  ? Text(
                                      yearlyData!.value!.cards!.totalCoupons
                                              .toString() ??
                                          "0",
                                      style: TextStyleUtil.manrope24w700(
                                          color: context.primary01),
                                    )
                                  : Text("0",
                                      style: TextStyleUtil.manrope24w700(
                                          color: context.primary01)),
                      5.kheightBox,
                      Text(
                        StringConstant.totalStamCollected,
                        textAlign: TextAlign.center,
                        style: TextStyleUtil.manrope14w500(),
                      )
                    ],
                  );
                }),
              ),
            ),
            Container(
              height: 113.kh,
              width: 44.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        color: context.borderColor1.withOpacity(0.4))
                  ]),
              child: Center(
                child: Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      weeklyData != null
                          ? Text(
                              weeklyData!.value!.cards!.totalRewards
                                      .toString() ??
                                  "0",
                              style: TextStyleUtil.manrope24w700(
                                  color: context.primary01),
                            )
                          : monthlyData != null
                              ? Text(
                                  monthlyData!.value!.cards!.totalRewards
                                          .toString() ??
                                      "0",
                                  style: TextStyleUtil.manrope24w700(
                                      color: context.primary01),
                                )
                              : yearlyData != null
                                  ? Text(
                                      yearlyData!.value!.cards!.totalRewards
                                              .toString() ??
                                          "0",
                                      style: TextStyleUtil.manrope24w700(
                                          color: context.primary01),
                                    )
                                  : Text("0",
                                      style: TextStyleUtil.manrope24w700(
                                          color: context.primary01)),
                      5.kheightBox,
                      Text(
                        StringConstant.totalRewardsRedeemed,
                        textAlign: TextAlign.center,
                        style: TextStyleUtil.manrope14w500(),
                      )
                    ],
                  );
                }),
              ),
            )
          ],
        ),
        12.kheightBox,
        Row(
          children: [
            Container(
              height: 113.kh,
              width: 44.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        color: context.borderColor1.withOpacity(0.4))
                  ]),
              child: Center(
                child: Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      weeklyData != null
                          ? Text(
                              weeklyData!.value!.cards!.totalCoupons
                                      .toString() ??
                                  "0",
                              style: TextStyleUtil.manrope24w700(
                                  color: context.primary01),
                            )
                          : monthlyData != null
                              ? Text(
                                  monthlyData!.value!.cards!.totalCoupons
                                          .toString() ??
                                      "0",
                                  style: TextStyleUtil.manrope24w700(
                                      color: context.primary01),
                                )
                              : yearlyData != null
                                  ? Text(
                                      yearlyData!.value!.cards!.totalCoupons
                                              .toString() ??
                                          "0",
                                      style: TextStyleUtil.manrope24w700(
                                          color: context.primary01),
                                    )
                                  : Text("0",
                                      style: TextStyleUtil.manrope24w700(
                                          color: context.primary01)),
                      5.kheightBox,
                      Text(
                        StringConstant.totalCouponRedemption,
                        textAlign: TextAlign.center,
                        style: TextStyleUtil.manrope14w500(),
                      )
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
        20.kheightBox,
        // CouponAnalysisCard(
        //   title: StringConstant.couponAnalysis,
        //   weeklyDataCouponCounts: weeklyData!.value!.couponCounts.obs,
        // ),
        // 20.kheightBox,
        // const CouponAnalysisCard(
        //   title: StringConstant.stampscollected,
        // ),
        // 20.kheightBox,
        // const CouponAnalysisCard(
        //   title: StringConstant.rewardsRedeemed,
        // ),
        270.kheightBox,
      ],
    );
  }
}
