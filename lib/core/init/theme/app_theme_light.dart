import 'package:bitely/core/constants/color/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_theme.dart';

class AppThemeLight extends AppTheme {
  // # Uygulama hayatı boyunca tek bir theme nesnesine ihtiyaç duyacağı için oluşturduğumuz singleton yapımız
  static AppThemeLight? _instance;
  static AppThemeLight get instance {
    _instance ??= AppThemeLight._init();
    return _instance!;
  }

  AppThemeLight._init();

  @override
  ThemeData get theme => ThemeData.light().copyWith(
      scaffoldBackgroundColor: ColorConstants.whiteColor,
      textTheme: _buildTextTheme,
      inputDecorationTheme: _buildInputDecoration,
      appBarTheme: _buildAppBarTheme,
      elevatedButtonTheme: _buildButtonDecoration,
      floatingActionButtonTheme: _buildFloatButtonTheme,
      progressIndicatorTheme: _buildProgressIndicator);
  TextTheme get _buildTextTheme => TextTheme(
      headlineMedium: TextStyle(
          fontSize: 60.sp,
          color: ColorConstants.darkBlackColor,
          fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontSize: 15.sp,
          fontFamily: 'SF-Pro',
          color: ColorConstants.semiBlackColor,
          fontWeight: FontWeight.w700),
      bodySmall: TextStyle(
          fontSize: 12.sp,
          fontFamily: 'SF-Pro',
          color: ColorConstants.lightenGrayColor,
          fontWeight: FontWeight.normal),
      labelSmall: TextStyle(
          fontSize: 8.sp,
          fontFamily: 'SF-Pro',
          color: ColorConstants.tineGrayColor,
          fontWeight: FontWeight.normal),
      labelLarge: TextStyle(
          fontSize: 12.sp,
          fontFamily: 'Inter',
          color: ColorConstants.whiteColor,
          fontWeight: FontWeight.normal),
      titleMedium: TextStyle(
          fontSize: 12.0.sp,
          fontFamily: 'Moderat',
          color: ColorConstants.darkBlackColor,
          fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(
          fontSize: 10.0.sp,
          fontFamily: 'Inter',
          color: ColorConstants.semiDarkBlackColor,
          fontWeight: FontWeight.w700));
  ElevatedButtonThemeData get _buildButtonDecoration => ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.darkBlackColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
      ));
  InputDecorationTheme get _buildInputDecoration => InputDecorationTheme(
      helperStyle: TextStyle(
          fontSize: 10.sp,
          fontFamily: 'SF-Pro',
          color: ColorConstants.blackColor,
          fontWeight: FontWeight.normal),
      filled: true,
      fillColor: ColorConstants.lightGrayColor.withOpacity(0.3),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.sp)),
          borderSide: BorderSide(color: ColorConstants.transparentColor)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.sp)),
          borderSide: BorderSide(color: ColorConstants.transparentColor)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.sp)),
          borderSide: BorderSide(color: ColorConstants.transparentColor)),
      hintStyle: TextStyle(
          color: ColorConstants.blackColor,
          fontSize: 10.sp,
          //fontFamily: 'SF-Pro',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal));
  ProgressIndicatorThemeData get _buildProgressIndicator =>
      ProgressIndicatorThemeData(
          refreshBackgroundColor: ColorConstants.whiteColor.withOpacity(0.3),
          color: ColorConstants.lightGrayColor);
  AppBarTheme get _buildAppBarTheme => AppBarTheme(
      elevation: 0,
      backgroundColor: ColorConstants.darkBlackColor,
      centerTitle: false,
      titleSpacing: 0,
      titleTextStyle: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 14.sp,
          fontFamily: 'Moderat',
          color: ColorConstants.whiteColor,
          fontWeight: FontWeight.w700));
  FloatingActionButtonThemeData get _buildFloatButtonTheme =>
      FloatingActionButtonThemeData(
        backgroundColor: ColorConstants.darkBlackColor,
      );
}
