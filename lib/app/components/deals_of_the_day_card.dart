import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/coupon_model.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/controllers/vip_offers_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/dialog_helper.dart';
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
              borderRadius: BorderRadius.horizontal(
                  left: Radius.elliptical(130.kw, 250.kw),
                  right: Radius.circular(8.kw)),
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
        // Positioned(
        //     right: 0,
        //     top: 0,
        //     child: isActive
        //         ? Padding(
        //             padding: EdgeInsets.only(bottom: 10.kh),
        //             child: PopupMenuButton<int>(
        //               color: Colors.white,
        //               iconColor: context.white,
        //               onSelected: (item) => handleClick(item),
        //               itemBuilder: (context) => [
        //                 PopupMenuItem<int>(
        //                     onTap: () {
        //                       Get.find<VipOffersController>()
        //                           .gotoEditVipOffer(coupon);
        //                     },
        //                     value: 1,
        //                     child: Text(
        //                       StringConstant.edit,
        //                       style: TextStyleUtil.manrope14w400(),
        //                     )),
        //                 PopupMenuItem<int>(
        //                     onTap: () {
        //                       Get.find<VipOffersController>()
        //                           .showInactiveDialog(coupon);
        //                     },
        //                     value: 1,
        //                     child: Text(
        //                       StringConstant.inactiveOffer,
        //                       style: TextStyleUtil.manrope14w400(),
        //                     )),
        //                 PopupMenuItem<int>(
        //                     onTap: () {
        //                       Get.find<VipOffersController>()
        //                           .showDeleteDialog(coupon);
        //                     },
        //                     value: 1,
        //                     child: Text(
        //                       StringConstant.deleteOffer,
        //                       style: TextStyleUtil.manrope14w400(
        //                         color: context.primary01,
        //                       ),
        //                     )),
        //               ],
        //             ),
        //           )
        //         : Padding(
        //             padding: EdgeInsets.only(bottom: 10.kh),
        //             child: PopupMenuButton<int>(
        //               color: Colors.white,
        //               iconColor: context.white,
        //               onSelected: (item) => handleClick(item),
        //               itemBuilder: (context) => [
        //                 PopupMenuItem<int>(
        //                     onTap: () {
        //                       Get.find<VipOffersController>()
        //                           .gotoEditVipOffer(coupon);
        //                     },
        //                     value: 1,
        //                     child: Text(
        //                       StringConstant.edit,
        //                       style: TextStyleUtil.manrope14w400(),
        //                     )),
        //                 PopupMenuItem<int>(
        //                     onTap: () {
        //                       final DateTime now = DateTime.now().toUtc();
        //                       final DateTime validTill =
        //                           DateTime.parse(coupon.validTill).toUtc();

        //                       if (now.isAfter(validTill)) {
        //                         DialogHelper.showError(
        //                             StringConstant.couponExpired);
        //                       } else {
        //                         Get.find<VipOffersController>()
        //                             .showActiveDialog(coupon);
        //                       }
        //                     },
        //                     value: 1,
        //                     child: Text(
        //                       StringConstant.activeOffer,
        //                       style: TextStyleUtil.manrope14w400(),
        //                     )),
        //               ],
        //             ),
        //           )),
        Positioned(
          right: 0,
          top: 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.kh),
            child: PopupMenuButton<int>(
              color: Colors.white,
              iconColor: context.white,
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) {
                final DateTime now = DateTime.now().toUtc();
                final DateTime validTill =
                    DateTime.tryParse(coupon.validTill ?? '')?.toUtc() ??
                        DateTime.now()
                            .subtract(Duration(days: 1)); // fallback expired

                bool isExpired = now.isAfter(validTill);

                List<PopupMenuEntry<int>> menuItems = [];

                if (!isExpired) {
                  // Coupon is valid → can edit or activate
                  menuItems.add(
                    PopupMenuItem<int>(
                      onTap: () {
                        Get.find<VipOffersController>()
                            .gotoEditVipOffer(coupon);
                      },
                      value: 1,
                      child: Text(
                        StringConstant.edit,
                        style: TextStyleUtil.manrope14w400(),
                      ),
                    ),
                  );
                  menuItems.add(
                    PopupMenuItem<int>(
                      onTap: () {
                        Get.find<VipOffersController>()
                            .showActiveDialog(coupon);
                      },
                      value: 2,
                      child: Text(
                        StringConstant.activeOffer,
                        style: TextStyleUtil.manrope14w400(),
                      ),
                    ),
                  );
                } else {
                  // Coupon expired → greyed out edit/activate
                  menuItems.add(
                    PopupMenuItem<int>(
                      onTap: () {
                        DialogHelper.showError(StringConstant.couponExpired);
                      },
                      value: 3,
                      child: Text(
                        StringConstant.edit,
                        style: TextStyleUtil.manrope14w400(color: Colors.grey),
                      ),
                    ),
                  );
                  menuItems.add(
                    PopupMenuItem<int>(
                      onTap: () {
                        DialogHelper.showError(StringConstant.couponExpired);
                      },
                      value: 4,
                      child: Text(
                        StringConstant.activeOffer,
                        style: TextStyleUtil.manrope14w400(color: Colors.grey),
                      ),
                    ),
                  );
                }

                // Delete is always allowed
                menuItems.add(
                  PopupMenuItem<int>(
                    onTap: () {
                      Get.find<VipOffersController>().showDeleteDialog(coupon);
                    },
                    value: 5,
                    child: Text(
                      StringConstant.deleteOffer,
                      style: TextStyleUtil.manrope14w400(
                        color: context.primary01,
                      ),
                    ),
                  ),
                );

                return menuItems;
              },
            ),
          ),
        )
      ]),
    );
  }
}
