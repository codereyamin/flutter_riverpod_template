import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';

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
    splashColor: AppColors.instance.white50,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.instance.white50),
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
