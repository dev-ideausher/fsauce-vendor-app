import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class HelpAndSupportQNACaed extends StatelessWidget {
  final String question;
  final String answer;
  const HelpAndSupportQNACaed(
      {super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          collapsedIconColor: context.black01,
          iconColor: context.black01,
          expandedAlignment: Alignment.centerLeft,
          childrenPadding: EdgeInsets.only(
              left: 16.kw, right: 8.kw, bottom: 10.kw), // Adjust padding here
          title: Text(
            question,
            style: TextStyleUtil.manrope14w500(),
          ),
          children: [
            Text(
              answer,
              style: TextStyleUtil.manrope14w400(color: context.black03),
            )
          ],
        ));
  }
}
