import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/helpers/map_variables.dart';
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

  final double _topPctPadding = getTopMapPadding();

  MarkerId selectedMarkerId = const MarkerId('-1');

  bool isAnyMarkerSelected = false;

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
        markerBuilder: (cluster) => markerBuilder(cluster, this),
        levels: const [1, 4.25, 6, 8.25, 11.5, 14.5, 15.75, 16, 16.5, 20],
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
    clusterManager.setItems(allHealthcareProviders.map(HealthcareItemPlace.new).toList());
    applyFilter();
    _setSpecializations();
    notifyListeners();
  }

  void clusterSelect(MarkerId markerId) {
    selectedMarkerId = markerId;
    isAnyMarkerSelected = true;
  }

  void clusterUnselect() {
    isAnyMarkerSelected = false;
  }

  void updateMarkers(Set<Marker> markers) {
    _markers.clear();
    if (isAnyMarkerSelected) {
      for (final marker in markers) {
        if (marker.markerId == selectedMarkerId) {
          _markers.add(marker);
        }
      }
    } else {
      _markers.addAll(markers);
    }
    notifyListeners();
  }

  Future<void> search(String query) async {
    final normalizedQuery = removeDiacritics(query).toLowerCase();

    final cities = _searchCities(normalizedQuery);
    final addresses = _searchAddresses(normalizedQuery);
    final specializations = _searchSpecializations(normalizedQuery);

    searchResults.replaceRange(
      0,
      searchResults.length,
      [...await specializations, ...await cities, ...await addresses],
    );
    notifyListeners();
  }

  Future<List<SearchResult>> _searchCities(final String query) async {
    final cities = <SearchResult>{};
    final citiesNames = <String>{};
    for (final provider in _allHealthcareProviders) {
      final city = provider.city;
      final cityName = '$city (${provider.postalCode})';

      if (citiesNames.contains(cityName)) continue;
      citiesNames.add(cityName);

      final comparableCity = removeDiacritics(city.toLowerCase());
      if (comparableCity.contains(query) || query.contains(comparableCity)) {
        cities.add(
          SearchResult(
            data: provider,
            searchType: SearchType.city,
            overriddenText: cityName,
          ),
        );
      }
    }
    return cities.toList().sorted(
          (a, b) => compareNatural(
            a.overriddenText ?? a.text,
            b.overriddenText ?? b.text,
          ),
        );
  }

  Future<List<SearchResult>> _searchAddresses(final String query) async {
    final addresses = <SearchResult>{};
    final addressesNames = <String>{};

    for (final provider in _allHealthcareProviders) {
      final street = provider.street ?? '';
      final houseNumber = provider.houseNumber;

      var address = '${provider.city} $street';
      final comparableAddress = removeDiacritics(provider.street?.toLowerCase() ?? '');

      if (addressesNames.contains(address) ||
          addressesNames.contains('$address $houseNumber') ||
          comparableAddress == '') continue;

      if (comparableAddress.contains(query) || query.contains(comparableAddress)) {
        try {
          final q = query.split('$comparableAddress ')[1].trim();
          if (q.contains(houseNumber) || houseNumber.contains(q)) {
            address += ' $houseNumber';
          }
        } catch (e) {
          debugPrint('_searchAddresses LOG: ${e.toString()}');
        }

        addressesNames.add(address);
        addresses.add(
          SearchResult(
            data: provider,
            searchType: SearchType.address,
            overriddenText: address,
          ),
        );
      }
    }

    return addresses.toList().sorted((a, b) {
      final hasAHouseNumber = a.text.contains(a.data?.houseNumber ?? '');
      final hasBHouseNumber = b.text.contains(b.data?.houseNumber ?? '');

      final houseNumberResult = hasAHouseNumber == hasBHouseNumber
          ? 0
          : hasAHouseNumber
              ? -1
              : 1;
      return houseNumberResult == 0
          ? compareNatural(a.overriddenText ?? a.text, b.overriddenText ?? b.text)
          : houseNumberResult;
    });
  }

  Future<List<SearchResult>> _searchSpecializations(final String query) async {
    final specializations = <SearchResult>{};
    final specializationsNames = <String>{};

    final specs = _allSpecs.map((spec) => spec.overriddenText).whereType<String>();
    bool matchesSpecQuery(String specialization) =>
        removeDiacritics(specialization).toLowerCase().contains(query);
    final matchedSpecs = specs.where(matchesSpecQuery);
    final anyHealthcareProvider = _allHealthcareProviders.firstOrNull;
    for (final spec in matchedSpecs) {
      if (specializationsNames.contains(spec)) continue;
      specializationsNames.add(spec);

      specializations.add(
        SearchResult(
          data: anyHealthcareProvider,
          searchType: SearchType.specialization,
          overriddenText: spec,
        ),
      );
    }
    return specializations.toList();
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
    final topPadding =
        (visibleRegion!.northeast.latitude - visibleRegion!.southwest.latitude) * _topPctPadding;

    return LatLngBounds(
      southwest: LatLng(
        visibleRegion!.southwest.latitude + bottomPadding,
        visibleRegion!.southwest.longitude,
      ),
      northeast: LatLng(
        visibleRegion!.northeast.latitude - topPadding,
        visibleRegion!.northeast.longitude,
      ),
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
      clusterManager.setItems(allHealthcareProviders.map(HealthcareItemPlace.new).toList());
    } else {
      clusterManager.setItems(
        allHealthcareProviders.where(_hasSpecialization).map(HealthcareItemPlace.new).toList(),
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
