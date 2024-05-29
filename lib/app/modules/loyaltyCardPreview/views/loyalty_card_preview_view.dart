import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/components/loyalty_card.dart';
import 'package:fsauce_vendor_app/app/components/loyalty_privew_card.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/loyalty/controllers/loyalty_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import 'package:get/get.dart';

import '../controllers/loyalty_card_preview_controller.dart';

class LoyaltyCardPreviewView extends GetView<LoyaltyCardPreviewController> {
  const LoyaltyCardPreviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: StringConstant.loyaltyCard,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.kw),
            child: Column(
              children: [
                LoyaltyCard(
                    brandName: "Domino's",
                    offer: "Buy 4 get 1 free",
                    brandColor:
                        Get.find<LoyaltyController>().backgroundColor.value,
                    onAddPressed: () {},
                    width: 100.w,
                    brandLogo:
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Dominos_pizza_logo.svg/1200px-Dominos_pizza_logo.svg.png"),
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
        ));
  }
}
