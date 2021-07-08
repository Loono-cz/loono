import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loono/api/breed.api.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/core/http/logger_interceptor.dart';
import 'package:loono/loono.dart';
import 'package:loono/screens/screen_navigator.dart';
import 'package:loono/services/breed.service.dart';
import 'package:loono/services/firebase.service.dart';
import 'package:provider/provider.dart';

Future<Widget> buildApp({required AppConfig config}) async {
  await FirebaseService.create(config);

  final _dio = Dio(config.dioBaseOptions);
  _dio.interceptors.add(LoggerInterceptor());

  final _breedApi = BreedApi(_dio, config.apiConfig);

  final screenNavigatorKey = GlobalKey<ScreenNavigatorState>();

  return MultiProvider(
    providers: [
      Provider<AppConfig>.value(value: config),
      Provider<BreedService>(
        create: (_) => BreedService(_breedApi),
      )
    ],
    child: Loono(
      config: config,
      screenNavigatorKey: screenNavigatorKey,
    ),
  );
}
