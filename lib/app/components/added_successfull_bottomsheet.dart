import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class AddedSuccessfullBottomSheet extends StatelessWidget {
  const AddedSuccessfullBottomSheet({super.key, required this.subTitle});
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 486.kh,
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
          const Spacer(),
          CommonImageView(
            svgPath: ImageConstant.completeTick,
          ),
          70.kheightBox,
          Text(
            "Woohoo !",
            style: TextStyleUtil.manrope24w700(color: context.black01),
          ),
          20.kheightBox,
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyleUtil.manrope16w400(color: context.black03),
          ),
          50.kheightBox,
        ],
      ),
    );
  }
}
