import 'package:flutter/material.dart';

class AppTypography {
  static String fontFamily = "HaasGrotesk";

  static TextStyle title() {
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.black);
  }

  static TextStyle body() {
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black);
  }

  static TextStyle body2() {
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black);
  }
}
