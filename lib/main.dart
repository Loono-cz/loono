import 'package:flutter/material.dart';
import 'package:loono/loono.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';

Future<void> main() async {
  await setup(flavor: AppFlavors.dev);
  runApp(const Loono());
}
