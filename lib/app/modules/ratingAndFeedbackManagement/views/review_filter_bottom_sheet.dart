import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_button_with_border.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/menuPage/controllers/menu_page_controller.dart';
import 'package:fsauce_vendor_app/app/modules/ratingAndFeedbackManagement/controllers/rating_and_feedback_management_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class ReviewFilterBottomSheet extends StatelessWidget {
  ReviewFilterBottomSheet({super.key});

  final controller = Get.find<RatingAndFeedbackManagementController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(16.kw),
      decoration: BoxDecoration(
          color: context.loginSignupTextfieldColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.kw),
              topRight: Radius.circular(24.kw))),
      child: Column(
        children: [
          Container(
            height: 5.kh,
            width: 64.kw,
            decoration: BoxDecoration(
                color: context.black01, borderRadius: BorderRadius.circular(3)),
          ),
          20.kheightBox,
          Text(
            StringConstant.filters,
            style: TextStyleUtil.manrope18w600(color: context.black01),
          ),
          20.kheightBox,
          Container(
            width: 100.w,
            padding: EdgeInsets.all(16.kw),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      StringConstant.rating,
                      style: TextStyleUtil.manrope16w600(),
                    ),
                  ],
                ),
                10.kheightBox,
                RatingBar(
                  initialRating: controller.selectedRatingFilter.value,
                  direction: Axis.horizontal,
                  //  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: CommonImageView(
                      svgPath: ImageConstant.filledStar,
                    ),
                    empty: CommonImageView(
                      svgPath: ImageConstant.emptyStar,
                    ),
                    half: CommonImageView(
                      svgPath: ImageConstant.emptyStar,
                    ),
                  ),
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (rating) {
                    controller.selectedRatingFilter.value = rating;
                  },
                ),
              ],
            ),
          ),
          20.kheightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRedElevatedButtonWithBorder(
                width: 43.w,
                height: 56.kh,
                buttonText: StringConstant.clear,
                onPressed: () {
                  controller.selectedRatingFilter.value = 0.0;
                },
              ),
              CustomRedElevatedButton(
                  width: 43.w,
                  height: 56.kh,
                  buttonText: StringConstant.next,
                  onPressed: () {
                    Get.back();
                    controller.getRatings();
                    }
                  ),
            ],
          ),
          20.kheightBox,
        ],
      ),
    );
  }
}
