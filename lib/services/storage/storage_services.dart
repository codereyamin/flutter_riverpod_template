import 'dart:convert';

import 'package:flutter_riverpod_template/services/storage/storage_key.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  StorageServices._privateConstructor();
  static final StorageServices _instance = StorageServices._privateConstructor();
  static StorageServices get instance => _instance;

  ////////////// storage initial
  // Secure storage (Keychain / Keystore)
  static const _secure = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true, resetOnError: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.unlocked_this_device),
  );

  //  Non-sensitive preferences
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  ////////////// token storage
  Future<void> setToken(String value) async {
    await _secure.write(key: StorageKey.instance.token, value: value);
  }

  Future<String> getToken() async {
    try {
      return await _secure.read(key: StorageKey.instance.token) ?? '';
    } catch (e) {
      errorLog("get token", e);
      return "";
    }
  }

  ////////////// refresh token
  Future<void> setRefreshToken(String value) async {
    await _secure.write(key: StorageKey.instance.refreshToken, value: value);
  }

  Future<String> getRefreshToken() async {
    try {
      return await _secure.read(key: StorageKey.instance.refreshToken) ?? '';
    } catch (e) {
      errorLog("get refreshToken", e);
      return "";
    }
  }

  /////////////////// user login data store
  Future<void> setLogDedData(Map<String, String> data) async {
    try {
      await _secure.write(key: StorageKey.instance.loginDataStore, value: jsonEncode(data));
    } catch (e) {
      errorLog("setLogDedData data", e);
    }
  }

  Future<Map<String, dynamic>> getLogDedData() async {
    try {
      final raw = await _secure.read(key: StorageKey.instance.loginDataStore);
      if (raw == null || raw.isEmpty) return {};
      return Map<String, dynamic>.from(jsonDecode(raw) as Map);
    } catch (e) {
      errorLog("getLogDedData", e);
      return {};
    }
  }

  //////////// app role
  Future<String> getAppRoll() async {
    try {
      return await _secure.read(key: StorageKey.instance.appUserRollData) ?? 'user';
    } catch (e) {
      errorLog('getAppRoll', e);
      return 'user';
    }
  }

  Future<void> setAppRoll(String value) async {
    await _secure.write(key: StorageKey.instance.appUserRollData, value: value);
  }

  /// Logout (clear all data)
  Future<void> logout() async {
    try {
      await _secure.deleteAll();
    } catch (e) {
      errorLog("logout", e);
    }
  }

  //////////////////////////// Non-sensitive preferences (SharedPreferences OK)

  //////////// language
  Future<String> getLanguage() async {
    final pref = await _pref;
    return pref.getString(StorageKey.instance.language) ?? "";
  }

  Future<void> setLanguage(String value) async {
    final pref = await _pref;
    await pref.setString(StorageKey.instance.language, value);
  }

  //////////// first time flag
  Future<bool> getAppFirstTime() async {
    final pref = await _pref;
    return pref.getBool(StorageKey.instance.appFirstTime) ?? true;
  }

  Future<void> setAppFirstTime() async {
    try {
      final pref = await _pref;
      await pref.setBool(StorageKey.instance.appFirstTime, false);
    } catch (e) {
      errorLog("setAppFirstTime", e);
    }
  }

  //////////// dark mode
  Future<bool> isDarkMode() async {
    final pref = await _pref;
    return pref.getBool(StorageKey.instance.isDarkMode) ?? true;
  }

  Future<void> setDarkMode(bool value) async {
    final pref = await _pref;
    await pref.setBool(StorageKey.instance.isDarkMode, value);
  }
}
