import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';

class AppApiUrl {
  AppApiUrl._privateConstructor();
  static final AppApiUrl _instance = AppApiUrl._privateConstructor();
  static AppApiUrl get instance => _instance;
  //////////////  app base api end point

  static final String _baseUrlFromEnv = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.yourapp.com', // safe fallback for CI
  );

  static String _validateUrl(String url) {
    // Block plain HTTP in release builds — HTTPS required in production
    if (!kDebugMode && url.startsWith('http://')) {
      errorLog('AppApiUrl', 'HTTP (non-TLS) base URL blocked in release build. Use HTTPS.');
      assert(false, 'Production builds must use HTTPS. Got: $url');
    }
    return url;
  }

  static final String domain = _validateUrl(_baseUrlFromEnv);
  static final String socket = _validateUrl(_baseUrlFromEnv);
  final String baseUrl = "$domain/api/v1";

  //////////////////////////////////  base
  String refreshToken = "/refreshToken";
  String userProfile = "/user/profile";
  String about = "/rule/about";
  String privacyPolicy = "/rule/privacy-policy";
  String termsAndConditions = "/rule/terms-and-conditions";
  String faq = "/faq";
  String notification = "/notification";
  ////////////
  String login = "/login";
  String authDeleteAccount = "/authDeleteAccount";
  String user = "/user";
  String changePassword = "/changePassword";
  String userResendOtp = "/userResendOtp";
  String authOtpVerify = "/authOtpVerify";
  String authForgotPassword = "/authForgotPassword";
  String authVerifyEmail = "/authVerifyEmail";
  String authResetPassword = "/authResetPassword";
}
