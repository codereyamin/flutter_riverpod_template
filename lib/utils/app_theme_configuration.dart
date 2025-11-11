import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/constant/app_constant.dart';

class AppThemeConfiguration {
  ////////////// constructor
  AppThemeConfiguration._privateConstructor();
  static final AppThemeConfiguration _instance = AppThemeConfiguration._privateConstructor();
  static AppThemeConfiguration get instance => _instance;

  ThemeData lightThemeData = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.instance.white50,
    dividerColor: AppColors.instance.transparent,
    primaryColor: AppColors.instance.white50,
    primaryColorLight: AppColors.instance.white50,
    splashColor: AppColors.instance.transparent,
    hoverColor: AppColors.instance.transparent,
    appBarTheme: AppBarTheme(elevation: 5, surfaceTintColor: AppColors.instance.white50, backgroundColor: AppColors.instance.white50),
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      bodyMedium: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      bodySmall: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      displayLarge: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      displayMedium: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      displaySmall: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      headlineLarge: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      headlineMedium: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      headlineSmall: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      labelLarge: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      labelMedium: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      labelSmall: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      titleLarge: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      titleMedium: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
      titleSmall: TextStyle(fontFamily: AppConstant.instance.fontFamilyPoppins),
    ),
    focusColor: AppColors.instance.blue500,

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.instance.gray200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.instance.gray200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.instance.gray200),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.instance.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.instance.error),
      ),
    ),
  );

  ThemeData darkThemeData = ThemeData.dark(useMaterial3: true);
}
