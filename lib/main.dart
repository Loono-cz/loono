import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loono/loono.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> main() async {
  const imgRoutes = ['assets/icons/carousel_doctors.svg'];
  await setup(flavor: AppFlavors.dev);
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.forEach<String>(
      imgRoutes,
      (imgRoute) => precachePicture(
            ExactAssetPicture(
              SvgPicture.svgStringDecoderBuilder,
              imgRoute,
            ),
            null,
            onError: (e, st) => print(e),
          ));
  runApp(const Loono());
}
