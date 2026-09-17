import 'package:dio/dio.dart';
import 'package:quran_app/core/constants/app_constants.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/request_id_interceptor.dart';

abstract final class DioClient {
  static Dio create({String? baseUrl}) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? AppConstants.apiBaseUrl,
      connectTimeout:
          const Duration(milliseconds: AppConstants.connectTimeoutMs),
      receiveTimeout:
          const Duration(milliseconds: AppConstants.receiveTimeoutMs),
      sendTimeout: const Duration(milliseconds: AppConstants.sendTimeoutMs),
      headers: {'Accept': 'application/json'},
    ));
    dio.interceptors.addAll([
      RequestIdInterceptor(),
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);
    return dio;
  }
}
