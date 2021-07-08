import 'package:json_annotation/json_annotation.dart';

part 'random_image.dto.g.dart';

@JsonSerializable()
class RandomImageDto {
  RandomImageDto({
    required this.message,
    required this.status,
  });

  final String message;
  final String status;

  static RandomImageDto fromJson(Map<String, dynamic> json) {
    return _$RandomImageDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RandomImageDtoToJson(this);
  }
}