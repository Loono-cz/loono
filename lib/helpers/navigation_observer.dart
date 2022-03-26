import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loono/utils/registry.dart';

class LoonoNavigationObserver extends AutoRouterObserver {
  @override
  Future<void> didPush(Route route, Route? previousRoute) async {
    await registry.get<FirebaseAnalytics>().setCurrentScreen(screenName: route.settings.name);
  }

  @override
  Future<void> didPop(Route route, Route? previousRoute) async {
    await registry
        .get<FirebaseAnalytics>()
        .setCurrentScreen(screenName: previousRoute?.settings.name);
  }
}
