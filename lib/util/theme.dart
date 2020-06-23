import 'package:flutter/material.dart';
import 'package:fulltrip/data/models/hex_color.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    cursorColor: AppColors.primaryColor,
    accentColor: AppColors.primaryColor,
    fontFamily: 'Roboto'
  );
}

class AppColors {
  static const primaryColor = Color(0xFF40BFFF);
}

class AppStyles {
  static const defaultHintTextStyle = TextStyle(color: AppColors.primaryColor, fontSize: 20);
  static const double gap_16 = 16;
}

InputDecoration labelDecoration(String text) {
  return InputDecoration(labelText: text, border: InputBorder.none, labelStyle: AppStyles.defaultHintTextStyle, hintStyle: AppStyles.defaultHintTextStyle);
}

InputDecoration hintTextDecoration(String text) {
  return InputDecoration(hintText: text, border: InputBorder.none, labelStyle: AppStyles.defaultHintTextStyle, hintStyle: AppStyles.defaultHintTextStyle);
}