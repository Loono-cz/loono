// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_image.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RandomImageDto _$RandomImageDtoFromJson(Map<String, dynamic> json) {
  return RandomImageDto(
    message: json['message'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$RandomImageDtoToJson(RandomImageDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
