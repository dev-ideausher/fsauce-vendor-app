import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class FsvTextfield extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String hintText;
  final Color? fillColor, hintColor;
  final TextCapitalization textCapitalization;
  final bool? isSuffixPaddingNeeded, isSuffixNeeded;
  final InputBorder? border;
  final TextInputType? keyboardType;
  final bool? obscureText, readOnly;
  final bool isCounterTextNeeded;
  final Function(String?)? onchanged, onSaved;
  final int? maxLines, maxLength;
  final bool? enabled, autofocus;
  final Widget? prefix, suffix;
  final Function()? onTap, onPressedSuffix;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;

  const FsvTextfield({
    super.key,
    this.validator,
    this.controller,
    this.maxLines,
    required this.hintText,
    this.obscureText,
    this.onchanged,
    this.enabled,
    this.suffix,
    this.prefix,
    this.onTap,
    this.autofocus,
    this.onPressedSuffix,
    this.readOnly,
    this.autovalidateMode,
    this.onSaved,
    this.keyboardType,
    this.fillColor,
    this.border,
    this.isSuffixPaddingNeeded,
    this.hintColor,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.maxLength,
    this.isCounterTextNeeded = false, this.isSuffixNeeded,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      style: TextStyleUtil.manrope14w400(color: context.black01),
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      onTap: onTap,
      inputFormatters: inputFormatters,
      cursorColor: context.black01,
      onChanged: onchanged,
      validator: validator,
      autovalidateMode: autovalidateMode,
      controller: controller,
      onSaved: onSaved,
      obscureText: obscureText ?? false,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType ?? TextInputType.name,
      decoration: InputDecoration(
        counterText: isCounterTextNeeded ? null : "",
        suffixIcon: isSuffixNeeded ?? true ? Padding(
          padding: isSuffixPaddingNeeded ?? true
              ? EdgeInsets.only(right: 16.kw, left: 8.kw)
              : const EdgeInsets.all(0),
          child: IconButton(
            icon: suffix ?? const SizedBox(),
            onPressed: onPressedSuffix,
          ),
        ) : const SizedBox(),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16.kw, right: 8.kw, top: 1.kh),
          child: prefix,
        ),
        suffixIconConstraints: BoxConstraints(minHeight: 24.kh),
        prefixIconConstraints: BoxConstraints(minHeight: 24.kh),
        contentPadding:
            EdgeInsets.symmetric(vertical: 16.kh, horizontal: 16.kw),
        hintText: hintText,
        hintStyle: TextStyleUtil.manrope14w400(color: context.black04),
        fillColor: fillColor ?? context.loginSignupTextfieldColor,
        filled: true,
        enabledBorder: border ??
            OutlineInputBorder(
                borderSide: BorderSide(color: context.black07),
                borderRadius: BorderRadius.circular(8.kh)),
        focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.kh)),
        disabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.kh)),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorUtil.kErrorColor),
          borderRadius: BorderRadius.circular(8.kh),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorUtil.kErrorColor),
          borderRadius: BorderRadius.circular(8.kh),
        ),
      ),
    );
  }
}
