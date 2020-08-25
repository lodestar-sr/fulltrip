import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    cursorColor: AppColors.primaryColor,
    accentColor: AppColors.primaryColor,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: AppColors.lightestGreyColor,
  );
}

class AppColors {
  static const primaryColor = Color(0xFF5A94F7);
  static const appbarColor = Color(0xFFF6F6F6);
  static const greyColor = Color(0xFF999999);
  static const darkGreyColor = Color(0xFF666666);
  static const lightGreyColor = Color(0xFFD2D2D2);
  static const defaultColor = Color(0xFFABBEFF);
  static const purpleColor = Color(0xFF7695FF);
  static const darkColor = Color(0xFF151522);
  static const whiteColor = Color(0xFFE8F7FF);
  static const lightBlueColor = Color(0xFFB3E6FF);
  static const redColor = Color(0xFFFF0C3E);
  static const greenColor = Color(0xFF6FCF97);
  static const orangeColor = Color(0xFFF2994A);
  static const darkgreenColor = Color(0xFF53D769);
  static const borderwhite = Color(0xFFF7F7F7);
  static const lightGreenColor = Color(0xFFBBFFBA);
  static const greyDarkColor = Color(0xFF202E58);
  static const mediumGreyColor = Color(0xFF9098B1);
  static const senderchatColor = Color(0xFF049FFF);
  static const resetFilterColors = Color(0xFFEC5B62);
  static const backButtonColor = Color(0xFF918E9F);
  static const navigationBarInactiveColor = Color(0xFF92979C);
  static const chatIconColor = Color(0xFFC4C4C4);
  static const lightestGreyColor = Color(0xFFF2F2F2);
  static const compteDivider = Color(0xFFEBF0FF);
  static const inactiveTabTitleColor = Color(0xFF333333);
}

class AppStyles {
  static const navbarInactiveTextStyle = TextStyle(
    color: AppColors.lightGreyColor,
    fontSize: 9,
    fontWeight: FontWeight.normal,
  );
  static const navbarActiveTextStyle = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 9,
    fontWeight: FontWeight.normal,
  );
  static const blackTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static const greyTextStyle = TextStyle(
    color: AppColors.greyColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static const darkGreyTextStyle = TextStyle(
    color: AppColors.darkGreyColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static const primaryTextStyle = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static const defaultHintTextStyle = TextStyle(
    color: AppColors.greyColor,
    fontSize: 14,
  );
  static const tabLabelStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );
  static const declineActionTextStyle = TextStyle(
    color: AppColors.backButtonColor,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  static const orangeTextStyle = TextStyle(
    color: AppColors.orangeColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const greenTextStyle = TextStyle(
    color: AppColors.greenColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const versionTextStyle = TextStyle(
    color: AppColors.greyColor,
    fontSize: 15,
  );
  static const confirmationTextStyle = TextStyle(
    color: AppColors.inactiveTabTitleColor,
    fontSize: 19,
    fontWeight: FontWeight.w500,
    height: 1.47,
  );
  static const confirmationHintStyle = TextStyle(
    color: AppColors.backButtonColor,
    fontSize: 15,
    fontWeight: FontWeight.normal,
    height: 1.47,
  );
  static const missingDataTextStyle = TextStyle(
    color: AppColors.greyColor,
    fontSize: 14,
    height: 1.8,
  );
}

InputDecoration hintTextDecoration(String text) {
  return InputDecoration(
    hintText: text,
//    border: InputBorder.none,
    labelStyle: AppStyles.defaultHintTextStyle,
    hintStyle: AppStyles.defaultHintTextStyle,
  );
}
