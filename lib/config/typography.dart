import 'package:flutter/material.dart';

class AppTypography {
  static String fontFamily = "Roboto";
  static Color textColor = Color(0xFF1D2632);

  static TextStyle appTitle() {
    return TextStyle(
        fontFamily: "Caveat",
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: textColor);
  }

  static TextStyle title() {
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textColor);
  }

  static TextStyle body() {
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor);
  }

  static TextStyle body2() {
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor);
  }
}
