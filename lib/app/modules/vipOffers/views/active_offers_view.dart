import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/deal_of_the_day_date.dart';
import 'package:fsauce_vendor_app/app/components/deals_of_the_day_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/vipOffers/controllers/vip_offers_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:get/get.dart';

import '../../../components/empty_widget.dart';

class ActiveOffersView extends GetView<VipOffersController> {
  const ActiveOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if(controller.couponsList.isNotEmpty){
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                // controller.getActiveCoupons();
                controller.addActiveCoupons();
              }
              return false;
            },
            child: ListView.separated(
              shrinkWrap: true,
              controller: controller.activeScrollController,
              itemBuilder: (ctx, index) {
                String date = controller.couponsList[index].sheduleDate ?? "";
                if(date.isEmpty){
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
                }
                else{
                  return DealsOfTheDayCardDate(
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
                }
              },
              separatorBuilder: (ctx, index) {
                return 12.kheightBox;
              },
              itemCount: controller.couponsList.length,
            ),
          );
        } else if(controller.couponsList.isEmpty){
          return EmptyWidget(title: StringConstant.noOffersFound, subTitle: StringConstant.createAttractiveOffers);
          // return const Center(child: Text(StringConstant.noCoupons));
        } else{
          return Center(child: CircularProgressIndicator(color: context.primary01,));
        }
      }),
      floatingActionButton: Container(
        height: 41.kh,
        width: 41.kw,
        decoration:
        BoxDecoration(shape: BoxShape.circle, color: context.primary01),
        child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 30.kw,
            ),
            onPressed: controller.gotoCreateVipOffer),
      ),
    );
  }
}