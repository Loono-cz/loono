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

  final List<SimpleHealthcareProvider> _currHealthcareProviders = <SimpleHealthcareProvider>[];

  final Set<Marker> _markers = <Marker>{};

  SimpleHealthcareProvider? doctorDetail;

  SearchResult? currSpecialization;

  LatLngBounds? visibleRegion;

  List<SearchResult> searchResults = <SearchResult>[];

  List<SimpleHealthcareProvider> get allHealthcareProviders => _allHealthcareProviders;

  bool onMoveAppFilteringBlocked = false;

  /// Currently selected or visible healthcare providers.
  ///
  /// If [currSpecialization] is not null it displays only providers with the currently selected
  /// specialization.
  List<SimpleHealthcareProvider> get currHealthcareProviders => currSpecialization != null
      ? _currHealthcareProviders.where(_hasSpecialization).toList()
      : _currHealthcareProviders;

  Set<Marker> get markers => _markers;

  ClusterManager _initClusterManager() => ClusterManager<HealthcareItemPlace>(
        <HealthcareItemPlace>[],
        updateMarkers,
        markerBuilder: (cluster) => markerBuilder(cluster, setDoctorDetail, setActiveDoctors),
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

      bool matchesQuery(String specialization) =>
          removeDiacritics(specialization).toLowerCase().contains(normalizedQuery);
      final specializations = healthcareProvider.category;
      final hasSpecializationMatch =
          specializations.isNotEmpty ? specializations.any(matchesQuery) : false;
      if (hasSpecializationMatch) {
        final matchedSpecs = specializations.where(matchesQuery);
        for (final spec in matchedSpecs) {
          uniqueSpecializationsMap[spec] = healthcareProvider;
        }
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
      ...specializations,
      ...cities,
      ...addresses,
    ];
    searchResults.replaceRange(0, searchResults.length, results);
    notifyListeners();
  }

  void clearSearchResults() {
    searchResults.clear();
    notifyListeners();
  }

  void _applyFilter() {
    if (onMoveAppFilteringBlocked) {
      final firstProvider = currHealthcareProviders.firstOrNull;
      if (firstProvider != null && visibleRegion != null) {
        final isProviderInCurrRegion =
            visibleRegion!.contains(LatLng(firstProvider.lat, firstProvider.lng));
        if (isProviderInCurrRegion) {
          // filtering on map move is blocked - clicked on a cluster
          return;
        }
      }
    }
    onMoveAppFilteringBlocked = false;
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

  void setActiveDoctors(Iterable<SimpleHealthcareProvider> newProviders) {
    onMoveAppFilteringBlocked = true;
    doctorDetail = null;
    _currHealthcareProviders.replaceRange(0, _currHealthcareProviders.length, newProviders);
    notifyListeners();
  }

  void setSpecialization(SearchResult? searchResult) {
    currSpecialization = searchResult;
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
    if (currSpecialization == null) return false;
    if (provider.category.isEmpty) return false;
    return provider.category.any((e) => e.contains(currSpecialization!.text));
  }
}
