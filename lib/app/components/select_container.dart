import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class SelectContainer extends StatelessWidget {
  const SelectContainer(
      {super.key, required this.title, required this.isSelected});
  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.kw, vertical: 8.kh),
      decoration: BoxDecoration(
        color: isSelected ? context.primary07 : Colors.white,
        border:
            Border.all(color: isSelected ? context.primary05 : context.black05),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        title,
        style: TextStyleUtil.manrope14w400(),
      ),
    );
  }
}
