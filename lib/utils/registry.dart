import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/routers/app_router.dart';
import 'package:loono/routers/auth_router.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/database_service.dart';
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

  registry.registerLazySingleton<AppConfig>(() => config);

  // services
  registry.registerSingleton<DatabaseService>(DatabaseService());
  // TODO: generate the key and store it into secure storage
  await registry.get<DatabaseService>().init('SUPER SECURE KEY');
  registry.registerSingleton<AuthService>(AuthService());

  // repositories
  registry.registerSingleton<UserRepository>(UserRepository());

  // utils
  registry.registerLazySingleton<ImagePicker>(() => ImagePicker());

  // routers
  registry.registerSingleton<AuthRouter>(AuthRouter());
  registry.registerSingleton<AppRouter>(AppRouter());

  registry.get<AppRouter>().replaceAll([const MainScreenRouter()]);
  registry.get<AuthService>().authStateStream.listen(
        (event) => event.maybeWhen(
          loggedIn: () => registry.get<AuthRouter>().replaceAll([LoggedInRoute()]),
          accountJustCreated: (authUser) =>
              registry.get<AuthRouter>().replaceAll([NicknameRoute(authUser: authUser)]),
          loggedOut: () => registry.get<AuthRouter>().replaceAll([const OnboardingWrapperRoute()]),
          loggedOutManually: () => registry.get<AuthRouter>().replaceAll([const LogoutRoute()]),
          orElse: () {},
        ),
      );
}
