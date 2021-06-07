import 'package:flutter/material.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/core/secrets.dart';
import 'package:loono/main_common.dart';
import 'package:loono/services/sentry_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secrets = await Secrets.create();
  final sentryService = SentryService(dns: secrets.sentryDns);
  final config = DevConfig();

  await sentryService.sentryScope(
    appFlavor: config.flavor,
    appRunner: () async {
      runApp(
        await buildApp(
          config: config,
        ),
      );
    },
  );
}
