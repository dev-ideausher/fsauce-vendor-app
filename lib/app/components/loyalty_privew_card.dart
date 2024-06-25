import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/modules/loyalty/controllers/loyalty_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class LoyaltyReviewCard extends StatelessWidget {
  const LoyaltyReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(16.kw),
      decoration: BoxDecoration(
          color: Get
              .find<LoyaltyController>()
              .backgroundColor
              .value,
          borderRadius: BorderRadius.circular(12.kw)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            padding: EdgeInsets.all(6.kw),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.kw)),
            child: Center(
              child: Obx(() {
                return CommonImageView(
                  url: Get
                      .find<HomeController>()
                      .restaurantDetails
                      .value
                      .restaurantLogo,
                  //"https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Dominos_pizza_logo.svg/1200px-Dominos_pizza_logo.svg.png",
                );
              }),
            ),
          ),
          10.kheightBox,
          Obx(() {
            return Text(
              Get.find<HomeController>().restaurantDetails.value.restaurantName,
              style: TextStyleUtil.manrope24w700(color: Colors.white),
            );
          }),
          40.kheightBox,
          Text(
            "2 orders left to get reward",
            style: TextStyleUtil.manrope16w600(color: Colors.white),
          ),
          10.kheightBox,
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.kw)),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 28,
                  ),
                ),
              ),
              10.kwidthBox,
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.kw)),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 28,
                  ),
                ),
              ),
              10.kwidthBox,
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.kw)),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 28,
                  ),
                ),
              ),
              10.kwidthBox,
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.kw)),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 28,
                  ),
                ),
              )
            ],
          ),
          30.kheightBox,
          Text(
            "Reward",
            style: TextStyleUtil.manrope18w600(color: Colors.white),
          ),
          10.kheightBox,
          Text(
            "4 points = 1 Free Regular Pizza",
            style: TextStyleUtil.manrope16w500(color: Colors.white),
          ),
          20.kheightBox,
          Container(
            height: 58,
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("1 point earned on 07/04/2024\nwere credited"),
                10.kwidthBox,
                Container(
                  height: 48,
                  width: 2,
                  decoration: BoxDecoration(color: context.borderColor2),
                ),
                Text(StringConstant.history),
                Icon(Icons.keyboard_arrow_right_sharp)
              ],
            ),
          ),
          30.kheightBox,
          SizedBox(
            height: 56.kh,
            width: 100.w,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: context.primary06,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Reddem",
                      style: TextStyleUtil.manrope16w500(color: Colors.white)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
