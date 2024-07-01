import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/home/views/chart.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "0",
                      style:
                          TextStyleUtil.manrope24w700(color: context.primary01),
                    ),
                    5.kheightBox,
                    Text(
                      StringConstant.totalStamCollected,
                      textAlign: TextAlign.center,
                      style: TextStyleUtil.manrope14w500(),
                    )
                  ],
                ),
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
                    Text(
                      "0",
                      style:
                          TextStyleUtil.manrope24w700(color: context.primary01),
                    ),
                    5.kheightBox,
                    Text(
                      StringConstant.totalRewardsRedeemed,
                      textAlign: TextAlign.center,
                      style: TextStyleUtil.manrope14w500(),
                    )
                  ],
                ),
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
                    Text(
                      "0",
                      style:
                          TextStyleUtil.manrope24w700(color: context.primary01),
                    ),
                    5.kheightBox,
                    Text(
                      StringConstant.totalCouponRedemption,
                      textAlign: TextAlign.center,
                      style: TextStyleUtil.manrope14w500(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        20.kheightBox,
        CouponAnalysisCard(
          title: StringConstant.couponAnalysis,
        ),
        20.kheightBox,
        CouponAnalysisCard(
          title: StringConstant.stampscollected,
        ),
        20.kheightBox,
        CouponAnalysisCard(
          title: StringConstant.rewardsRedeemed,
        ),
        270.kheightBox,
      ],
    );
  }
}
