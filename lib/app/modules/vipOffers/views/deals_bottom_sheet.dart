import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/controllers/vip_offers_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class DealsBottomSheet extends GetView<VipOffersController> {
  const DealsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(16.kw),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.kw),
              topRight: Radius.circular(24.kw))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 5.kh,
                width: 64.kw,
                decoration: BoxDecoration(
                    color: context.black01,
                    borderRadius: BorderRadius.circular(3)),
              ),
            ],
          ),
          20.kheightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringConstant.couponDetails,
                style: TextStyleUtil.manrope18w600(),
              ),
            ],
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.only(top: 10.kh),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: context.borderColor1)),
                boxShadow: [BoxShadow(color: context.borderColor1)],
                borderRadius: BorderRadius.circular(8.kw)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.kheightBox,
                Padding(
                  padding:
                      EdgeInsets.only(left: 14.kw, right: 2.kw, bottom: 10.kh),
                  child: Row(
                    children: [
                      CommonImageView(
                        svgPath: ImageConstant.percentOff,
                      ),
                      20.kwidthBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Flat 20% OFF ",
                            style: TextStyleUtil.manrope16w600(),
                          ),
                          SizedBox(
                            width: 40.w,
                            child:
                                const Text("Save upto £20 with this coupon."),
                          )
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 24.kh,
                        width: 24.kw,
                        margin: EdgeInsets.all(10.kw),
                        decoration: BoxDecoration(
                            color: context.primary07,
                            borderRadius: BorderRadius.circular(12.kw)),
                        child: Center(
                          child: Icon(
                            Icons.favorite_outline,
                            size: 16.kw,
                            color: context.primary01,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          20.kheightBox,
          Text(
            StringConstant.termsAndConditions,
            style: TextStyleUtil.manrope16w500(),
          ),
          20.kheightBox,
          ...[
            "Valid for dine-in only",
            "Valid till 31st March 2024",
            "Minimum purchase of £80 required. ",
            "Minimum purchase of £80 required. ",
            "Coupon cannot be clubbed with other offers.",
          ].map((e) => Padding(
                padding: EdgeInsets.symmetric(vertical: 5.kh),
                child: Row(
                  children: [
                    Container(
                      height: 16.kh,
                      width: 16.kw,
                      decoration: BoxDecoration(
                          color: context.primary03,
                          borderRadius: BorderRadius.circular(8.kw)),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: context.primary07,
                          size: 13.ksp,
                        ),
                      ),
                    ),
                    10.kwidthBox,
                    Text(
                      e,
                      style:
                          TextStyleUtil.manrope14w400(color: context.black02),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
