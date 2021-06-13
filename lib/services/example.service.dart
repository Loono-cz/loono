import 'package:loono/api/example.api.dart';
import 'package:loono/core/http/api_exception.dart';
import 'package:loono/core/maybe_failure.dart';
import 'package:loono/dtos/example_api/breeds.dart';
import 'package:loono/dtos/example_api/random_image.dto.dart';
import 'package:loono/models/example/random_image.model.dart';

class ExampleService {
  ExampleService(this._exampleApi);

  final ExampleApi _exampleApi;

  Future<MaybeFailure<String>> getRandomImage({
    Breed? breed,
  }) async {
    try {
      late RandomImageDto response;

      if (breed != null) {
        response = await _exampleApi.getRandomImageByBreed(breed: breed);
      } else {
        response = await _exampleApi.getRandomImage();
      }

      final model = RandomImageModel.fromDto(response);

      if (model.isSuccessful) {
        return MaybeFailure.success(model.imageUrl);
      }

      return MaybeFailure.failure(
        ApiException(
          message: response.status,
        ),
      );
    } on ApiException catch (e) {
      return MaybeFailure.failure(e);
    }
  }
}
