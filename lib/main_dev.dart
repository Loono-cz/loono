import 'package:flutter/material.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/main_common.dart';

Future<void> main() async {
  final loonoApp = await buildApp(
    config: const DevConfig(),
  );

  runApp(loonoApp);
}
