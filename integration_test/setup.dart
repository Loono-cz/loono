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
}) async {
  await setup(
    dioOverride: dio,
    flavor: AppFlavors.dev,
  );
  // disables FirebaseAnalytics in testing
  await registry.get<FirebaseAnalytics>().setAnalyticsCollectionEnabled(false);
  runApp(Loono(defaultLocale: 'cs'));
}

Future<void> runMockApp({
  required Charlatan charlatan,
}) async {
  final fakeDio = Dio()..httpClientAdapter = charlatan.toFakeHttpClientAdapter();
  await main(dio: fakeDio);
}
