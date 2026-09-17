import 'package:dio/dio.dart';
import '../../errors/app_exception.dart';

AppException mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return TimeoutException(e.message ?? 'Timeout');
    case DioExceptionType.connectionError:
      return const ConnectionException('No connection');
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode;
      if (code == 401) return const UnauthorizedException('Unauthorized');
      if (code == 403) return const ForbiddenException('Forbidden');
      if (code == 404) return const NotFoundException('Not found');
      if (code != null && code >= 400 && code < 500) {
        return ValidationException('Request invalid: $code');
      }
      return ServerException('Server error: $code');
    default:
      return UnknownException(e.message ?? 'Unknown network error');
  }
}

class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: mapDioError(err),
    ));
  }
}
