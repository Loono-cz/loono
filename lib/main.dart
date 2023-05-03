// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:loono/loono.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';
// import 'package:path_provider/path_provider.dart';

final log = Logger('ExampleLogger');

Future<void> main() async {
  await setup(flavor: AppFlavors.dev);

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  log.info('hehe');

  runApp(const Loono());
}

// void _write(String text) async {
//   final directory = await getApplicationDocumentsDirectory();
//   final file = File('${directory.parent.parent.parent.parent.parent.path}/Downloads/my_file.txt');
//   await file.writeAsString(text);
// }
