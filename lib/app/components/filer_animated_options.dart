import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

class FilterAnimatedOption extends StatefulWidget {
  const FilterAnimatedOption(
      {super.key, required this.title, required this.controller});
  final String title;
  final FilterOptionController controller;

  @override
  State<FilterAnimatedOption> createState() => _FilterAnimatedOptionState();
}

class _FilterAnimatedOptionState extends State<FilterAnimatedOption> {
  ExpansibleController exController = ExpansibleController();

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
              activeThumbColor: context.primary01,
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
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: widget.controller.openingTime,
                      );
                      if (picked != null) {
                        double start = picked.hour + picked.minute / 60.0;
                        double end = widget.controller.closingTime.hour +
                            widget.controller.closingTime.minute / 60.0;
                        if (start > end) {
                          Get.snackbar("Error",
                              "Opening time cannot be greater than closing time");
                        } else {
                          setState(() {
                            widget.controller.openingTime = picked;
                          });
                        }
                      }
                    },
                    child: Container(
                      height: 50,
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
                ),
                10.kwidthBox,
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: widget.controller.closingTime,
                      );
                      if (picked != null) {
                        double start = widget.controller.openingTime.hour +
                            widget.controller.openingTime.minute / 60.0;
                        double end = picked.hour + picked.minute / 60.0;

                        if (end < start) {
                          Get.snackbar("Error",
                              "Closing time cannot be less than opening time");
                        } else {
                          setState(() {
                            widget.controller.closingTime = picked;
                          });
                        }
                      }
                    },
                    child: Container(
                      height: 50,
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
