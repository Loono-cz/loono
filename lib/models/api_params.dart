import 'package:dio/dio.dart';

class ApiParams {
  const ApiParams({
    this.cancelToken,
    this.headers,
    this.extra,
    this.validateStatus,
    this.onSendProgress,
    this.onReceiveProgress,
  });

  final CancelToken? cancelToken;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? extra;
  final ValidateStatus? validateStatus;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;
}
