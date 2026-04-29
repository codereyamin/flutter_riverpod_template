import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod_template/constant/app_api_url.dart';
import 'package:flutter_riverpod_template/routes/app_routes.dart';
import 'package:flutter_riverpod_template/routes/app_routes_key.dart';
import 'package:flutter_riverpod_template/services/api/non_auth_api.dart';
import 'package:flutter_riverpod_template/services/storage/storage_services.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppApi {
  final Dio _dio = Dio();
  AppApi._privateConstructor();
  static final AppApi _instance = AppApi._privateConstructor();
  static AppApi get instance => _instance;

  ///////////////////////  object
  final _storage = StorageServices.instance;
  final appRoutes = AppRoutes.instance;

  bool _isRefreshing = false;
  final _refreshCompleter = <Completer<String?>>[];

  AppApi() {
    _dio.options
      ..baseUrl = AppApiUrl.instance.baseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..sendTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..followRedirects = false
      ..validateStatus = (status) => status != null && status < 400;

    _dio.interceptors.addAll({
      InterceptorsWrapper(onRequest: _onRequest, onError: _onError),
      if (kDebugMode)
        PrettyDioLogger(requestHeader: true, request: true, compact: true, error: true, requestBody: true, responseHeader: true, responseBody: true),
    });
  }

  Dio get sendRequest => _dio;

  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.baseUrl = AppApiUrl.instance.baseUrl;
    options.headers['Accept'] = 'application/json';
    options.contentType ??= Headers.jsonContentType;

    final token = await _storage.getToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  void _onError(DioException error, ErrorInterceptorHandler handler) async {
    appLog('API error — status: ${error.response?.statusCode} | ${error.message}');

    if (error.response?.statusCode == 401) {
      try {
        final newToken = await _refreshAccessToken();
        if (newToken != null && newToken.isNotEmpty) {
          // Retry the original request with the new token
          error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          final retried = await _dio.fetch(error.requestOptions);
          return handler.resolve(retried);
        }
      } catch (e) {
        errorLog('token refresh failed', e);
      }

      // Refresh failed — logout and redirect
      await _forceLogout();
      return handler.next(error);
    }

    handler.next(error);
  }

  // #12 — Mutex-guarded refresh: only one refresh in-flight at a time
  Future<String?> _refreshAccessToken() async {
    if (_isRefreshing) {
      // Queue callers that arrive while refresh is in-flight
      final completer = Completer<String?>();
      _refreshCompleter.add(completer);
      return completer.future;
    }

    _isRefreshing = true;
    String? newToken;

    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken.isEmpty) return null;

      final response = await NonAuthApi().sendRequest.post(AppApiUrl.instance.refreshToken, data: {'token': refreshToken});

      if (response.statusCode == 200) {
        final data = response.data?['data'];
        if (data is Map && data['accessToken'] is String) {
          newToken = data['accessToken'] as String;
          await _storage.setToken(newToken);
        }
      }
    } catch (e) {
      errorLog('_refreshAccessToken', e);
    } finally {
      _isRefreshing = false;
      // Resolve all queued callers
      for (final c in _refreshCompleter) {
        c.complete(newToken);
      }
      _refreshCompleter.clear();
    }

    return newToken;
  }

  // #13 — Clear auth header before redirect so it can't leak on the splash route
  Future<void> _forceLogout() async {
    _dio.options.headers.remove('Authorization');
    await StorageServices.instance.logout();
    AppRoutes.instance.pushReplacement(AppRoutesKey.instance.splash);
  }
}

// Token refresh logic
Future<String> reFreshNewAccessToken(String refreshToken) async {
  try {
    final response = await NonAuthApi().sendRequest.post(AppApiUrl.instance.refreshToken, data: {"token": refreshToken});
    if (response.statusCode == 200) {
      if (response.data["data"] != null && response.data["data"] is Map) {
        var data = response.data["data"];
        if (data["accessToken"] != null && data["accessToken"] is String) {
          await StorageServices.instance.setToken(data["accessToken"]);
          return data["accessToken"].toString();
        }
      }
    } else {
      await StorageServices.instance.logout();
    }
  } catch (e) {
    errorLog("reFreshNewAccessToken", e);
  }
  return "";
}
