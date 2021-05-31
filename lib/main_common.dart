import 'package:flutter/material.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/loono.dart';
import 'package:loono/services/firebase_service.dart';
import 'package:provider/provider.dart';

Future<Widget> buildApp({required AppConfig config}) async {
  await FirebaseService.create(config);

  return MultiProvider(
    providers: [
      Provider<AppConfig>.value(value: config),
    ],
    child: Loono(config: config),
  );
}
