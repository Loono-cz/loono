import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/models/healthcare_item_place.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/map_utils.dart';

class MapStateService with ChangeNotifier {
  MapStateService() {
    clusterManager = _initClusterManager();
  }

  late final ClusterManager clusterManager;

  final List<HealthcareProvider> _allHealthcareProviders = <HealthcareProvider>[];

  /// Currently selected or visible healthcare providers.
  final List<HealthcareProvider> _currHealthcareProviders = <HealthcareProvider>[];

  final Set<Marker> _markers = <Marker>{};

  LatLngBounds? visibleRegion;

  List<HealthcareProvider> get allHealthcareProviders => _allHealthcareProviders;

  List<HealthcareProvider> get currHealthcareProviders => _currHealthcareProviders;

  Set<Marker> get markers => _markers;

  ClusterManager _initClusterManager() => ClusterManager<HealthcareItemPlace>(
        <HealthcareItemPlace>[],
        updateMarkers,
        markerBuilder: markerBuilder,
      );

  void setVisibleRegion(LatLngBounds latLngBounds) {
    if (visibleRegion != latLngBounds) {
      visibleRegion = latLngBounds;
      _applyFilter();
      notifyListeners();
    }
  }

  void addAll(List<HealthcareProvider> healthcareProviders) {
    _allHealthcareProviders.addAll(healthcareProviders);
    notifyListeners();
  }

  void updateMarkers(Set<Marker> markers) {
    _markers
      ..clear()
      ..addAll(markers);
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
}
