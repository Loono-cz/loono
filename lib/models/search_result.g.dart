// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchResult _$$_SearchResultFromJson(Map<String, dynamic> json) =>
    _$_SearchResult(
      searchType: $enumDecode(_$SearchTypeEnumMap, json['searchType']),
      overriddenText: json['overriddenText'] as String?,
      data: _$JsonConverterFromJson<String, SimpleHealthcareProvider?>(
          json['data'], const SimpleHealthcareProviderJsonConverter().fromJson),
    );

Map<String, dynamic> _$$_SearchResultToJson(_$_SearchResult instance) =>
    <String, dynamic>{
      'searchType': _$SearchTypeEnumMap[instance.searchType]!,
      'overriddenText': instance.overriddenText,
      'data':
          const SimpleHealthcareProviderJsonConverter().toJson(instance.data),
    };

const _$SearchTypeEnumMap = {
  SearchType.city: 'city',
  SearchType.address: 'address',
  SearchType.specialization: 'specialization',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
