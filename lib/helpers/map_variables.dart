// ignore_for_file: constant_identifier_names
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';

class MapVariables {
  /// Prague, main train station
  static const LatLng INITIAL_COORDS = LatLng(50.08308000648528, 14.435443582943789);

  static const double DEFAULT_ZOOM = 13.0;

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
