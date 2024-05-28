import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/services/gradients.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class LoyaltyCard extends StatelessWidget {
  const LoyaltyCard(
      {super.key,
      required this.brandName,
      required this.offer,
      required this.brandColor,
      required this.onAddPressed,
      required this.width,
      required this.brandLogo});
  final String brandName;
  final String offer;
  final String brandLogo;
  final Color brandColor;
  final double width;
  final Function onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175.kh,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: brandColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                padding: EdgeInsets.all(6.kw),
                margin: EdgeInsets.only(top: 16.kw, left: 16.kw),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.kw)),
                child: Center(
                  child: CommonImageView(
                    url: brandLogo,
                  ),
                ),
              ),
              Spacer(),
              Container(
                height: 37.kh,
                width: 90.kw,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4))),
                child: Center(
                    child: Text(
                  "0/4 Points",
                  style: TextStyleUtil.manrope14w500(),
                )),
              )
            ],
          ),
          const Spacer(),
          Container(
            height: 85.kh,
            width: width,
            padding: EdgeInsets.only(bottom: 16.kw, left: 16.kw, right: 16.kw),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.kw),
                gradient: GradientUtil.shadowGradient2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      brandName,
                      style: TextStyleUtil.manrope18w700(color: Colors.white),
                    ),
                    4.kheightBox,
                    Text(
                      offer,
                      style: TextStyleUtil.manrope16w500(color: Colors.white),
                    )
                  ],
                ),
                InkWell(
                    onTap: () {
                      onAddPressed();
                    },
                    child: CommonImageView(
                      svgPath: ImageConstant.qrIcon,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
