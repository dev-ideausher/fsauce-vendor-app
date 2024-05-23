import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class FilterAnimatedOption extends StatefulWidget {
  const FilterAnimatedOption({super.key, required this.title});
  final String title;

  @override
  State<FilterAnimatedOption> createState() => _FilterAnimatedOptionState();
}

class _FilterAnimatedOptionState extends State<FilterAnimatedOption> {
  bool isExpanded = false;
  ExpansionTileController exController = ExpansionTileController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.kh),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.kw),
          border: Border(bottom: BorderSide(color: context.borderColor1))),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          controller: exController,
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          collapsedIconColor: context.black01,
          iconColor: context.black01,
          trailing: Transform.scale(
            scale: 0.8,
            child: Switch(
              activeColor: context.primary01,
              inactiveThumbColor: context.primary04,
              value: isExpanded,
              onChanged: (value) {
                setState(() {
                  isExpanded = value;
                  if (isExpanded) {
                    exController.expand();
                  } else {
                    exController.collapse();
                  }
                });
              },
            ),
          ),
          childrenPadding: EdgeInsets.only(
              left: 10.kw, right: 10.kw, bottom: 10.kw), // Adjust padding here
          title: Text(
            widget.title,
            style: TextStyleUtil.manrope16w600(
                color: isExpanded ? context.primary01 : context.black01),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 40.w,
                  padding: EdgeInsets.only(left: 10.kw),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: context.borderColor1)),
                  child: Row(
                    children: [
                      Text(
                        StringConstant.openingTime,
                        style:
                            TextStyleUtil.manrope14w400(color: context.black03),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 40.w,
                  padding: EdgeInsets.only(left: 10.kw),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: context.borderColor1)),
                  child: Row(
                    children: [
                      Text(
                        StringConstant.closingTime,
                        style:
                            TextStyleUtil.manrope14w400(color: context.black03),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
