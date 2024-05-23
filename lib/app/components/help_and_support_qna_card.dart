import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class HelpAndSupportQNACaed extends StatelessWidget {
  const HelpAndSupportQNACaed({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          collapsedIconColor: context.black01,
          iconColor: context.black01,
          childrenPadding: EdgeInsets.only(
              left: 8.kw, right: 8.kw, bottom: 10.kw), // Adjust padding here
          title: Text(
            "How do I redeem a deal from the restaurant coupon app?",
            style: TextStyleUtil.manrope14w500(),
          ),
          children: [
            Text(
              "These terms and conditions outline the rules and regulations for the use of the The Food Sauciety mobile application.",
              style: TextStyleUtil.manrope14w400(color: context.black03),
            )
          ],
        ));
  }
}
