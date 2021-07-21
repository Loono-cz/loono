import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/dtos/breed_api/random_image.dto.dart';

part 'random_image.model.freezed.dart';

@freezed
class RandomImageModel with _$RandomImageModel {
  @JsonSerializable()
  factory RandomImageModel({
    required String imageUrl,
    required bool isSuccessful,
  }) = _RandomImageModel;

  static RandomImageModel fromDto(RandomImageDto dto) {
    return RandomImageModel(
      imageUrl: dto.message,
      isSuccessful: dto.status == 'success',
    );
  }
}