import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';

class CustomRedElevatedButtonWithBorder extends StatelessWidget {
  final String buttonText;
  final double width;
  final VoidCallback onPressed;
  final double height;
  final TextStyle? textStyle;

  const CustomRedElevatedButtonWithBorder({
    super.key,
    required this.buttonText,
    required this.width,
    required this.height,
    required this.onPressed,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: context.primary01,
          backgroundColor:
              Colors.white, // Set the text color to red when pressed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0), // Fully rounded corners
            side: BorderSide(
                color: context.primary01, width: 2.kw), // Border color
          ),
        ),
        child: Text(
          buttonText,
          style: textStyle ?? TextStyle(
            color: context.primary01, // Set the text color to black01
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
