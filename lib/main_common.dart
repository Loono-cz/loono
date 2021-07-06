import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loono/api/example.api.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/core/http/logger_interceptor.dart';
import 'package:loono/loono.dart';
import 'package:loono/screens/screen_navigator.dart';
import 'package:loono/services/example.service.dart';
import 'package:loono/services/firebase_service.dart';
import 'package:provider/provider.dart';

Future<Widget> buildApp({required AppConfig config}) async {
  await FirebaseService.create(config);

  final _dio = Dio(config.dioBaseOptions);
  _dio.interceptors.add(LoggerInterceptor());

  final _exampleApi = ExampleApi(_dio, config.apiConfig);

  final screenNavigatorKey = GlobalKey<ScreenNavigatorState>();

  return MultiProvider(
    providers: [
      Provider<AppConfig>.value(value: config),
      Provider<ExampleService>(
        create: (_) => ExampleService(_exampleApi),
      )
    ],
    child: Loono(
      config: config,
      screenNavigatorKey: screenNavigatorKey,
    ),
  );
}
