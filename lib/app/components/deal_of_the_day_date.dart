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
import 'package:intl/intl.dart';

class DealsOfTheDayCardDate extends StatelessWidget {
  const DealsOfTheDayCardDate(
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
      constraints: BoxConstraints(
        minHeight: isNormalOffer ? 188.kh : 216.kh,
      ),
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
              borderRadius: BorderRadius.horizontal(
                  left: Radius.elliptical(200.kw, 380.kw)),
              child: CommonImageView(
                url: coupon.image,
                width: 80.kw,
                height: 220.kh,
              ),
            )),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            date.isNotEmpty
                ? Container(
                    height: 37.kh,
                    decoration: BoxDecoration(
                      color: context.primary07,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.check),
                          4.kwidthBox,
                          Text(
                            StringConstant.offerScheduledFor,
                            style: TextStyleUtil.manrope14w400(),
                          ),
                          Text(
                            DateFormat("dd MMM, hh:mm a")
                                .format(DateTime.parse(date).toLocal()),
                            style: TextStyleUtil.manrope14w400(),
                          ),
                        ],
                      ),
                    ))
                : Container(),
            8.kheightBox,
            isNormalOffer
                ? Container()
                : CommonImageView(
                    svgPath: ImageConstant.dealOfDay,
                  ),
            16.kheightBox,
            Padding(
              padding: EdgeInsets.only(left: 14.kw, right: 90.kw),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonImageView(
                    svgPath: ImageConstant.percentOff,
                  ),
                  12.kwidthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          coupon.title,
                          style: TextStyleUtil.manrope16w600(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        2.kheightBox,
                        Text(
                          coupon.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleUtil.manrope14w400(color: context.black03),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.kw, bottom: 2.kh),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.kw, vertical: 0),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  onClick();
                },
                child: Text(
                  StringConstant.viewDetails,
                  style: TextStyleUtil.manrope14w400(
                    color: context.black02,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            right: 0,
            top: 40,
            child: isActive
                ? Padding(
                    padding: EdgeInsets.only(bottom: 10.kh),
                    child: PopupMenuButton<int>(
                      color: Colors.white,
                      iconColor: context.white,
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
                      iconColor: context.white,
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
                  )),
      ]),
    );
  }
}
