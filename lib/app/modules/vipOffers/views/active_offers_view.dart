import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/deals_of_the_day_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/controllers/vip_offers_controller.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:get/get.dart';

class ActiveOffersView extends GetView<VipOffersController> {
  const ActiveOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(controller.couponsList.isNotEmpty){
        return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            return DealsOfTheDayCard(
                width: 100.w,
                isNormalOffer: controller.couponsList[index].typeOfOffer == 'Normal offer',
                isActive: true,
                coupon: controller.couponsList[index],
                onClick: () {
                  controller.selectedCoupon.value =
                  controller.couponsList[index];
                  controller.showDealsBottomSheet();
                }
            );
          },
          separatorBuilder: (ctx, index) {
            return 12.kheightBox;
          },
          itemCount: controller.couponsList.length,
        );
      } else if(controller.couponsList.isEmpty){
        return const Center(child: Text(StringConstant.noCoupons));
      } else{
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}