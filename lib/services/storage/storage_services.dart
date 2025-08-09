import 'package:flutter_riverpod_template/services/storage/storage_key.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

late Box _box; // Single encrypted box
late List<int> _encryptionKey;

class StorageServices {
  StorageServices._privateConstructor();
  static final StorageServices _instance = StorageServices._privateConstructor();
  static StorageServices get instance => _instance;

  /// Initialize Hive with one encrypted box
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    // Open key storage box (unencrypted)
    var keyBox = await Hive.openBox('keyBox');

    // Load or generate encryption key
    _encryptionKey = keyBox.get('encryptionKey');
    if (_encryptionKey.isNotEmpty) {
      _encryptionKey = Hive.generateSecureKey();
      await keyBox.put('encryptionKey', _encryptionKey);
    }

    // Open encrypted data box
    _box = await Hive.openBox('appBox', encryptionCipher: HiveAesCipher(_encryptionKey));
  }

  ////////////// token storage
  Future<void> setToken(String value) async {
    await _box.put(StorageKey.instance.token, value);
  }

  String getToken() {
    return _box.get(StorageKey.instance.token, defaultValue: "");
  }

  ////////////// refresh token
  Future<void> setRefreshToken(String value) async {
    await _box.put(StorageKey.instance.refreshToken, value);
  }

  String getRefreshToken() {
    return _box.get(StorageKey.instance.refreshToken, defaultValue: "");
  }

  /// Logout (clear all data)
  Future<void> logout() async {
    await _box.clear();
  }

  //////////// language
  String getLanguage() {
    return _box.get(StorageKey.instance.language, defaultValue: "");
  }

  Future<void> setLanguage(String value) async {
    await _box.put(StorageKey.instance.language, value);
  }

  //////////// app role
  String? getAppRoll() {
    return _box.get(StorageKey.instance.appUserRollData);
  }

  Future<void> setAppRoll(String value) async {
    await _box.put(StorageKey.instance.appUserRollData, value);
  }

  //////////// first time flag
  bool getAppFirstTime() {
    return _box.get(StorageKey.instance.appFirstTime, defaultValue: true);
  }

  Future<void> setAppFirstTime() async {
    await _box.put(StorageKey.instance.appFirstTime, false);
  }

  bool isDarkMode() {
    return _box.get(StorageKey.instance.isDarkMode, defaultValue: true);
  }

  Future<void> setDarkMode(bool value) async {
    await _box.put(StorageKey.instance.isDarkMode, value);
  }
}
