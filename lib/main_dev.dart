import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/main_common.dart';
import 'package:loono/services/firebase.service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = DevConfig();

  final _firebase = await FirebaseService.create(config);
  await _firebase.setCrashlyticsCollection(enable: !kDebugMode);

  await runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    final app = await buildApp(config: config);

    runApp(app);
  }, FirebaseCrashlytics.instance.recordError);
}
