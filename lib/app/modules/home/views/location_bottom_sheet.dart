import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/components/custom_textfield.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 590.kh,
      width: 100.w,
      padding: EdgeInsets.all(16.kw),
      decoration: BoxDecoration(
          color: Colors.white,
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
            StringConstant.selectLocation,
            style: TextStyleUtil.manrope18w600(color: context.black01),
          ),
          20.kheightBox,
          CustomTextField(
              fillColor: context.black07,
              prefixIcon: Icons.search_rounded,
              hintText: StringConstant.locationHintText),
          20.kheightBox,
          Row(
            children: [
              Expanded(
                  child: Divider(
                color: context.black07,
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  StringConstant.or,
                  style: TextStyleUtil.manrope12w500(color: context.black03),
                ),
              ),
              Expanded(
                  child: Divider(
                color: context.black07,
              ))
            ],
          ),
          20.kheightBox,
          CustomRedElevatedButton(
            width: 100.w,
            height: 56.kh,
            leadingIcon: CommonImageView(
              svgPath: ImageConstant.focusIcon,
            ),
            buttonText: StringConstant.useMyCurrentLocation,
            onPressed: () {},
          ),
          20.kheightBox,
          Row(
            children: [
              Text(
                StringConstant.recentLocations,
                style: TextStyleUtil.manrope18w500(
                  color: context.black01,
                ),
              ),
            ],
          ),
          14.kheightBox,
          Row(
            children: [
              Column(
                children: [1, 2, 4, 5]
                    .map((e) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.kh),
                          child: Text(
                            "Lancaster",
                            style: TextStyleUtil.manrope16w400(
                                color: context.black01),
                          ),
                        ))
                    .toList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
