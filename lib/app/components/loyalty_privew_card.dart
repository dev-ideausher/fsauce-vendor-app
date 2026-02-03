import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/home/controllers/home_controller.dart';
import 'package:fsauce_vendor_app/app/modules/loyalty/controllers/loyalty_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../generated/assets.dart';

class LoyaltyReviewCard extends StatelessWidget {
  const LoyaltyReviewCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.kw),
      decoration: BoxDecoration(
          color: ColorUtil.hexToColor(
              Get.find<LoyaltyController>().backgroundColor.value.toString()),
          borderRadius: BorderRadius.circular(8.kh)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 64.kh,
            width: 64.kw,
            padding: EdgeInsets.all(4.kw),
            decoration: BoxDecoration(
                color: context.white,
                borderRadius: BorderRadius.circular(8.kw)),
            child: Obx(() {
              return CommonImageView(
                fit: BoxFit.cover,
                url: Get.find<HomeController>()
                    .restaurantDetails
                    .value
                    .restaurantLogo,
                //"https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Dominos_pizza_logo.svg/1200px-Dominos_pizza_logo.svg.png",
              );
            }),
          ),
          16.kheightBox,
          Obx(() {
            return Text(
              Get.find<HomeController>().restaurantDetails.value.restaurantName,
              style: TextStyleUtil.manrope24w700(
                  color: ColorUtil.hexToColor(Get.find<LoyaltyController>()
                      .textColor
                      .value
                      .toString())),
            );
          }),
          Obx(() {
            return Text(
              'Valid Till ${DateFormat('dd MMM yyyy').format(DateTime.parse(
                Get.find<LoyaltyController>().validTill.toString(),
              ))}',
              style: TextStyleUtil.manrope14w400(
                  color: ColorUtil.hexToColor(Get.find<LoyaltyController>()
                      .textColor
                      .value
                      .toString())),
            );
          }),
          24.kheightBox,
          Text(
            "${Get.find<LoyaltyController>().noOfStamps.value} orders left to get reward",
            style: TextStyleUtil.manrope16w600(color: context.white),
          ),
          16.kheightBox,
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 16.kh,
              crossAxisSpacing: 16.kw,
            ),
            itemCount: Get.find<LoyaltyController>().noOfStamps.value + 1,
            itemBuilder: (context, index) {
              final bool isGift =
                  index == Get.find<LoyaltyController>().noOfStamps.value;
              return isGift ? _giftBox(context) : _stampBox(context);
            },
          ),
          32.kheightBox,
          Text(
            "Reward",
            style: TextStyleUtil.manrope18w600(color: context.white),
          ),
          8.kheightBox,
          Text(
            Get.find<LoyaltyController>().cardTitleController.text,
            style: TextStyleUtil.manrope16w500(
                color: ColorUtil.hexToColor(
                    Get.find<LoyaltyController>().textColor.value.toString())),
          ),
          40.kheightBox,
          Container(
            padding: EdgeInsets.all(8.kw),
            decoration: BoxDecoration(
                color: context.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1 point earned on 07/04/2024\nwere credited",
                  style: TextStyleUtil.manrope14w400(),
                ),
                16.kwidthBox,
                Container(
                  height: 42,
                  width: 1,
                  decoration: BoxDecoration(color: context.black01),
                ),
                16.kwidthBox,
                Text(
                  StringConstant.history,
                  style: TextStyleUtil.manrope14w400(),
                ),
                Icon(
                  Icons.keyboard_arrow_right_sharp,
                  size: 16.kh,
                )
              ],
            ),
          ),
          38.kheightBox,
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
                  Text("Redeem",
                      style:
                          TextStyleUtil.manrope16w500(color: context.black03)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// ---------------- STAMP BOX ----------------
  Widget _stampBox(BuildContext context) {
    return Container(
      height: 48.kh,
      width: 48.kw,
      decoration: BoxDecoration(
        color: context.black07,
        borderRadius: BorderRadius.circular(8.kw),
      ),
      child: Center(
        child: Icon(
          Icons.check,
          color: context.black04,
          size: 28,
        ),
      ),
    );
  }

  /// ---------------- GIFT BOX ----------------
  Widget _giftBox(BuildContext context) {
    return Container(
      height: 48.kw,
      width: 48.kw,
      decoration: BoxDecoration(
        color: context.black07,
        borderRadius: BorderRadius.circular(8.kw),
      ),
      child: Center(
        child: CommonImageView(
          svgPath: Assets.svgsGiftIcon,
          height: 28.kh,
          svgColor: context.black04,
          width: 28.kw,
        ),
      ),
    );
  }
}
