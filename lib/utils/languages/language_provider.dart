import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _LanguageNotifier extends Notifier<String> {
  @override
  String build() {
    _loadLanguage();
    return "en_US";
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString("app_language") ?? "en_US";

    /// en_U Ses_ES
    state = saved;
  }

  Future<void> setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("app_language", lang);
    state = lang;
  }
}

final languageProvider = NotifierProvider<_LanguageNotifier, String>(() {
  return _LanguageNotifier();
});

class _InitialLanguage extends Notifier<String> {
  @override
  String build() {
    _loadLanguage();
    return "en_US";
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString("app_language") ?? "en_US";
    state = saved;
  }

  Future<void> setLanguage(String lang) async {
    state = lang;
  }
}

final initialLanguageProvider = NotifierProvider<_InitialLanguage, String>(() {
  return _InitialLanguage();
});
