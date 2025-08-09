import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/main_app_entry.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';

class AppSnackBar {
  AppSnackBar._privateConstructor();
  static final AppSnackBar _instance = AppSnackBar._privateConstructor();
  static AppSnackBar get instance => _instance;

  void error(
    String parameterValue, {
    Duration? duration,
    bool showCloseIcon = false,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry? padding,
    double? width,
  }) {
    try {
      rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      rootScaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor ?? AppColors.instance.error,
          showCloseIcon: showCloseIcon,
          behavior: SnackBarBehavior.floating,
          elevation: 5,
          padding: padding ?? EdgeInsets.all(AppSize.width(value: 10.0)),
          width: width ?? AppSize.size.width * 0.8,
          duration: duration ?? Duration(seconds: 5),
          content: AppText(text: parameterValue, color: AppColors.instance.white50),
        ),
      );
    } catch (e) {
      errorLog("parameterValue AppSnackBar", e);
    }
  }

  void success(
    String parameterValue, {
    Duration? duration,
    bool showCloseIcon = false,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsetsGeometry? padding,
    double? width,
  }) {
    try {
      rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      rootScaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor ?? AppColors.instance.success,
          showCloseIcon: showCloseIcon,
          behavior: SnackBarBehavior.floating,
          elevation: 5,
          padding: padding ?? EdgeInsets.all(AppSize.width(value: 10.0)),
          width: width ?? AppSize.size.width * 0.8,
          duration: duration ?? Duration(seconds: 5),
          content: AppText(text: parameterValue, color: textColor ?? AppColors.instance.white50),
        ),
      );
    } catch (e) {
      errorLog("parameterValue AppSnackBar", e);
    }
  }

  void message(
    String parameterValue, {
    Duration? duration,
    bool showCloseIcon = false,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    double? width,
    Color? textColor,
  }) {
    try {
      rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      rootScaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor ?? AppColors.instance.black50,
          showCloseIcon: showCloseIcon,
          behavior: SnackBarBehavior.floating,
          elevation: 5,
          padding: padding ?? EdgeInsets.all(AppSize.width(value: 10.0)),
          width: width ?? AppSize.size.width * 0.8,
          duration: duration ?? Duration(seconds: 5),
          content: AppText(text: parameterValue, color: textColor ?? AppColors.instance.black900),
        ),
      );
    } catch (e) {
      errorLog("parameterValue AppSnackBar", e);
    }
  }
}
