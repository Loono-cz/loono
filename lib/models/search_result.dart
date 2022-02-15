import 'package:flutter/material.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono_api/loono_api.dart';

enum SearchType { title, city }

class SearchResult {
  const SearchResult({
    required this.searchType,
    required this.data,
  });

  final SearchType searchType;
  final SimpleHealthcareProvider data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchResult &&
          runtimeType == other.runtimeType &&
          searchType == other.searchType &&
          data == other.data;

  @override
  int get hashCode => searchType.hashCode ^ data.hashCode;

  @override
  String toString() => 'SearchResult{searchType: $searchType, data: $data}';
}

extension SearchResultExt on SearchResult {
  String get text {
    switch (searchType) {
      case SearchType.title:
        return data.title;
      case SearchType.city:
        return data.city;
    }
  }

  IconData get icon {
    switch (searchType) {
      case SearchType.title:
        return Icons.person;
      case SearchType.city:
        return Icons.add_location;
    }
  }

  double get zoomLevel {
    switch (searchType) {
      case SearchType.title:
        return MapVariables.DOCTOR_DETAIL_ZOOM;
      case SearchType.city:
        return MapVariables.DEFAULT_ZOOM;
    }
  }
}
