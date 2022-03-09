import 'dart:async';

import 'package:charlatan/charlatan.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loono/loono.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';

Future<void> main({
  Dio? dio,
  FirebaseAuth? firebaseAuth,
  GoogleSignIn? googleSignIn,
  Map<String, String>? env,
}) async {
  assert(dio != null && env != null);
  await registry.reset();
  await setup(
    dioOverride: dio,
    googleSignIn: googleSignIn,
    firebaseAuth: firebaseAuth,
    envOverride: env,
    flavor: AppFlavors.dev,
  );
  runApp(const Loono(defaultLocale: 'cs'));
}

// TODO: pass googleSignIn
Future<void> runMockApp({
  FirebaseAuth? firebaseAuthOverride,
  GoogleSignIn? googleSignIn,
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
    firebaseAuth: firebaseAuthOverride,
    env: env,
  );
}
