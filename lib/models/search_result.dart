import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/helpers/type_converters.dart';
import 'package:loono_api/loono_api.dart';

part 'search_result.freezed.dart';
part 'search_result.g.dart';

enum SearchType { city, address, specialization }

@freezed
class SearchResult with _$SearchResult {
  factory SearchResult({
    required SearchType searchType,
    String? overriddenText,
    @SimpleHealthcareProviderJsonConverter() required SimpleHealthcareProvider? data,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);
}

extension SearchResultExt on SearchResult {
  String get text {
    if (overriddenText != null) return overriddenText!;
    final provider = data;
    if (provider == null) return '';
    switch (searchType) {
      case SearchType.city:
        return provider.city;
      case SearchType.address:
        final doctor = provider;
        final address = doctor.street == null ? doctor.city : '${doctor.street}, ${doctor.city}';
        return address;
      case SearchType.specialization:
        break;
    }
    return overriddenText ?? '';
  }

  double get zoomLevel {
    switch (searchType) {
      case SearchType.address:
        return MapVariables.STREET_ZOOM;
      case SearchType.specialization:
      case SearchType.city:
        return MapVariables.CITY_ZOOM;
    }
  }
}
