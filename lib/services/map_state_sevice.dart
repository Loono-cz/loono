import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/helpers/simple_health_care_provider_helper.dart';
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

  final List<SearchResult> _allSpecs = <SearchResult>[];

  final Set<Marker> _markers = <Marker>{};

  LocationPermission _locationPermission = LocationPermission.unableToDetermine;

  SimpleHealthcareProvider? doctorDetail;

  SearchResult? currSpecialization;

  LatLngBounds? visibleRegion;

  List<SearchResult> searchResults = <SearchResult>[];

  List<SimpleHealthcareProvider> get allHealthcareProviders => _allHealthcareProviders;

  List<SearchResult> get allSpecs => _allSpecs;

  bool onMoveMapFilteringBlocked = false;

  /// Currently selected or visible healthcare providers.
  ///
  /// If [currSpecialization] is not null it displays only providers with the currently selected
  /// specialization.
  List<SimpleHealthcareProvider> get currHealthcareProviders => currSpecialization != null
      ? _currHealthcareProviders.where(_hasSpecialization).toList()
      : _currHealthcareProviders;

  Set<Marker> get markers => _markers;

  LocationPermission get locationPermission => _locationPermission;

  ClusterManager _initClusterManager() => ClusterManager<HealthcareItemPlace>(
        <HealthcareItemPlace>[],
        updateMarkers,
        markerBuilder: (cluster) => markerBuilder(
          cluster,
          setDoctorDetail,
          setActiveDoctors,
          currHealthcareProviders,
          onMoveMapFilteringBlocked,
          applyFilter,
        ),
      );

  void setVisibleRegion(LatLngBounds latLngBounds) {
    if (visibleRegion != latLngBounds) {
      visibleRegion = latLngBounds;
      applyFilter();
      notifyListeners();
    }
  }

  void setLocationPermission(LocationPermission permission) {
    _locationPermission = permission;
    notifyListeners();
  }

  void addAll(Iterable<SimpleHealthcareProvider> healthcareProviders) {
    _allHealthcareProviders.addAll(healthcareProviders);
    clusterManager.setItems(allHealthcareProviders.map((e) => HealthcareItemPlace(e)).toList());
    applyFilter();
    _setSpecializations();
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
    final uniqueCitiesWithSameNameMap = <String, Set<SimpleHealthcareProvider>>{};

    final uniqueAddressesMap = <String, SimpleHealthcareProvider>{};
    final uniqueSpecializationsMap = <String>{};

    final specs = _allSpecs.map((spec) => spec.overriddenText).whereType<String>();
    bool matchesSpecQuery(String specialization) =>
        removeDiacritics(specialization).toLowerCase().contains(normalizedQuery);
    final matchedSpecs = specs.where(matchesSpecQuery);
    final anyHealthcareProvider = _allHealthcareProviders.firstOrNull;
    for (final spec in matchedSpecs) {
      uniqueSpecializationsMap.add(spec);
    }

    for (final healthcareProvider in _allHealthcareProviders) {
      final isCityMatching =
          removeDiacritics(healthcareProvider.city.toLowerCase()).contains(normalizedQuery);
      if (isCityMatching) {
        final city = healthcareProvider.city;
        final sameCityFromMap = uniqueCitiesMap[city];
        final sameCityWithNameAlreadyAdded = uniqueCitiesWithSameNameMap.containsKey(city);
        // Checking for cities which have same name but are in different locations
        // (different postal code).
        if (sameCityFromMap != null || sameCityWithNameAlreadyAdded) {
          final a = healthcareProvider;
          bool hasSamePostalCode(SimpleHealthcareProvider b) =>
              a.postalCode.isNotEmpty && (a.postalCode == b.postalCode);
          final cityAlreadyAdded =
              uniqueCitiesWithSameNameMap[city]?.firstWhereOrNull(hasSamePostalCode) != null;
          if (!cityAlreadyAdded) {
            // Whether the city is also far away from the other. To ignore for example results from
            // Prague 1 where postal codes are (110 00, 118 000, etc.)
            final anyCity = sameCityFromMap ?? uniqueCitiesWithSameNameMap[city]?.firstOrNull;
            if (anyCity != null) {
              bool isFarAway() =>
                  (Geolocator.distanceBetween(
                        healthcareProvider.lat,
                        healthcareProvider.lng,
                        anyCity.lat,
                        anyCity.lng,
                      ) ~/
                      1000) >
                  20;
              if (isFarAway()) {
                uniqueCitiesWithSameNameMap.update(
                  city,
                  (set) => set..add(healthcareProvider),
                  ifAbsent: () => <SimpleHealthcareProvider>{anyCity, healthcareProvider},
                );
                uniqueCitiesMap.remove(city);
              }
            }
          }
        } else {
          // City is not added yet.
          uniqueCitiesMap[city] = healthcareProvider;
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

    final cities = [
      ...uniqueCitiesMap.values.map((e) => SearchResult(data: e, searchType: SearchType.city)),
      for (final healthcareProvidersSameCityName in uniqueCitiesWithSameNameMap.values)
        for (final item in healthcareProvidersSameCityName)
          SearchResult(
            data: item,
            searchType: SearchType.city,
            overriddenText: '${item.city} (${item.getFormattedPostalCode()})',
          ),
    ].sorted((a, b) => compareNatural(a.overriddenText ?? a.text, b.overriddenText ?? b.text));
    final addresses = uniqueAddressesMap.values
        .map((e) => SearchResult(data: e, searchType: SearchType.address))
        .sorted((a, b) => compareNatural(a.text, b.text));
    final specializations = anyHealthcareProvider != null
        ? (uniqueSpecializationsMap
            .map(
              (e) => SearchResult(
                data: anyHealthcareProvider,
                searchType: SearchType.specialization,
                overriddenText: e,
              ),
            )
            .sorted((a, b) => compareNatural(a.text, b.text)))
        : <SearchResult>[];
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

  SearchResult? getSpecSearchResultByName(String specName) {
    final matched = _allSpecs.firstWhereOrNull((spec) => spec.overriddenText == specName);
    if (matched != null) {
      return SearchResult(
        data: matched.data,
        searchType: SearchType.specialization,
        overriddenText: specName,
      );
    }
    return null;
  }

  void _setSpecializations() {
    final uniqueSpecializationsMap = <String, SearchResult>{};
    for (final healthcareProvider in _allHealthcareProviders) {
      final specializations = healthcareProvider.category;
      for (final spec in specializations) {
        uniqueSpecializationsMap[spec] = SearchResult(
          data: healthcareProvider,
          searchType: SearchType.specialization,
          overriddenText: spec,
        );
      }
    }
    _allSpecs.replaceRange(0, _allSpecs.length, uniqueSpecializationsMap.values);
  }

  LatLngBounds get visibleRegionPadded {
    final bottomPadding = (visibleRegion!.northeast.latitude - visibleRegion!.southwest.latitude) *
        MapVariables.MIN_SHEET_SIZE;
    return LatLngBounds(
      southwest: LatLng(
        visibleRegion!.southwest.latitude + bottomPadding,
        visibleRegion!.southwest.longitude,
      ),
      northeast: visibleRegion!.northeast,
    );
  }

  void applyFilter() {
    if (onMoveMapFilteringBlocked) {
      final firstProvider = currHealthcareProviders.firstOrNull;
      if (firstProvider != null && visibleRegion != null) {
        final isProviderInCurrRegion =
            visibleRegionPadded.contains(LatLng(firstProvider.lat, firstProvider.lng));
        if (isProviderInCurrRegion) {
          // filtering on map move is blocked - clicked on a cluster
          return;
        }
      }
    }
    onMoveMapFilteringBlocked = false;
    _currHealthcareProviders.replaceRange(
      0,
      _currHealthcareProviders.length,
      _allHealthcareProviders.where(
        (healthcareProvider) {
          if (visibleRegion == null) return true;
          final lat = healthcareProvider.lat;
          final lng = healthcareProvider.lng;
          return visibleRegionPadded.contains(LatLng(lat, lng));
        },
      ),
    );
  }

  void setDoctorDetail(SimpleHealthcareProvider? detail, {bool unblockOnMoveMapFiltering = true}) {
    if (unblockOnMoveMapFiltering) {
      onMoveMapFilteringBlocked = false;
    }
    doctorDetail = detail;
    notifyListeners();
  }

  void setActiveDoctors(Iterable<SimpleHealthcareProvider> newProviders) {
    onMoveMapFilteringBlocked = true;
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
