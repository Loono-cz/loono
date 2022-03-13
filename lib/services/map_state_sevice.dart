import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/models/healthcare_item_place.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/utils/map_utils.dart';
import 'package:loono_api/loono_api.dart';

//ignore: prefer_mixin
class MapStateService with ChangeNotifier {
  MapStateService() {
    clusterManager = _initClusterManager();
  }

  late final ClusterManager clusterManager;

  final List<SimpleHealthcareProvider> _allHealthcareProviders = <SimpleHealthcareProvider>[];

  /// Currently selected or visible healthcare providers.
  final List<SimpleHealthcareProvider> _currHealthcareProviders = <SimpleHealthcareProvider>[];

  final Set<Marker> _markers = <Marker>{};

  SimpleHealthcareProvider? doctorDetail;

  SearchResult? currentSpecialization;

  LatLngBounds? visibleRegion;

  List<SearchResult> searchResults = <SearchResult>[];

  Iterable<SearchResult> get specializationSearchResults =>
      List.of(searchResults.where((e) => e.searchType == SearchType.specialization));

  List<SimpleHealthcareProvider> get allHealthcareProviders => _allHealthcareProviders;

  List<SimpleHealthcareProvider> get currHealthcareProviders => currentSpecialization != null
      ? _currHealthcareProviders.where(_hasSpecialization).toList()
      : _currHealthcareProviders;

  Set<Marker> get markers => _markers;

  ClusterManager _initClusterManager() => ClusterManager<HealthcareItemPlace>(
        <HealthcareItemPlace>[],
        updateMarkers,
        markerBuilder: (cluster) => markerBuilder(cluster, setDoctorDetail),
      );

  void setVisibleRegion(LatLngBounds latLngBounds) {
    if (visibleRegion != latLngBounds) {
      visibleRegion = latLngBounds;
      _applyFilter();
      notifyListeners();
    }
  }

  void addAll(Iterable<SimpleHealthcareProvider> healthcareProviders) {
    _allHealthcareProviders.addAll(healthcareProviders);
    clusterManager.setItems(allHealthcareProviders.map((e) => HealthcareItemPlace(e)).toList());
    _applyFilter();
    notifyListeners();
  }

  void updateMarkers(Set<Marker> markers) {
    _markers
      ..clear()
      ..addAll(markers);
    notifyListeners();
  }

  void search(String query) {
    final normalizedQuery = removeDiacritics(query).toLowerCase();

    final uniqueCitiesMap = <String, SimpleHealthcareProvider>{};
    final uniqueAddressesMap = <String, SimpleHealthcareProvider>{};
    final uniqueSpecializationsMap = <String, SimpleHealthcareProvider>{};

    for (final healthcareProvider in _allHealthcareProviders) {
      final isCityMatching =
          removeDiacritics(healthcareProvider.city.toLowerCase()).contains(normalizedQuery);
      if (isCityMatching) {
        uniqueCitiesMap[healthcareProvider.city] = healthcareProvider;
      }

      final specialization = healthcareProvider.specialization;
      final isSpecializationMatching = query.length < 3 || specialization == null
          ? false
          : removeDiacritics(specialization.toLowerCase()).contains(normalizedQuery);
      if (isSpecializationMatching) {
        final spec = specialization!
            .substring(removeDiacritics(specialization.toLowerCase()).indexOf(normalizedQuery));
        final hasMultipleSpecializations = spec.contains(',');
        final singleSpec = hasMultipleSpecializations ? spec.substring(0, spec.indexOf(',')) : spec;
        uniqueSpecializationsMap[singleSpec] = healthcareProvider;
      }

      final isAddressMatching = healthcareProvider.street == null
          ? false
          : removeDiacritics(healthcareProvider.street!.toLowerCase()).contains(normalizedQuery);
      if (isAddressMatching) {
        uniqueAddressesMap['${healthcareProvider.city}-${healthcareProvider.street}'] =
            healthcareProvider;
      }
    }

    final cities = uniqueCitiesMap.values
        .map((e) => SearchResult(data: e, searchType: SearchType.city))
        .sorted((a, b) => compareNatural(a.text, b.text));
    final addresses = uniqueAddressesMap.values
        .map((e) => SearchResult(data: e, searchType: SearchType.address))
        .sorted((a, b) => compareNatural(a.text, b.text));
    final specializations = uniqueSpecializationsMap.entries
        .map(
          (entry) => SearchResult(
            data: entry.value,
            searchType: SearchType.specialization,
            overriddenText: entry.key,
          ),
        )
        .sorted((a, b) => compareNatural(a.text, b.text));
    debugPrint(
      '-------\nSEARCH QUERY: $query\nADDRESSES: ${uniqueAddressesMap.length}\nCITIES: ${cities.length}\nSPECS: ${specializations.length}',
    );

    final results = [
      ...cities,
      ...addresses,
      ...specializations,
    ];
    searchResults.replaceRange(0, searchResults.length, results);
    notifyListeners();
  }

  void clearSearchResults() {
    searchResults.clear();
    notifyListeners();
  }

  void _applyFilter() {
    _currHealthcareProviders.replaceRange(
      0,
      _currHealthcareProviders.length,
      _allHealthcareProviders.where(
        (healthcareProvider) {
          if (visibleRegion == null) return true;
          final lat = healthcareProvider.lat;
          final lng = healthcareProvider.lng;
          return visibleRegion!.contains(LatLng(lat, lng));
        },
      ),
    );
  }

  void setDoctorDetail(SimpleHealthcareProvider? detail) {
    doctorDetail = detail;
    notifyListeners();
  }

  void setSpecialization(SearchResult? searchResult) {
    currentSpecialization = searchResult;
    if (searchResult == null) {
      clusterManager.setItems(allHealthcareProviders.map((e) => HealthcareItemPlace(e)).toList());
    } else {
      clusterManager.setItems(
        allHealthcareProviders
            .where(_hasSpecialization)
            .map((e) => HealthcareItemPlace(e))
            .toList(),
      );
    }
    notifyListeners();
  }

  bool _hasSpecialization(SimpleHealthcareProvider provider) {
    if (currentSpecialization == null) return false;
    if (currentSpecialization!.overriddenText == null) return false;
    return provider.specialization != null &&
        provider.specialization!.contains(currentSpecialization!.overriddenText!);
  }
}
