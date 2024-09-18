import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/coupon_model.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/controllers/vip_offers_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../generated/assets.dart';

class DealsBottomSheet extends GetView<VipOffersController> {
  final Coupon coupon;
  const DealsBottomSheet({required this.coupon, super.key});

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
      child: SingleChildScrollView(
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
            coupon.typeOfOffer != "Normal offer" ? 8.kheightBox : Container(),
            coupon.typeOfOffer != "Normal offer"
                ? Center(
                    child: CommonImageView(
                    svgPath: Assets.svgsDealOfTheDay,
                    width: 143.kw,
                    height: 29.kh,
                  ))
                : Container(),
            coupon.typeOfOffer != "Normal offer" ? 8.kheightBox : Container(),
            Container(
              width: 100.w,
              padding: EdgeInsets.only(top: 10.kh),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(bottom: BorderSide(color: context.borderColor1)),
                  boxShadow: [BoxShadow(color: context.borderColor1)],
                  borderRadius: BorderRadius.circular(8.kw)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.kheightBox,
                  Padding(
                    padding: EdgeInsets.only(
                        left: 14.kw, right: 2.kw, bottom: 10.kh),
                    child: Row(
                      children: [
                        CommonImageView(
                          svgPath: ImageConstant.percentOff,
                        ),
                        20.kwidthBox,
                        Text(
                          coupon.title,
                          style: TextStyleUtil.manrope16w600(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            20.kheightBox,
            coupon.couponCode!.isNotEmpty
                ? Text(
                    StringConstant.couponCode,
                    style: TextStyleUtil.manrope16w500(),
                  )
                : Container(),
            coupon.couponCode!.isNotEmpty ? 4.kheightBox : Container(),
            coupon.couponCode!.isNotEmpty
                ? Text(
                    coupon.couponCode ?? "",
                    style: TextStyleUtil.manrope14w400(color: context.black02),
                  )
                : Container(),
            coupon.couponCode!.isNotEmpty ? 20.kheightBox : Container(),
            Text(
              StringConstant.validTill,
              style: TextStyleUtil.manrope16w500(),
            ),
            4.kheightBox,
            Text(
              coupon.validTill.substring(0, 10),
              style: TextStyleUtil.manrope14w400(color: context.black02),
            ),
            20.kheightBox,
            Text(
              StringConstant.validFor,
              style: TextStyleUtil.manrope16w500(),
            ),
            4.kheightBox,
            Text(
              coupon.typeOfOffer,
              style: TextStyleUtil.manrope14w400(color: context.black02),
            ),
            20.kheightBox,
            Text(
              StringConstant.description,
              style: TextStyleUtil.manrope16w500(),
            ),
            4.kheightBox,
            Wrap(
              children: [
                Text(
                  coupon.description,
                  style: TextStyleUtil.manrope14w400(color: context.black02),
                ),
              ],
            ),
            20.kheightBox,
            Text(
              StringConstant.termsAndConditions,
              style: TextStyleUtil.manrope16w500(),
            ),
            4.kheightBox,
            ...coupon.termsAndConditions.map((e) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.kh),
                  child: Wrap(
                    children: [
                      // Container(
                      //   height: 16.kh,
                      //   width: 16.kw,
                      //   decoration: BoxDecoration(
                      //       color: context.primary03,
                      //       borderRadius: BorderRadius.circular(8.kw)),
                      //   child: Center(
                      //     child: Icon(
                      //       Icons.check,
                      //       color: context.primary07,
                      //       size: 13.ksp,
                      //     ),
                      //   ),
                      // ),
                      // 10.kwidthBox,
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
      ),
    );
  }
}
