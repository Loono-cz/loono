import 'package:loono/api/breed_api.dart';
import 'package:loono/core/http/api_exception.dart';
import 'package:loono/core/maybe_failure.dart';
import 'package:loono/dtos/breed_api/breeds.dart';
import 'package:loono/dtos/breed_api/random_image.dto.dart';
import 'package:loono/models/breed/random_image.model.dart';

class BreedService {
  BreedService(this._breedApi);

  final BreedApi _breedApi;

  Future<MaybeFailure<String>> getRandomImage({
    Breed? breed,
  }) async {
    try {
      late RandomImageDto response;

      if (breed != null) {
        response = await _breedApi.getRandomImageByBreed(breed: breed);
      } else {
        response = await _breedApi.getRandomImage();
      }

      final model = RandomImageModel.fromDto(response);

      if (model.isSuccessful) {
        return MaybeFailure.success(model.imageUrl);
      }

      return MaybeFailure.failure(
        DogException(message: response.message),
      );
    } on ApiException catch (e) {
      return MaybeFailure.failure(e);
    }
  }
}
