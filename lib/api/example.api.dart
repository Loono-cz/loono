import 'package:dio/dio.dart';
import 'package:loono/core/http/api_config.dart';
import 'package:loono/core/http/base_api_client.dart';
import 'package:loono/dtos/example_api/breeds.dart';
import 'package:loono/dtos/example_api/random_image.dto.dart';

class ExampleApi extends BaseApiClient {
  ExampleApi(Dio httpClient, this._apiConfig) : super(httpClient);

  // Usually all the endpoints related to the same functionality have some
  // part of the URL in common, populate this variable with that value
  // and use it when building the endpoint string
  // e.g. endpoint: '$_baseUrl/some/path'
  // static const _baseUrl = 'breed';

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

  Future<RandomImageDto> getRandomImage() async {
    return getAsMap(
      endpoint: 'breeds/image/random',
      mapper: RandomImageDto.fromJson,
    );
  }

  Future<RandomImageDto> getRandomImageByBreed({required Breed breed}) async {
    return getAsMap(
      endpoint: 'breed/${breed.asString}/images/random',
      mapper: RandomImageDto.fromJson,
    );
  }
}
