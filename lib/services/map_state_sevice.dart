import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/services/db/database.dart';

class MapStateService with ChangeNotifier {
  final List<HealthcareProvider> _allHealthcareProviders = <HealthcareProvider>[];

  final List<HealthcareProvider> _visibleHealthcareProviders = <HealthcareProvider>[];

  LatLngBounds? visibleRegion;

  List<HealthcareProvider> get allHealthcareProviders => _allHealthcareProviders;

  List<HealthcareProvider> get healthcareProviders => _visibleHealthcareProviders;

  void _applyFilter() {
    _visibleHealthcareProviders
      ..clear()
      ..addAll(
        _allHealthcareProviders.where(
          (healthcareProvider) {
            final lat = healthcareProvider.lat;
            final lng = healthcareProvider.lng;
            if (visibleRegion == null) return true;
            return visibleRegion!.contains(LatLng(lat, lng));
          },
        ).toList(),
      );
  }

  void setVisibleRegion(LatLngBounds latLngBounds) {
    if (visibleRegion != latLngBounds) {
      visibleRegion = latLngBounds;
      _applyFilter();
      notifyListeners();
    }
  }

  void add(HealthcareProvider healthcareProvider) {
    _allHealthcareProviders.add(healthcareProvider);
    notifyListeners();
  }

  void addAll(List<HealthcareProvider> healthcareProviders) {
    _allHealthcareProviders.addAll(healthcareProviders);
    notifyListeners();
  }

  void remove(HealthcareProvider healthcareProvider) {
    _allHealthcareProviders.remove(healthcareProvider);
    notifyListeners();
  }

  void removeAll() {
    _allHealthcareProviders.clear();
    notifyListeners();
  }
}
