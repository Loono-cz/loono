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

  LatLngBounds? visibleRegion;

  List<SearchResult> searchResults = <SearchResult>[];

  bool isInSearchResult = false;

  List<SimpleHealthcareProvider> get allHealthcareProviders => _allHealthcareProviders;

  List<SimpleHealthcareProvider> get currHealthcareProviders => _currHealthcareProviders;

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
    final uniqueCitiesMap = <String, SimpleHealthcareProvider>{};
    final addresses = <SimpleHealthcareProvider>[];
    for (final healthcareProvider in _allHealthcareProviders) {
      final isCityMatching = removeDiacritics(healthcareProvider.city.toLowerCase())
          .contains(removeDiacritics(query).toLowerCase());
      if (isCityMatching) {
        uniqueCitiesMap[healthcareProvider.city] = healthcareProvider;
      }

      final isAddressMatching = healthcareProvider.street == null
          ? false
          : removeDiacritics(healthcareProvider.street!.toLowerCase())
              .contains(removeDiacritics(query).toLowerCase());
      if (isAddressMatching) {
        addresses.add(healthcareProvider);
      }
    }
    final cities =
        uniqueCitiesMap.values.map((e) => SearchResult(data: e, searchType: SearchType.city));
    debugPrint(
      '-------\nSEARCH QUERY: $query\nTITLES: ${addresses.length}\nCITIES: ${cities.length}',
    );

    final results = [
      ...cities,
      ...addresses.map((e) => SearchResult(data: e, searchType: SearchType.address)),
    ];
    searchResults.replaceRange(0, searchResults.length, results);
    notifyListeners();
  }

  void clearSearchResults() => searchResults.clear();

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
}
