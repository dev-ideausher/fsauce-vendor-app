import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/loyalty_card.dart';
import 'package:fsauce_vendor_app/app/components/loyalty_privew_card.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/loyalty/controllers/loyalty_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/loyalty_cards_controller.dart';

class LoyaltyCardsView extends GetView<LoyaltyCardsController> {
  const LoyaltyCardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstant.loyaltyCard,
          style: TextStyleUtil.manrope18w600(),
        ),
        leading: const SizedBox(),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: IconButton(
                onPressed: controller.gotoEditLoyaltyPage,
                icon: CommonImageView(
                  svgPath: ImageConstant.editPen,
                  height: 20,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.kw),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: context.primary01,
                  labelStyle: TextStyleUtil.manrope14w500(),
                  labelColor: context.primary01,
                  tabs: const <Widget>[
                    Tab(
                      text: StringConstant.activeCard,
                    ),
                    Tab(
                      text: StringConstant.inactiveCard,
                    ),
                  ],
                ),
                20.kheightBox,
                SizedBox(
                  height: MediaQuery.of(context)
                      .size
                      .height, // Ensure TabBarView has constraints
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        // Add SingleChildScrollView to ensure scrolling within each tab
                        child: Column(
                          children: [
                            LoyaltyCard(
                              brandName: "Domino's",
                              offer: "Buy 4 get 1 free",
                              brandColor: Get.find<LoyaltyController>()
                                  .backgroundColor
                                  .value,
                              onAddPressed: () {},
                              width: 100.w,
                              brandLogo:
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Dominos_pizza_logo.svg/1200px-Dominos_pizza_logo.svg.png",
                            ),
                            20.kheightBox,
                            SizedBox(
                              width: 100.w,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: context.borderColor1,
                                    ),
                                  ),
                                  6.kwidthBox,
                                  Text(
                                    StringConstant.and,
                                    style: TextStyleUtil.manrope12w400(),
                                  ),
                                  6.kwidthBox,
                                  Expanded(
                                    child: Divider(
                                      color: context.borderColor1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            20.kheightBox,
                            LoyaltyReviewCard(),
                            10.kheightBox,
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          LoyaltyCard(
                            brandName: "Domino's",
                            offer: "Buy 4 get 1 free",
                            brandColor: Get.find<LoyaltyController>()
                                .backgroundColor
                                .value,
                            onAddPressed: () {},
                            width: 100.w,
                            brandLogo:
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Dominos_pizza_logo.svg/1200px-Dominos_pizza_logo.svg.png",
                          ),
                          10.kheightBox,
                          LoyaltyCard(
                            brandName: "Domino's",
                            offer: "Buy 4 get 1 free",
                            brandColor: Get.find<LoyaltyController>()
                                .backgroundColor
                                .value,
                            onAddPressed: () {},
                            width: 100.w,
                            brandLogo:
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Dominos_pizza_logo.svg/1200px-Dominos_pizza_logo.svg.png",
                          ),
                          10.kheightBox,
                          LoyaltyCard(
                            brandName: "Domino's",
                            offer: "Buy 4 get 1 free",
                            brandColor: Get.find<LoyaltyController>()
                                .backgroundColor
                                .value,
                            onAddPressed: () {},
                            width: 100.w,
                            brandLogo:
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Dominos_pizza_logo.svg/1200px-Dominos_pizza_logo.svg.png",
                          ),
                        ],
                      ), // Center widget to ensure it's properly constrained
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
