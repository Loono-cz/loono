import 'package:flutter/material.dart';
import 'package:loono/loono.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/my_logger.dart';
import 'package:loono/utils/registry.dart';

Future<void> main() async {
  await setup(flavor: AppFlavors.dev);

  /// Logs
  await MyLogger().initFile();
  await MyLogger().writeToFile('main.dart: Logs initialized');
  ///

  runApp(const Loono());
}
