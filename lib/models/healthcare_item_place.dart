import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono_api/loono_api.dart';

//ignore: prefer_mixin
class HealthcareItemPlace with ClusterItem {
  HealthcareItemPlace(this.healthcareProvider);

  final SimpleHealthcareProvider healthcareProvider;

  @override
  String toString() => 'Place{healthcareProvider: $healthcareProvider}';

  @override
  LatLng get location => LatLng(healthcareProvider.lat, healthcareProvider.lng);
}
