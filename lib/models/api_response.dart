import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const ApiResponse._();

  const factory ApiResponse.success(T data) = SuccessApiResponse;

  const factory ApiResponse.failure(DioError error) = FailureApiResponse;
}
