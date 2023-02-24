import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/helpers/platform_helpers.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/services/webview_service.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

class Loono extends StatelessWidget {
  const Loono({Key? key, this.defaultLocale}) : super(key: key);

  final String? defaultLocale;

  static var showSplashScreen = true;

  @override
  Widget build(BuildContext context) {
    final auth = registry.get<AuthService>();
    final appRouter = registry.get<AppRouter>();
    final healthcareProviderRepository = registry.get<HealthcareProviderRepository>();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
    );

    if (useHybridComposition()) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }

    return StreamBuilder<AuthUser?>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        final authUser = snapshot.data;
        if (authUser == null &&
            !appRouter.isRouteActive(EmailRoute.name) &&
            !appRouter.isRouteActive(OnboardingFormDoneRoute.name) &&
            !appRouter.isRouteActive(LoginRoute.name) &&
            !appRouter.isRouteActive(LogoutRoute.name) &&
            !appRouter.isRouteActive(AfterDeletionRoute.name)) {
          if (showSplashScreen) {
            showSplashScreen = false;
            _showSplashscreen(appRouter);
          } else {
            _showMainScreen(appRouter);
          }
          healthcareProviderRepository.checkAndUpdateIfNeeded();
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider<ExaminationsProvider>(create: (_) => ExaminationsProvider()),
            ChangeNotifierProvider<MapStateService>(create: (_) => MapStateService()),
            ChangeNotifierProvider<WebViewProvider>(create: (_) => WebViewProvider()),
          ],
          child: MaterialApp.router(
            title: 'Preventivka',
            color: Colors.deepOrange,
            theme: ThemeData.light().copyWith(
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: defaultLocale != null ? Locale(defaultLocale!) : null,
            routerDelegate: AutoRouterDelegate(
              appRouter,
              navigatorObservers: () =>
                  [FirebaseAnalyticsObserver(analytics: registry.get<FirebaseAnalytics>())],
            ),
            routeInformationParser: appRouter.defaultRouteParser(),
          ),
        );
      },
    );
  }
  Future<void> _showSplashscreen(AppRouter appRouter) async {
    if (Platform.isAndroid && ((await getAndroidVersion()) ?? 0) >= 31) {
      await appRouter.push(const Splashscreen());
      _showMainScreen(appRouter, delay: const Duration(seconds: 5));
    } else {
      _showMainScreen(appRouter);
    }
  }

  void _showMainScreen(AppRouter appRouter, {Duration delay = Duration.zero}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(delay, () {
        appRouter
          ..removeWhere((_) => true)
          ..push(const MainScreenRouter());
      });
    });
  }
}
