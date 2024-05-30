import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key,
      required this.subTitle,
      required this.timeAgo,
      required this.title});
  final String title;
  final String subTitle;
  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.kw),
      margin: EdgeInsets.only(top: 8.kw, bottom: 8.kw),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.kw)),
      width: 100.w,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 8.kh,
                width: 8.kw,
                decoration: BoxDecoration(
                    color: context.primary01,
                    borderRadius: BorderRadius.circular(4.kw)),
              ),
              10.kwidthBox,
              SizedBox(
                width: 100.w - 90.kw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyleUtil.manrope16w600(),
                    ),
                    Text(
                      subTitle,
                      style:
                          TextStyleUtil.manrope14w400(color: context.black03),
                    )
                  ],
                ),
              )
            ],
          ),
          12.kheightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                timeAgo,
                style: TextStyleUtil.manrope14w400(color: context.black02),
              ),
            ],
          )
        ],
      ),
    );
  }
}
