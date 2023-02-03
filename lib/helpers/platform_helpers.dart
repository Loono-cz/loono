import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

/// Gets Android version sdk int. Returns null when platform is not Android.
Future<int?> getAndroidVersion() async {
  if (!Platform.isAndroid) {
    return null;
  }
  final android = await DeviceInfoPlugin().androidInfo;
  return android.version.sdkInt;
}
