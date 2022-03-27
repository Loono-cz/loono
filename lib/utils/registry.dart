// ignore_for_file: cascade_invocations

import 'dart:async';
import 'dart:io';

import 'package:device_calendar/device_calendar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
import 'package:loono/services/save_directories.dart';
import 'package:loono/utils/app_clear.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/picture_precaching.dart';
import 'package:loono_api/loono_api.dart';
import 'package:package_info_plus/package_info_plus.dart';

final registry = GetIt.instance;

final defaultDioOptions = BaseOptions(
  baseUrl: LoonoApi.basePath,
  connectTimeout: 5000,
  receiveTimeout: 8000,
);

const retryBlacklist = ['/account/onboard', '/leaderboard'];

Future<void> setup({
  Dio? dioOverride,
  GoogleSignIn? googleSignIn,
  FirebaseAuth? firebaseAuth,
  Map<String, String>? envOverride,
  required AppFlavors flavor,
}) async {
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
    env: envOverride ?? dotenv.env,
    packageInfo: appInfo,
    platformVersion: osVersion,
    flavor: flavor,
  );

  final dio = dioOverride ?? Dio(defaultDioOptions);

  /// Ignore api certificate - remove this asap when server has set
  if (dioOverride == null) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
  // remove end

  if (dioOverride == null) {
    dio.options.headers['app-version'] = appInfo.version;
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print,
        retries: 3,
        retryDelays: const [
          // set delays between retries
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
      ),
    );
  }

  dio.interceptors.addAll(
    [
      QueuedInterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final requestOptions = error.response!.requestOptions;
            final token = await registry.get<AuthService>().refreshUserToken();
            if (token == null) {
              await appClear();
              return handler.reject(error);
            }
            final response = await dio.request<Object?>(
              requestOptions.path,
              options: Options(method: requestOptions.method),
              cancelToken: requestOptions.cancelToken,
              onReceiveProgress: requestOptions.onReceiveProgress,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
            );
            if (response.data != null) {
              return handler.resolve(response);
            } else {
              await appClear();
              return handler.reject(error);
            }
          }
          return handler.next(error);
        },
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final isDisableRetryUrl = retryBlacklist.contains(options.path);
          handler.next(options..disableRetry = isDisableRetryUrl);
        },
        onError: (e, handler) async {
          /// TODO: select correct status code for force update with BE
          if (e.response?.statusCode == 410) {
            final router = registry<AppRouter>();
            const forceUpdateRoute = ForceUpdateRoute();
            // prevents pushing multiple force update routes
            if (router.current.route.name != forceUpdateRoute.routeName) {
              await router.push(forceUpdateRoute);
            }
          }
          handler.next(e);
        },
      ),
    ],
  );

  registry.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics.instance);

  registry.registerSingleton<LoonoApi>(LoonoApi(dio: dio));

  registry.registerLazySingleton<GlobalKey<NavigatorState>>(() => GlobalKey());
  registry.registerLazySingleton<AppConfig>(() => config);

  registry.registerSingleton<NotificationService>(NotificationService());
  await registry.get<NotificationService>().init();

  // services
  registry.registerSingleton<SaveDirectories>(SaveDirectories());
  await registry.get<SaveDirectories>().init();
  registry.registerSingleton<AuthService>(
    AuthService(
      api: registry.get<LoonoApi>(),
      firebaseAuth: firebaseAuth ?? FirebaseAuth.instance,
      googleSignIn: googleSignIn ?? GoogleSignIn(),
    ),
  );
  registry.registerSingleton<DatabaseService>(DatabaseService());
  registry.registerSingleton<FirebaseStorageService>(
    FirebaseStorageService(
      authService: registry.get<AuthService>(),
    ),
  );
  registry.registerSingleton<ApiService>(ApiService(api: registry.get<LoonoApi>()));
  registry.registerSingleton<CalendarService>(
    CalendarService(
      deviceCalendarPlugin: DeviceCalendarPlugin(),
    ),
  );
  // TODO: generate the key and store it into secure storage
  await registry.get<DatabaseService>().init('SUPER SECURE KEY');

  // repositories
  registry.registerSingleton<UserRepository>(
    UserRepository(
      apiService: registry.get<ApiService>(),
      databaseService: registry.get<DatabaseService>(),
      firebaseStorageService: registry.get<FirebaseStorageService>(),
      authService: registry.get<AuthService>(),
      notificationService: registry.get<NotificationService>(),
    ),
  );
  registry.registerSingleton<ExaminationRepository>(
    ExaminationRepository(
      apiService: registry.get<ApiService>(),
    ),
  );
  registry.registerSingleton<HealthcareProviderRepository>(
    HealthcareProviderRepository(
      apiService: registry.get<ApiService>(),
      databaseService: registry.get<DatabaseService>(),
    ),
  );
  registry.registerSingleton<CalendarRepository>(
    CalendarRepository(
      databaseService: registry.get<DatabaseService>(),
      calendarService: registry.get<CalendarService>(),
    ),
  );

  // router
  registry.registerSingleton<AppRouter>(AppRouter(checkIsLoggedIn: CheckIsLoggedIn()));

  // utils
  registry.registerLazySingleton<ImagePicker>(() => ImagePicker());
  registry.registerLazySingleton<DefaultCacheManager>(() => DefaultCacheManager());

  // picture caching
  await precacheImagesFromList(welcomeSplashes);

  // splash screen
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}
