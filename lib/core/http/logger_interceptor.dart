import 'package:dio/dio.dart';
import 'package:loono/core/app_logger.dart';

class LoggerInterceptor extends Interceptor {
  final AppLogger _logger = AppLogger('LoggerInterceptor');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger
      ..info(
        '${options.method.toUpperCase()} '
        '${"${options.baseUrl}${options.path}"}',
      )
      ..info('Headers:');
    options.headers.forEach((k, dynamic v) => _logger.info('$k: $v'));

    if (options.queryParameters.isNotEmpty) {
      _logger.info('queryParameters:');
      options.queryParameters.forEach(
        (k, dynamic v) => _logger.info('$k: $v'),
      );
    }

    if (options.data != null) {
      _logger.info('Body: ${options.data}');
    }
    _logger.info('END ${options.method.toUpperCase()}');

    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final response = err.response;
    final requestOptions = err.requestOptions;

    _logger
      ..info('HTTP Error')
      ..info('Error message: ${err.message}')
      ..info(
        'Request: ${requestOptions.method} '
        '${requestOptions.baseUrl}${requestOptions.path}',
      )
      ..info('Body: ${response != null ? response.data : ''}')
      ..info('End HTTP Error');

    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final requestOptions = response.requestOptions;

    _logger
      ..info('HTTP Response')
      ..info(
        '${response.statusCode} '
        '${requestOptions.baseUrl}${requestOptions.path}',
      )
      ..info('Headers:');

    response.headers.forEach((k, v) => _logger.info('$k: $v'));

    _logger..info('Response: ${response.data}')..info('END HTTP Response');

    handler.next(response);
  }
}
