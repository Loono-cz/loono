import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loono/loono.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/picture_precaching.dart';
import 'package:loono/utils/registry.dart';

Future<void> main() async {
  await setup(flavor: AppFlavors.dev);
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await precacheImagesFromList(welcomeSplashes);
  runApp(const Loono());
}
