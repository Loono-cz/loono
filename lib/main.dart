import 'package:flutter/material.dart';
import 'package:loono/loono.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/my_logger.dart';
import 'package:loono/utils/registry.dart';

// final log = Logger('ExampleLogger');

Future<void> main() async {
  await setup(flavor: AppFlavors.dev);

  await MyLogger.initFile();
  await MyLogger.writeToFile('Logs initialized');
  await MyLogger.writeToFile('Logs hehe');
  await MyLogger.writeToFile('Logs hehe1');
  await MyLogger.writeToFile('Logs hehe2');
  await MyLogger.writeToFile('Logs hehe3');

  runApp(const Loono());
}
