import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/modules/home/views/chart.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:get/get.dart';

import '../../../components/empty_widget.dart';
import '../../../constants/string_constant.dart';
import '../../../services/text_style_util.dart';
import '../controllers/home_controller.dart';

class YearlyAnalysis extends GetView<HomeController>{
  const YearlyAnalysis({super.key});

  @override
  Widget build(BuildContext context){
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      if(controller.yearlyData.value.cards != null && controller.yearlyData.value.cards!.totalStamps != null){
                        return Text(
                          controller.yearlyData.value.cards!.totalStamps.toString(),
                          style:
                          TextStyleUtil.manrope24w700(color: context.primary01),
                        );
                      } else{
                        return Text(
                          "0",
                          style:
                          TextStyleUtil.manrope24w700(color: context.primary01),
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
                )
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      if(controller.yearlyData.value.cards != null && controller.yearlyData.value.cards!.totalRewards != null){
                        return Text(
                          controller.yearlyData.value.cards!.totalRewards.toString(),
                          style:
                          TextStyleUtil.manrope24w700(color: context.primary01),
                        );
                      } else{
                        return Text(
                          "0",
                          style:
                          TextStyleUtil.manrope24w700(color: context.primary01),
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
                )
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      if(controller.yearlyData.value.cards != null && controller.yearlyData.value.cards!.totalCoupons != null){
                        return Text(
                          controller.yearlyData.value.cards!.totalCoupons.toString(),
                          style:
                          TextStyleUtil.manrope24w700(color: context.primary01),
                        );
                      } else{
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
                )
              ),
            ),
          ],
        ),
        20.kheightBox,
        Obx(() {
          if(controller.yearlyCouponChartData.isNotEmpty){
            return CouponAnalysisCard(
              title: StringConstant.couponAnalysis,
              graphData: controller.yearlyCouponChartData,
            );
          } else{
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16.0), child: Center(child: EmptyWidget())));
          }
        }),
        20.kheightBox,
        Obx(() {
          if(controller.yearlyStampsChartData.isNotEmpty){
            return CouponAnalysisCard(
              title: StringConstant.couponAnalysis,
              graphData: controller.yearlyStampsChartData,
            );
          } else{
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16.0), child: Center(child: EmptyWidget())));
          }
        }),
        20.kheightBox,
        Obx(() {
          if(controller.yearlyRewardsChartData.isNotEmpty){
            return CouponAnalysisCard(
              title: StringConstant.couponAnalysis,
              graphData: controller.yearlyRewardsChartData,
            );
          } else{
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16.0), child: Center(child: EmptyWidget())));
          }
        }),
        270.kheightBox,
      ],
    );
  }
}