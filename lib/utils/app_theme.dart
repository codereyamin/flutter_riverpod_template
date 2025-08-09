import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/services/storage/storage_services.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  bool isDarkMode = false;
  StorageServices storageServices = StorageServices.instance;

  ThemeNotifier() : super(ThemeMode.light) {
    _init();
  }

  Future<void> _init() async {
    try {
      isDarkMode = storageServices.isDarkMode();
      state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    } catch (e) {
      errorLog("_init. ThemeNotifier", e);
    }
  }

  void toggleTheme() {
    try {
      if (state == ThemeMode.light) {
        state = ThemeMode.dark;
        storageServices.setDarkMode(true);
      } else {
        state = ThemeMode.light;
        storageServices.setDarkMode(false);
      }
    } catch (e) {
      errorLog("toggleTheme", e);
    }
  }
}

/// Riverpod provider for theme
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
