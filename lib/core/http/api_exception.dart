import 'package:dio/dio.dart';

abstract class ApiException {
  ApiException({this.statusCode, this.message});

  ApiException.from(DioError error) {
    final response = error.response;

    if (response != null) {
      statusCode = response.statusCode;
      message = parseMessage(response.data);
    }
  }

  late final int? statusCode;
  late final String? message;

  String? parseMessage(dynamic data);
}

class DogException extends ApiException {
  DogException({int? statusCode, String? message})
      : super(statusCode: statusCode, message: message);

  DogException._(DioError error) : super.from(error);

  // Useful to defined a tear-off method
  static DogException from(DioError error) {
    return DogException._(error);
  }

  @override
  String? parseMessage(dynamic data) {
    // Any custom logic in decoding the body of the error message
    // should be performed inside this overridden method
    return data?.toString();
  }
}
