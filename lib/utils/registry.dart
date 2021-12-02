import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/router/guards/check_is_logged_in.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/notification_service.dart';
import 'package:loono/utils/app_config.dart';
import 'package:package_info/package_info.dart';

final registry = GetIt.instance;

Future<void> setup(AppFlavors flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final appInfo = await PackageInfo.fromPlatform();
  await dotenv.load(fileName: 'assets/.env');

  late final String osVersion;
  try {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      await deviceInfo.iosInfo.then((ios) => osVersion = 'iOS ${ios.systemVersion}');
    } else if (Platform.isAndroid) {
      await deviceInfo.androidInfo.then((android) => osVersion = 'Android ${android.version}');
    } else {
      osVersion = 'Unknown OS';
    }
  } catch (e) {
    debugPrint('Failed detect OS version');
    osVersion = 'Unknown OS';
  }

  final config = AppConfig(
    env: dotenv.env,
    packageInfo: appInfo,
    platformVersion: osVersion,
    flavor: flavor,
  );

  registry.registerLazySingleton<GlobalKey<NavigatorState>>(() => GlobalKey());
  registry.registerLazySingleton<AppConfig>(() => config);

  registry.registerSingleton<NotificationService>(NotificationService());
  await registry.get<NotificationService>().init();

  // services
  registry.registerSingleton<AuthService>(AuthService());
  registry.registerSingleton<DatabaseService>(DatabaseService());
  // TODO: generate the key and store it into secure storage
  await registry.get<DatabaseService>().init('SUPER SECURE KEY');

  // repositories
  registry.registerSingleton<UserRepository>(UserRepository());
  registry.registerSingleton<ExaminationRepository>(const ExaminationRepository());

  // router
  registry.registerSingleton<AppRouter>(AppRouter(checkIsLoggedIn: CheckIsLoggedIn()));

  // utils
  registry.registerLazySingleton<ImagePicker>(() => ImagePicker());
}
