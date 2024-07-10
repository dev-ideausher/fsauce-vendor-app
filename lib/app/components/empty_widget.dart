import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

import '../../generated/assets.dart';
import 'common_image_view.dart';

class EmptyWidget extends StatelessWidget{
  String title; String subTitle;
  EmptyWidget({this.title = "", this.subTitle = "", super.key});

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CommonImageView(
          svgPath: Assets.svgsEmpty
        ),
        10.kheightBox,
        Text(title, style: TextStyleUtil.manrope24w600()),
        6.kheightBox,
        Text(subTitle, style: TextStyleUtil.manrope16w400(color: context.black04)),
      ]
    ),);
  }
}