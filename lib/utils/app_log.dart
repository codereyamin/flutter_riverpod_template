import 'dart:developer';

import 'package:flutter/foundation.dart';

final _sensitivePatterns = RegExp(
  r'(Bearer\s+[\w\-\.]+|"password"\s*:\s*"[^"]*"|"token"\s*:\s*"[^"]*"|"accessToken"\s*:\s*"[^"]*")',
  caseSensitive: false,
);

String _redact(String input) {
  if (!kDebugMode) return '';
  return input.replaceAll(_sensitivePatterns, '[REDACTED]');
}

void errorLog(String message, dynamic e, {String title = "Error form"}) {
  try {
    if (kDebugMode) {
      final safe = _redact('$title > $message >>> ${e.toString()}');
      log("👿😈😡😡😡😡😡😡😡😡😡😡👿👿 $safe ✋🏻✋🏻👋👋👋👋👋👋👋👋👋👋👋👋👋👋👋👋👋👋");
    }
  } catch (e) {
    ///////
  }
}

void appLog(dynamic message) {
  try {
    if (kDebugMode) {
      final safe = _redact(message.toString());
      log("""
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

$safe

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

""");
    }
  } catch (e) {
    errorLog("app log", e);
  }
}
