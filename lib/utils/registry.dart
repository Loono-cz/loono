import 'dart:io';

import 'package:device_calendar/device_calendar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/router/guards/check_is_logged_in.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/calendar_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/firebase_storage_service.dart';
import 'package:loono/services/notification_service.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono_api/loono_api.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
      await deviceInfo.androidInfo
          .then((android) => osVersion = 'Android ${android.version.sdkInt}');
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
  registry.registerSingleton<FirebaseStorageService>(FirebaseStorageService(
    authService: registry.get<AuthService>(),
  ));
  registry.registerSingleton<ApiService>(ApiService(LoonoApi(
    dio: Dio(
      BaseOptions(
        baseUrl: LoonoApi.basePath,
        connectTimeout: 5000,
        receiveTimeout: 8000,
      ),
    ),
  )));
  registry.registerSingleton<CalendarService>(CalendarService(
    deviceCalendarPlugin: DeviceCalendarPlugin(),
  ));
  // TODO: generate the key and store it into secure storage
  await registry.get<DatabaseService>().init('SUPER SECURE KEY');

  // repositories
  registry.registerSingleton<UserRepository>(UserRepository(
    databaseService: registry.get<DatabaseService>(),
    firebaseStorageService: registry.get<FirebaseStorageService>(),
  ));
  registry.registerSingleton<ExaminationRepository>(const ExaminationRepository());
  registry.registerSingleton<HealthcareProviderRepository>(HealthcareProviderRepository(
    apiService: registry.get<ApiService>(),
    databaseService: registry.get<DatabaseService>(),
  ));
  registry.registerSingleton<CalendarRepository>(CalendarRepository(
    databaseService: registry.get<DatabaseService>(),
    calendarService: registry.get<CalendarService>(),
  ));

  // router
  registry.registerSingleton<AppRouter>(AppRouter(checkIsLoggedIn: CheckIsLoggedIn()));

  // utils
  registry.registerLazySingleton<ImagePicker>(() => ImagePicker());
  registry.registerLazySingleton<DefaultCacheManager>(() => DefaultCacheManager());
}
