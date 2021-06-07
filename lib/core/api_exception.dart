import 'package:dio/dio.dart';

class ApiException {
  ApiException({this.statusCode, this.message});

  factory ApiException.from(DioError error) {
    final response = error.response;

    if (response != null) {
      return ApiException(
        statusCode: response.statusCode,
        // TODO(any): decode Loono backend error message
        message: response.data?.toString(),
      );
    }

    return ApiException();
  }

  final int? statusCode;
  final String? message;
}