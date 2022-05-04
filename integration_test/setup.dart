import 'dart:async';

import 'package:charlatan/charlatan.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loono/loono.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';

Future<void> main({
  Dio? dio,
  Map<String, String>? env,
}) async {
  await setup(
    dioOverride: dio,
    envOverride: env,
    flavor: AppFlavors.dev,
  );
  // disable FirebaseAnalytics in testing
  await registry.get<FirebaseAnalytics>().setAnalyticsCollectionEnabled(false);
  runApp(const Loono(defaultLocale: 'cs'));
}

Future<void> runMockApp({
  required Charlatan charlatan,
}) async {
  final env = {
    'API_URL': 'https://test.loono.cz/',
    'ONESIGNAL_APP_ID': '12345678-abcd-abcd-abcd-123456789abcd',
    'GOOGLE_MAPS_API_KEY': '974887462559526415337556673244944256254',
  };

  final fakeDio = Dio()..httpClientAdapter = charlatan.toFakeHttpClientAdapter();
  await main(
    dio: fakeDio,
    env: env,
  );
}
