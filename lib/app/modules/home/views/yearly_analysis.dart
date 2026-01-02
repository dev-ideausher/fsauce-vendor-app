import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/modules/home/views/chart.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:get/get.dart';

import '../../../components/empty_widget.dart';
import '../../../constants/string_constant.dart';
import '../../../services/text_style_util.dart';
import '../controllers/home_controller.dart';

class YearlyAnalysis extends GetView<HomeController> {
  const YearlyAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.kheightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.kw),
          child: Row(
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
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      if (controller.yearlyData.value.cards != null &&
                          controller.yearlyData.value.cards!.totalStamps !=
                              null) {
                        return Text(
                          controller.yearlyData.value.cards!.totalStamps
                              .toString(),
                          style: TextStyleUtil.manrope24w700(
                              color: context.primary01),
                        );
                      } else {
                        return Text(
                          "0",
                          style: TextStyleUtil.manrope24w700(
                              color: context.primary01),
                        );
                      }
                    }),
                    5.kheightBox,
                    Text(
                      StringConstant.totalStamCollected,
                      textAlign: TextAlign.center,
                      style: TextStyleUtil.manrope14w500(),
                    )
                  ],
                )),
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
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      if (controller.yearlyData.value.cards != null &&
                          controller.yearlyData.value.cards!.totalRewards !=
                              null) {
                        return Text(
                          controller.yearlyData.value.cards!.totalRewards
                              .toString(),
                          style: TextStyleUtil.manrope24w700(
                              color: context.primary01),
                        );
                      } else {
                        return Text(
                          "0",
                          style: TextStyleUtil.manrope24w700(
                              color: context.primary01),
                        );
                      }
                    }),
                    5.kheightBox,
                    Text(
                      StringConstant.totalRewardsRedeemed,
                      textAlign: TextAlign.center,
                      style: TextStyleUtil.manrope14w500(),
                    )
                  ],
                )),
              )
            ],
          ),
        ),
        8.kheightBox,
        Align(
          alignment: AlignmentGeometry.centerLeft,
          child: Container(
            height: 113.kh,
            width: 44.w,
            margin: EdgeInsetsDirectional.only(start: 16.kw),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      color: context.borderColor1.withOpacity(0.4))
                ]),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  if (controller.yearlyData.value.cards != null &&
                      controller.yearlyData.value.cards!.totalCoupons != null) {
                    return Text(
                      controller.yearlyData.value.cards!.totalCoupons
                          .toString(),
                      style:
                          TextStyleUtil.manrope24w700(color: context.primary01),
                    );
                  } else {
                    return Text(
                      "0",
                      style:
                          TextStyleUtil.manrope24w700(color: context.primary01),
                    );
                  }
                }),
                5.kheightBox,
                Text(
                  StringConstant.totalCouponRedemption,
                  textAlign: TextAlign.center,
                  style: TextStyleUtil.manrope14w500(),
                )
              ],
            )),
          ),
        ),
        20.kheightBox,
        Obx(() {
          return FlBarChartWidget(
            barColor: ColorUtil.kErrorColor,
            title: StringConstant.couponAnalysis,
            graphData: controller.yearlyCouponChartData.isNotEmpty
                ? controller.yearlyCouponChartData
                : [],
          );
        }),
        20.kheightBox,
        Obx(() {
          return FlBarChartWidget(
            barColor: ColorUtil.kErrorColor,
            title: StringConstant.stampscollected,
            graphData: controller.yearlyStampsChartData.isNotEmpty
                ? controller.yearlyStampsChartData
                : [],
          );
        }),
        20.kheightBox,
        Obx(() {
          return FlBarChartWidget(
            barColor: ColorUtil.kErrorColor,
            title: StringConstant.rewardsRedeemed,
            graphData: controller.yearlyRewardsChartData.isNotEmpty
                ? controller.yearlyRewardsChartData
                : [],
          );
        }),
        270.kheightBox,
      ],
    );
  }
}
