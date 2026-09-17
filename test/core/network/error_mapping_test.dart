import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/errors/app_exception.dart';
import 'package:quran_app/core/network/interceptors/error_interceptor.dart';

void main() {
  test('404 maps to NotFoundException', () {
    final err = mapDioError(DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response(requestOptions: RequestOptions(path: '/x'), statusCode: 404),
      type: DioExceptionType.badResponse,
    ));
    expect(err, isA<NotFoundException>());
  });
  test('timeout maps to TimeoutException', () {
    final err = mapDioError(DioException(
      requestOptions: RequestOptions(path: '/x'),
      type: DioExceptionType.connectionTimeout,
    ));
    expect(err, isA<TimeoutException>());
  });
}
