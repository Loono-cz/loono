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
import 'package:loono/utils/my_logger.dart';
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
        MyLogger().writeToFile('Loono.dart: build');
        final authUser = snapshot.data;
        MyLogger().writeToFile('Loono.dart: AuthUser = ${authUser.toString()}');
        MyLogger().writeToFile('Loono.dart: check appRouter.Routes...');
        MyLogger().writeToFile('Loono.dart: ${EmailRoute.name} isActive ${appRouter.isRouteActive(EmailRoute.name)}');
        MyLogger().writeToFile('Loono.dart: ${OnboardingFormDoneRoute.name} isActive ${appRouter.isRouteActive(OnboardingFormDoneRoute.name)}');
        MyLogger().writeToFile('Loono.dart: ${LoginRoute.name} isActive ${appRouter.isRouteActive(LoginRoute.name)}');
        MyLogger().writeToFile('Loono.dart: ${LogoutRoute.name} isActive ${appRouter.isRouteActive(LogoutRoute.name)}');
        MyLogger().writeToFile('Loono.dart: ${AfterDeletionRoute.name} isActive ${appRouter.isRouteActive(AfterDeletionRoute.name)}');
        if (authUser == null &&
            !appRouter.isRouteActive(EmailRoute.name) &&
            !appRouter.isRouteActive(OnboardingFormDoneRoute.name) &&
            !appRouter.isRouteActive(LoginRoute.name) &&
            !appRouter.isRouteActive(LogoutRoute.name) &&
            !appRouter.isRouteActive(AfterDeletionRoute.name)) {
          MyLogger().writeToFile('Loono.dart: AuthUser is null, appRouter.Routes are INactive'); 
          if (showSplashScreen) {
            MyLogger().writeToFile('Loono.dart: showSplash()');
            showSplashScreen = false;
            _showSplashscreen(appRouter);
          } else {
            MyLogger().writeToFile('Loono.dart: showMainScreen()');
            _showMainScreen(appRouter);
          }
          healthcareProviderRepository.checkAndUpdateIfNeeded();
        } else{
          MyLogger().writeToFile('Loono.dart: User is not null || There is an active route!');
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
    await MyLogger().writeToFile('Loono.dart -> _showSplashScreen()...');
    if (Platform.isAndroid && ((await getAndroidVersion()) ?? 0) >= 31) {
      await appRouter.push(const Splashscreen());
      _showMainScreen(appRouter, delay: const Duration(seconds: 5));
    } else {
      _showMainScreen(appRouter);
    }
  }

  void _showMainScreen(AppRouter appRouter, {Duration delay = Duration.zero}) {
    MyLogger().writeToFile('Loono.dart -> _showMainScreen()...');
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(delay, () {
        appRouter
          ..removeWhere((_) => true)
          ..push(const MainScreenRouter());
      });
    });
  }
}
