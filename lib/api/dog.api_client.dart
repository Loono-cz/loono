import 'package:dio/dio.dart';
import 'package:loono/core/http/api_config.dart';
import 'package:loono/core/http/api_exception.dart';
import 'package:loono/core/http/base_api_client.dart';

abstract class DogApiClient extends BaseApiClient<DogException> {
  DogApiClient(Dio httpClient, this._apiConfig)
      : super(httpClient, DogException.from);

  final ApiConfig _apiConfig;

  @override
  Uri buildUri({
    required String endpoint,
    required Map<String, dynamic> queryParams,
  }) {
    return Uri(
      scheme: _apiConfig.scheme,
      host: _apiConfig.host,
      path: '${_apiConfig.path}/$endpoint',
      port: _apiConfig.port,
      queryParameters: queryParams,
    );
  }
}
