import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/deals_of_the_day_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/controllers/vip_offers_controller.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:get/get.dart';

class InactiveOffersView extends GetView<VipOffersController> {
  const InactiveOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(controller.inactiveCouponList.isNotEmpty){
        return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            return DealsOfTheDayCard(
                width: 100.w,
                isActive: false,
                coupon: controller.inactiveCouponList[index],
                onClick: () {
                  controller.selectedCoupon.value =
                  controller.inactiveCouponList[index];
                  controller.showDealsBottomSheet();
                }
            );
          },
          separatorBuilder: (ctx, index) {
            return 12.kheightBox;
          },
          itemCount: controller.inactiveCouponList.length,
        );
      } else if(controller.inactiveCouponList.isEmpty){
        return const Center(child: Text(StringConstant.noCoupons));
      } else{
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}