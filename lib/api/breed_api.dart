import 'package:dio/dio.dart';
import 'package:loono/api/dog.api_client.dart';
import 'package:loono/core/http/api_config.dart';
import 'package:loono/dtos/breed_api/breeds.dart';
import 'package:loono/dtos/breed_api/random_image.dto.dart';

class BreedApi extends DogApiClient {
  BreedApi(Dio httpClient, ApiConfig apiConfig) : super(httpClient, apiConfig);

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
