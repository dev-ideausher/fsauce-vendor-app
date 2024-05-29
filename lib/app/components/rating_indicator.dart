import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';

class RatingIndicator extends StatelessWidget {
  const RatingIndicator({super.key, required this.rating});
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < rating; i++)
          Padding(
            padding: EdgeInsets.only(right: 8.kw),
            child: CommonImageView(
              svgPath: ImageConstant.filledStar,
              width: 20.kw,
            ),
          ),
        for (int i = rating; i < 5; i++)
          Padding(
            padding: EdgeInsets.only(right: 8.kw),
            child: CommonImageView(
              svgPath: ImageConstant.emptyStar,
            ),
          )
      ],
    );
  }
}
