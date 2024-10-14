import 'package:flutter/material.dart';
import 'hexColorToFlutterColor.dart';

extension ColorUtil on BuildContext {
  Color dynamicColor({required int light, required int dark}) {
    return (Theme.of(this).brightness == Brightness.light)
        ? Color(light)
        : Color(dark);
  }

  Color dynamicColour({required Color light, required Color dark}) {
    return (Theme.of(this).brightness == Brightness.light) ? light : dark;
  }

  Color get brandColor1 =>
      dynamicColour(light: HexColor("#5D48D0"), dark: HexColor("#000000"));

  Color get brandColor2 =>
      dynamicColour(light: HexColor("#8032A8"), dark: HexColor("#000000"));

  Color get primary02 =>
      dynamicColour(light: HexColor("#D43A48"), dark: HexColor("#D43A48"));
  Color get primary03 =>
      dynamicColour(light: HexColor("#DC5D69"), dark: HexColor("#DC5D69"));
  Color get primary04 =>
      dynamicColour(light: HexColor("#E47F89"), dark: HexColor("#E47F89"));
  Color get primary01 =>
      dynamicColour(light: HexColor("#CC1728"), dark: HexColor("#CC1728"));
  Color get primary05 =>
      dynamicColour(light: HexColor("#EBA2A9"), dark: HexColor("#EBA2A9"));
  Color get primary06 =>
      dynamicColour(light: HexColor("#F3C5C9"), dark: HexColor("#F3C5C9"));
  Color get primary07 =>
      dynamicColour(light: HexColor("#FBE8EA"), dark: HexColor("#FBE8EA"));
  Color get black03 =>
      dynamicColour(light: HexColor("#5D5D5D"), dark: HexColor("#5D5D5D"));
  Color get black01 =>
      dynamicColour(light: HexColor("#111111"), dark: HexColor("#111111"));
  Color get black02 =>
      dynamicColour(light: HexColor("#373737"), dark: HexColor("#373737"));
  Color get black04 =>
      dynamicColour(light: HexColor("#828282"), dark: HexColor("#828282"));
  Color get black07 =>
      dynamicColour(light: HexColor("#F4F4F4"), dark: HexColor("#F4F4F4"));
  Color get hintTextColor =>
      dynamicColour(light: HexColor("#828282"), dark: HexColor("#828282"));
  Color get borderColor1 =>
      dynamicColour(light: HexColor("#E6E6E6"), dark: HexColor("#E6E6E6"));
  Color get borderColor2 =>
      dynamicColour(light: HexColor("#F4F4F4"), dark: HexColor("#F4F4F4"));
  Color get searchBoxColor1 => dynamicColour(
        light: HexColor("#D9D9D9").withOpacity(0.16),
        dark: HexColor("#D9D9D9").withOpacity(0.16),
      );

  Color get green =>
      dynamicColour(light: HexColor("#34A853"), dark: HexColor("#34A853"));
  Color get golden =>
      dynamicColour(light: HexColor("#FFD80A"), dark: HexColor("#FFD80A"));
  Color get loginSignupTextfieldColor =>
      dynamicColour(light: HexColor("#FCFCFC"), dark: HexColor("#FCFCFC"));
  Color get black05 =>
      dynamicColour(light: HexColor("#E6E6E6"), dark: HexColor("#E6E6E6"));
  Color get white =>
      dynamicColour(light: HexColor("#FFFFFF"), dark: HexColor("#FFFFFF"));

  static const Color kErrorColor = Color(0xffde2121);
  static const Color kBlack04 = Color(0xff828281);
  static const Color kWhiteColor = Color(0xffffffff);
}
