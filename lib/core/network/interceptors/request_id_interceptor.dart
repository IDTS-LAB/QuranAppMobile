import 'package:dio/dio.dart';

class RequestIdInterceptor extends Interceptor {
  const RequestIdInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Request-Id'] =
        '${DateTime.now().microsecondsSinceEpoch}-${options.path.hashCode}';
    handler.next(options);
  }
}
