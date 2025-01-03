import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_button_with_border.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class ConfrimationDialog extends StatelessWidget {
  ConfrimationDialog(
      {super.key,
      this.yesButtonText,
      this.noButtonText,
      required this.title,
      required this.subTitle,
      required this.onYesTap,
      required this.onNoTap});
  final String title;
  final String subTitle;
  final Function onYesTap;
  final Function onNoTap;
  String? yesButtonText;
  String? noButtonText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.kh, horizontal: 24.kw),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyleUtil.manrope18w600(),
              textAlign: TextAlign.left,
            ),
            4.kheightBox,
            Text(
              subTitle,
              style: TextStyleUtil.manrope14w400(color: context.black03),
              textAlign: TextAlign.left,
            ),
            16.kheightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRedElevatedButtonWithBorder(
                    buttonText: noButtonText ?? StringConstant.no,
                    height: 40.kh,
                    width: 120.kw,
                    onPressed: () {
                      onNoTap();
                    }),
                CustomRedElevatedButton(
                    buttonText: yesButtonText ?? StringConstant.yes,
                    height: 40.kh,
                    width: 120.kw,
                    onPressed: () {
                      onYesTap();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}


/*
     AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyleUtil.manrope18w600(),
      ),
      content: Text(
        subTitle,
        style: TextStyleUtil.manrope14w400(color: context.black03),
      ),
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20.kw)),
      actions: [
        CustomRedElevatedButtonWithBorder(
            buttonText: noButtonText ?? StringConstant.no,
            height: 40.kh,
            width: 120.kw,
            onPressed: () {
              onNoTap();
            }),
        CustomRedElevatedButton(
            buttonText: yesButtonText ?? StringConstant.yes,
            height: 40.kh,
            width: 120.kw,
            onPressed: () {
              onYesTap();
            }),
      ],
    );
*/