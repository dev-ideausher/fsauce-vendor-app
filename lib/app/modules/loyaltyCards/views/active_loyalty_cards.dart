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
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                // controller.getActiveCoupons();
                controller.addActiveCards();
              }
              return false;
            },
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Obx(() {
                    return LoyaltyCard(
                        brandName: Get.find<HomeController>()
                            .restaurantDetails
                            .value
                            .restaurantName,
                        offer: controller.activeLoyaltyCards[index].title,
                        brandColor: Color(int.parse(controller
                            .activeLoyaltyCards[index].cardBackgroundColor)),
                        onAddPressed: () {
                          //ToDo: When the loyalty card is pressed.
                        },
                        noOfStamps:
                            controller.activeLoyaltyCards[index].noOfStamps,
                        width: 100.w,
                        brandLogo: Get.find<HomeController>()
                            .restaurantDetails
                            .value
                            .restaurantLogo);
                  });
                },
                separatorBuilder: (ctx, index) {
                  return 10.kheightBox;
                },
                itemCount: controller.activeLoyaltyCards.length),
          );
        } else if (controller.activeLoyaltyCards.isEmpty) {
          return EmptyWidget(
              title: StringConstant.noLoyaltyCardFound,
              subTitle: StringConstant.getStartedWithLoyaltyCards);
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        }
      }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primary01,
        foregroundColor: context.white,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          size: 30.kh,
        ),
        onPressed: () {
          controller.gotoEditLoyaltyPage();
        },
      ),
    );
  }
}
