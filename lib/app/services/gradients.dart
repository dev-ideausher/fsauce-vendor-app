import 'package:flutter/material.dart';

class GradientUtil {
  static Gradient dealsOfTheDayCardGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xffFBE8EA).withOpacity(0.1),
        const Color(0xffD43A48).withOpacity(0.1),
      ]);

  static Gradient shadowGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(0.0),
        Colors.black,
      ]);

  static Gradient shadowGradient2 = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(0.0),
        Colors.black.withOpacity(0.6),
      ]);
}
