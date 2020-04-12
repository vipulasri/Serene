import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle title() {
    return TextStyle(
        fontFamily: "Nunito",
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black);
  }

  static TextStyle body(BuildContext context) {
    return TextStyle(
        fontFamily: "Nunito",
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black);
  }
}
