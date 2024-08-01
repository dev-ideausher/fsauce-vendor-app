import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/coupon_model.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/controllers/vip_offers_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class DealsOfTheDayCard extends StatelessWidget {
  const DealsOfTheDayCard(
      {super.key,
      required this.onClick,
      required this.width,
      required this.isActive,
      required this.coupon,
      required this.isNormalOffer});

  final Function onClick;
  final double width;
  final bool isActive;
  final Coupon coupon;
  final bool isNormalOffer;

  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String date = coupon.sheduleDate ?? "";
    return Container(
      height: isNormalOffer ? 148.kh : 178.kh,
      width: width,
      // padding: EdgeInsets.only(top: 10.kh),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: context.black07,
          ),
          boxShadow: [BoxShadow(color: context.borderColor1)],
          borderRadius: BorderRadius.circular(8.kw)),
      child: Stack(children: [
        Positioned(
            right: 0,
            top: 0,
            child: ClipRRect(
              borderRadius:
              BorderRadius.horizontal(left: Radius.elliptical(130.kw, 250.kw), right: Radius.circular(8.kw)),
              child: CommonImageView(
                url: coupon.image,
                width: 80.kw,
                height: 150.kh,
              ),
            )),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.kheightBox,
            isNormalOffer
                ? Container()
                : CommonImageView(
                    svgPath: ImageConstant.dealOfDay,
                  ),
            20.kheightBox,
            Padding(
              padding: EdgeInsets.only(left: 14.kw, right: 2.kw),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CommonImageView(
                    svgPath: ImageConstant.percentOff,
                  ),
                  20.kwidthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coupon.title,
                        style: TextStyleUtil.manrope16w600(),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Text(
                          coupon.description,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  isActive
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 10.kh),
                          child: PopupMenuButton<int>(
                            color: Colors.white,
                            onSelected: (item) => handleClick(item),
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                  onTap: () {
                                    Get.find<VipOffersController>()
                                        .gotoEditVipOffer(coupon);
                                  },
                                  value: 1,
                                  child: Text(
                                    StringConstant.edit,
                                    style: TextStyleUtil.manrope14w400(),
                                  )),
                              PopupMenuItem<int>(
                                  onTap: () {
                                    Get.find<VipOffersController>()
                                        .showInactiveDialog(coupon);
                                  },
                                  value: 1,
                                  child: Text(
                                    StringConstant.inactiveOffer,
                                    style: TextStyleUtil.manrope14w400(),
                                  )),
                              PopupMenuItem<int>(
                                  onTap: () {
                                    Get.find<VipOffersController>()
                                        .showDeleteDialog(coupon);
                                  },
                                  value: 1,
                                  child: Text(
                                    StringConstant.deleteOffer,
                                    style: TextStyleUtil.manrope14w400(
                                      color: context.primary01,
                                    ),
                                  )),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(bottom: 10.kh),
                          child: PopupMenuButton<int>(
                            color: Colors.white,
                            onSelected: (item) => handleClick(item),
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                  onTap: () {
                                    Get.find<VipOffersController>()
                                        .gotoEditVipOffer(coupon);
                                  },
                                  value: 1,
                                  child: Text(
                                    StringConstant.edit,
                                    style: TextStyleUtil.manrope14w400(),
                                  )),
                              PopupMenuItem<int>(
                                  onTap: () {
                                    Get.find<VipOffersController>()
                                        .showActiveDialog(coupon);
                                  },
                                  value: 1,
                                  child: Text(
                                    StringConstant.activeOffer,
                                    style: TextStyleUtil.manrope14w400(),
                                  )),
                            ],
                          ),
                        )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      onClick();
                    },
                    child: Text(
                      StringConstant.viewDetails,
                      style: TextStyleUtil.manrope14w400(
                          color: context.black02,
                          textDecoration: TextDecoration.underline),
                    )),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}

// BoxDecoration(
// borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
// image: DecorationImage(
// fit: BoxFit.fitHeight,
// alignment: Alignment.centerRight,
// image: NetworkImage(
// coupon.image
// )
// ),
// ),
