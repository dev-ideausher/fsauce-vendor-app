import 'package:flutter/material.dart';
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
    return Obx(() {
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
                    width: 100.w,
                    brandLogo: Get.find<HomeController>().restaurantDetails.value.restaurantLogo
                  //"https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Dominos_pizza_logo.svg/1200px-Dominos_pizza_logo.svg.png"
                );
              });
            },
            separatorBuilder: (ctx, index) {
              return 10.kheightBox;
            },
            itemCount: controller.activeLoyaltyCards.length);
      } else if (controller.activeLoyaltyCards.isEmpty) {
        return const Center(child: Text(StringConstant.noLoyaltyCardsYet));
      } else {
        return const Center(
            child: CircularProgressIndicator(color: Colors.red,));
      }
    });
  }
}
