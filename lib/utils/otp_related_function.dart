import 'package:flutter_riverpod_template/utils/app_log.dart';

class OtpRelatedFunction {
  OtpRelatedFunction._privateConstructor();
  static final OtpRelatedFunction _instant = OtpRelatedFunction._privateConstructor();
  static OtpRelatedFunction get instant => _instant;
  ///////////////////////  timer function start
  String formatSecondFunction(int seconds) {
    try {
      // Calculate the remaining minutes
      int minutes = (seconds % 3600) ~/ 60;

      // Calculate the remaining seconds
      int secs = seconds % 60;

      // Format minutes, and seconds to be 2 digits
      String formattedMinutes = minutes.toString().padLeft(2, '0');
      String formattedSeconds = secs.toString().padLeft(2, '0');

      return "$formattedMinutes:$formattedSeconds";
    } catch (e) {
      errorLog("formatSecondFunction", e);
      return "00:00";
    }
  }

  String maskEmail(String email) {
    try {
      List<String> parts = email.split('@');
      if (parts.length == 2) {
        if (parts[0].length > 2) {
          return "${parts[0].substring(0, 2)}****@${parts[1]}";
        }
        return "****@${parts[1]}";
      }
    } catch (e) {
      errorLog("maskEmail", e);
    }
    return email;
  }
}
