import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'colors.dart';
import 'text_style_util.dart';

class FsvButton extends StatelessWidget {
  final bool isActive;
  final bool isBorder;
  final bool isLoading;
  final String? label;
  final double? width, fontSize, height, borderRadius, borderWidth;
  final Function()? onPressed;
  final Widget? child;
  final Color? color, borderColor, labelColor, loadingColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelTextStyle;
  const FsvButton({
    super.key,
    this.label,
    this.borderRadius,
    this.fontSize,
    required this.onPressed,
    this.width,
    this.color,
    this.child,
    this.height,
    this.isActive = true,
    this.isBorder = false,
    this.borderWidth,
    this.borderColor,
    this.isLoading = false,
    this.labelColor,
    this.padding,
    this.loadingColor,
    this.labelTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: isLoading || !isActive ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: context.white,
          surfaceTintColor: context.primary07,
          shadowColor: context.primary07,
          minimumSize: Size(width ?? 343.kw, height ?? 56.kh),
          padding: padding ?? EdgeInsets.symmetric(vertical: 16.kh),
          elevation: 0,
          backgroundColor: color ??
              (isBorder
                  ? Colors.transparent
                  : (isActive ? context.primary01 : context.primary06)),
          shape: RoundedRectangleBorder(
              side: isBorder
                  ? BorderSide(
                      color: borderColor ?? context.primary01,
                      width: borderWidth ?? 2.kh)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 100.kh)),
        ),
        child: isLoading
            ? isActive
                ? SizedBox(
                    height: 20.kh,
                    width: 20.kh,
                    child: CircularProgressIndicator(
                        color: loadingColor ?? Colors.white),
                  )
                : SizedBox(
                    height: 20.kh,
                    width: 20.kh,
                    child: CircularProgressIndicator(
                        color: loadingColor ?? Colors.white),
                  )
            : child ??
                Text(
                  label ?? '',
                  style: labelTextStyle ??
                      TextStyleUtil.manrope16w500(
                          color: isActive
                              ? labelColor ?? context.white
                              : labelColor ?? context.black03),
                ),
      ),
    );
  }
}
