import 'dart:developer';

import 'package:flutter/foundation.dart';

void errorLog(String message, dynamic e, {String title = "Error form"}) {
  try {
    if (kDebugMode) {
      log("👿😈😡😡😡😡😡😡😡😡😡😡👿👿 $title > $message >>> 🧐🧐 ${e.toString()} ✋🏻✋🏻👋👋👋👋👋👋👋👋👋👋👋👋👋👋👋👋👋👋");
    }
  } catch (e) {
    ///////
  }
}

void appLog(dynamic message) {
  try {
    if (kDebugMode) {
      log("""
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

$message

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

""");
    }
  } catch (e) {
    errorLog("app log", e);
  }
}
