import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class CustomRedElevatedButton extends StatelessWidget {
  final String buttonText;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final Widget? leadingIcon;

  const CustomRedElevatedButton({
    super.key,
    required this.buttonText,
    required this.height,
    required this.width,
    required this.onPressed,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.primary01,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) leadingIcon!,
            6.kwidthBox,
            Text(buttonText,
                style: TextStyleUtil.manrope16w500(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
