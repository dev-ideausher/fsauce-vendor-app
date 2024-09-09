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
    this.keyboardType,
    this.validator,
    this.readOnly = false,
    this.maxLength,
    this.autovalidateMode,
  });
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color fillColor;
  final Function? suffixOnPressed;
  final Color? iconColor;
  final String hintText;
  final BoxBorder? border;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool readOnly;
  final int? maxLength;
  final AutovalidateMode? autovalidateMode;

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
            child: TextFormField(
              maxLength: maxLength,
              readOnly: readOnly,
              validator: validator,
              controller: controller,
              autovalidateMode: autovalidateMode,
              keyboardType: keyboardType,
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
