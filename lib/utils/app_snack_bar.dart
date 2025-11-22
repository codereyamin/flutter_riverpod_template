import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/main_app_entry.dart';
import 'package:flutter_riverpod_template/routes/app_routes.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';

class AppSnackBar {
  // -------- Singleton Setup --------
  AppSnackBar._privateConstructor();
  static final AppSnackBar instance = AppSnackBar._privateConstructor();

  BuildContext? get _context => rootNavigatorKey.currentContext;

  // -------- Snackbar Methods --------
  void error(String message, {bool showTop = true}) {
    try {
      if (showTop) {
        final overlay = appOverlayKey.currentState;
        if (overlay == null) return;

        OverlayEntry overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: AppSize.width(value: 50),
            left: AppSize.width(value: 20),
            right: AppSize.width(value: 20),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(AppSize.width(value: 14)),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                child: Text(message, style: const TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
        );

        overlay.insert(overlayEntry);

        Future.delayed(const Duration(seconds: 2)).then((_) => overlayEntry.remove());
      } else {
        if (_context == null) return;

        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20), vertical: AppSize.width(value: 20)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: Text(message, style: const TextStyle(color: Colors.white)),
          ),
        );
      }
    } catch (e) {
      errorLog("error", e);
    }
  }

  void success(String message, {Duration? duration, bool showTop = true}) {
    if (showTop) {
      final overlay = appOverlayKey.currentState;
      if (overlay == null) return;

      OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: AppSize.width(value: 50),
          left: AppSize.width(value: 20),
          right: AppSize.width(value: 20),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(AppSize.width(value: 14)),
              decoration: BoxDecoration(color: AppColors.instance.success, borderRadius: BorderRadius.circular(12)),
              child: AppText(text: message, color: AppColors.instance.white50, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );

      overlay.insert(overlayEntry);

      Future.delayed(const Duration(seconds: 2)).then((_) => overlayEntry.remove());
    } else {
      if (_context == null) return;

      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.instance.success,
          duration: duration ?? const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20), vertical: AppSize.width(value: 20)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.width(value: 5))),
          content: AppText(text: message, color: AppColors.instance.white50, fontWeight: FontWeight.w500),
        ),
      );
    }
  }

  void message(String message, {Color? backgroundColor, Color? textColor, bool showTop = true}) {
    if (showTop) {
      final overlay = appOverlayKey.currentState;
      if (overlay == null) return;

      OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: AppSize.width(value: 50),
          left: AppSize.width(value: 20),
          right: AppSize.width(value: 20),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(AppSize.width(value: 14)),
              decoration: BoxDecoration(color: backgroundColor ?? AppColors.instance.dark300, borderRadius: BorderRadius.circular(12)),
              child: AppText(text: message, color: textColor ?? AppColors.instance.white300, fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      );

      overlay.insert(overlayEntry);

      Future.delayed(const Duration(seconds: 2)).then((_) => overlayEntry.remove());
    } else {
      if (_context == null) return;

      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor ?? AppColors.instance.dark300,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20), vertical: AppSize.width(value: 20)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.width(value: 5))),
          content: AppText(text: message, color: textColor ?? AppColors.instance.white300, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      );
    }
  }
}
