import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod_template/constant/app_api_url.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NonAuthApi {
  final Dio _dio = Dio();

  NonAuthApi() {
    _dio.options
      ..baseUrl = AppApiUrl.instance.baseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..sendTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..followRedirects = false
      ..headers['Accept'] = 'application/json'
      ..contentType = 'application/json';

    _dio.interceptors.addAll([
      InterceptorsWrapper(onError: (error, handler) => handler.next(error)),

      if (kDebugMode)
        PrettyDioLogger(requestHeader: true, request: true, compact: true, error: true, requestBody: true, responseHeader: false, responseBody: true),
    ]);
  }

  Dio get sendRequest => _dio;
}
