import 'package:flutter_riverpod_template/services/storage/storage_key.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices {
  StorageServices._privateConstructor();
  static final StorageServices _instance = StorageServices._privateConstructor();
  static StorageServices get instance => _instance;

  late GetStorage _box;

  Future<void> init() async {
    try {
      await GetStorage.init();
      _box = GetStorage();
      appLog('GetStorage initialized successfully.');
    } catch (e) {
      errorLog("StorageServices init function", e);
    }
  }

  /////////////////// user login data store
  Future<void> setLogDedData(Map<String, String> data) async {
    try {
      _box.write(StorageKey.instance.loginDataStore, data);
    } catch (e) {
      errorLog("setLogDedData data", e);
    }
  }

  Map getLogDedData() {
    try {
      return _box.read(StorageKey.instance.loginDataStore) ?? {};
    } catch (e) {
      errorLog("getLogDedData", e);
      return {};
    }
  }

  ////////////// token storage
  Future<void> setToken(String value) async {
    await _box.write(StorageKey.instance.token, value);
  }

  String getToken() {
    return _box.read(StorageKey.instance.token) ?? "";
  }

  ////////////// refresh token
  Future<void> setRefreshToken(String value) async {
    await _box.write(StorageKey.instance.refreshToken, value);
  }

  String getRefreshToken() {
    return _box.read(StorageKey.instance.refreshToken) ?? "";
  }

  /// Logout (clear all data)
  Future<void> logout() async {
    try {
      await _box.write(StorageKey.instance.refreshToken, "");
      await _box.write(StorageKey.instance.token, "");
      await _box.write(StorageKey.instance.appUserRollData, "");
    } catch (e) {
      errorLog("logout", e);
    }
  }

  //////////// language
  String getLanguage() {
    return _box.read(StorageKey.instance.language) ?? "";
  }

  Future<void> setLanguage(String value) async {
    await _box.write(StorageKey.instance.language, value);
  }

  //////////// app role
  String getAppRoll() {
    return _box.read(StorageKey.instance.appUserRollData) ?? "owner";
  }

  Future<void> setAppRoll(String value) async {
    await _box.write(StorageKey.instance.appUserRollData, value);
  }

  //////////// first time flag
  bool getAppFirstTime() {
    return _box.read(StorageKey.instance.appFirstTime) ?? true;
  }

  Future<void> setAppFirstTime() async {
    try {
      await _box.write(StorageKey.instance.appFirstTime, false);
    } catch (e) {
      errorLog("setAppFirstTime", e);
    }
  }

  //////////// dark mode
  bool isDarkMode() {
    return _box.read(StorageKey.instance.isDarkMode) ?? true;
  }

  Future<void> setDarkMode(bool value) async {
    await _box.write(StorageKey.instance.isDarkMode, value);
  }
}
