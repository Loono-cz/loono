// ignore_for_file: constant_identifier_names
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';

class MapVariables {
  static const DOCTOR_DETAIL_SHEET_SIZE = 0.4;

  static const MIN_SHEET_SIZE = 0.15;

  static const MAX_SHEET_SIZE = 0.72;

  /// Geografický střed České republiky (Číhošť)
  static const LatLng INITIAL_COORDS = LatLng(49.74387384109868, 15.33894514109844);

  static const double INITIAL_ZOOM = 6.5;

  static const double CITY_ZOOM = 13.0;

  static const double STREET_ZOOM = 16.5;

  static const double DOCTOR_DETAIL_ZOOM = 17.0;
}

bool useHybridComposition() {
  final platform = registry.get<AppConfig>().platformVersion;
  if (Platform.isAndroid && platform.contains('Android ')) {
    final version = int.parse(platform.replaceAll('Android ', ''));

    /// use hybrid composition for android api level >= 29 (android 10 +)
    return version >= 29;
  }
  return false;
}
