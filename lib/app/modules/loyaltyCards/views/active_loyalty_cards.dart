import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/empty_widget.dart';
import 'package:fsauce_vendor_app/app/components/loyalty_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/modules/loyaltyCards/controllers/loyalty_cards_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:get/get.dart';


class ActiveLoyaltyCards extends GetView<LoyaltyCardsController> {
  const ActiveLoyaltyCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.activeLoyaltyCards.isNotEmpty) {
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return Obx(() {
                  return LoyaltyCard(
                      brandName: Get.find<HomeController>().restaurantDetails.value.restaurantName,
                      offer: controller.activeLoyaltyCards[index].title,
                      brandColor: Color(int.parse(
                          controller.activeLoyaltyCards[index]
                              .cardBackgroundColor)),
                      onAddPressed: () {
                        //ToDo: When the loyalty card is pressed.
                      },
                      noOfStamps: controller.activeLoyaltyCards[index].noOfStamps,
                      width: 100.w,
                      brandLogo: Get.find<HomeController>().restaurantDetails.value.restaurantLogo
                  );
                });
              },
              separatorBuilder: (ctx, index) {
                return 10.kheightBox;
              },
              itemCount: controller.activeLoyaltyCards.length);
        } else if (controller.activeLoyaltyCards.isEmpty) {
          return EmptyWidget(title: StringConstant.noLoyaltyCardFound, subTitle: StringConstant.getStartedWithLoyaltyCards);
        } else {
          return const Center(
              child: CircularProgressIndicator(color: Colors.red,));
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
            onPressed: controller.gotoEditLoyaltyPage),
      ),
    );
  }
}
