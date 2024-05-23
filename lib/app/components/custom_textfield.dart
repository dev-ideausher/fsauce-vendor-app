import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.fillColor,
    required this.hintText,
    this.iconColor,
    this.controller,
    this.border,
    this.suffixOnPressed,
  });
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color fillColor;
  final Function? suffixOnPressed;
  final Color? iconColor;
  final String hintText;
  final BoxBorder? border;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.kh,
      width: 100.w,
      decoration: BoxDecoration(
        color: fillColor,
        border: border,
        borderRadius: BorderRadius.circular(8.0.kw),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          if (prefixIcon != null)
            Padding(
              padding: EdgeInsets.only(top: 5.kh),
              child: Icon(
                prefixIcon,
                size: 20.kw,
              ),
            ),
          10.kwidthBox,
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyleUtil.manrope14w400(color: context.black04),
                border: InputBorder.none,
              ),
            ),
          ),
          if (suffixIcon != null)
            InkWell(
              onTap: () {
                suffixOnPressed!();
              },
              child: Icon(
                suffixIcon,
                size: 20.kw,
                color: iconColor,
              ),
            ),
        ],
      ),
    );
  }
}
