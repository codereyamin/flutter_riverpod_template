import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  ////////////// constructor
  AppRoutes._privateConstructor();
  static final AppRoutes _instance = AppRoutes._privateConstructor();
  static AppRoutes get instance => _instance;
  //////////////// routes
  late GoRouter _router;

  void setRouter(GoRouter router) {
    _router = router;
  }

  void go(String value) {
    try {
      _router.go(value);
    } catch (e) {
      errorLog("goNamed", e);
    }
  }

  void goNamed(
    String value, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
    String? fragment,
  }) {
    try {
      _router.goNamed(value, pathParameters: pathParameters, extra: extra, fragment: fragment, queryParameters: queryParameters);
    } catch (e) {
      errorLog("goNamed", e);
    }
  }

  void replace(String value, {Object? extra}) {
    try {
      _router.replace(value, extra: extra);
    } catch (e) {
      errorLog("replaceNamed", e);
    }
  }

  void replaceNamed(
    String value, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    try {
      _router.replaceNamed(value, pathParameters: pathParameters, extra: extra, queryParameters: queryParameters);
    } catch (e) {
      errorLog("replaceNamed", e);
    }
  }

  void push(
    String value, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    try {
      _router.push(value, extra: extra);
    } catch (e) {
      errorLog("push", e);
    }
  }

  void pushNamed(
    String value, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    try {
      _router.pushNamed(value, pathParameters: pathParameters, extra: extra, queryParameters: queryParameters);
    } catch (e) {
      errorLog("pushNamed", e);
    }
  }

  void pushReplacement(
    String value, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    try {
      _router.pushReplacement(value, extra: extra);
    } catch (e) {
      errorLog("pushReplacement", e);
    }
  }

  void pushReplacementNamed(
    String value, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    try {
      _router.pushReplacementNamed(value, pathParameters: pathParameters, extra: extra, queryParameters: queryParameters);
    } catch (e) {
      errorLog("pushReplacementNamed", e);
    }
  }
}
