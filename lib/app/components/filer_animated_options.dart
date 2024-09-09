import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:intl/intl.dart';

class FilterAnimatedOption extends StatefulWidget {
  const FilterAnimatedOption(
      {super.key, required this.title, required this.controller});
  final String title;
  final FilterOptionController controller;

  @override
  State<FilterAnimatedOption> createState() => _FilterAnimatedOptionState();
}

class _FilterAnimatedOptionState extends State<FilterAnimatedOption> {
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
              inactiveThumbColor: context.white,
              inactiveTrackColor: context.primary07,
              trackOutlineWidth: WidgetStatePropertyAll(0.kh),
              trackOutlineColor:
                  const WidgetStatePropertyAll(Colors.transparent),
              value: widget.controller.isActivated,
              onChanged: (value) {
                setState(() {
                  widget.controller.isActivated = value;
                  if (widget.controller.isActivated) {
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
                color: widget.controller.isActivated
                    ? context.primary01
                    : context.black01),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: widget.controller.openingTime,
                    );
                    if (picked != null) {
                      setState(() {
                        widget.controller.openingTime = picked;
                      });
                    }
                  },
                  child: Container(
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
                          DateFormat('hh:mm a').format(DateTime(
                              0,
                              0,
                              0,
                              widget.controller.openingTime.hour,
                              widget.controller.openingTime.minute)),
                          style: TextStyleUtil.manrope14w400(
                              color: context.black03),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: widget.controller.closingTime,
                    );
                    if (picked != null) {
                      setState(() {
                        widget.controller.closingTime = picked;
                      });
                    }
                  },
                  child: Container(
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
                          DateFormat('hh:mm a').format(DateTime(
                              0,
                              0,
                              0,
                              widget.controller.closingTime.hour,
                              widget.controller.closingTime.minute)),
                          style: TextStyleUtil.manrope14w400(
                              color: context.black03),
                        )
                      ],
                    ),
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

class FilterOptionController {
  bool isActivated = false;
  TimeOfDay openingTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay closingTime = TimeOfDay(hour: 18, minute: 0);
}
