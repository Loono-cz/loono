import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

class Loono extends StatelessWidget {
  const Loono({Key? key, this.defaultLocale}) : super(key: key);

  final String? defaultLocale;

  @override
  Widget build(BuildContext context) {
    final _auth = registry.get<AuthService>();
    final _appRouter = registry.get<AppRouter>();
    final _healthcareProviderRepository = registry.get<HealthcareProviderRepository>();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    if (useHybridComposition()) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }

    return StreamBuilder<AuthUser?>(
      stream: _auth.onAuthStateChanged,
      builder: (context, snapshot) {
        final authUser = snapshot.data;
        if (authUser == null &&
            !_appRouter.isRouteActive(LogoutRoute.name) &&
            !_appRouter.isRouteActive(AfterDeletionRoute.name)) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            _appRouter.removeWhere((_) => true);
            // ignore: cascade_invocations
            _appRouter.push(const MainScreenRouter());
          });
          _healthcareProviderRepository.checkAndUpdateIfNeeded();
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider<ExaminationsProvider>(create: (_) => ExaminationsProvider()),
            ChangeNotifierProvider<MapStateService>(create: (_) => MapStateService()),
          ],
          child: MaterialApp.router(
            title: 'Loono',
            color: Colors.deepOrange,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: defaultLocale != null ? Locale(defaultLocale!) : null,
            routerDelegate: AutoRouterDelegate(
              _appRouter,
              navigatorObservers: () =>
                  [FirebaseAnalyticsObserver(analytics: registry.get<FirebaseAnalytics>())],
            ),
            routeInformationParser: _appRouter.defaultRouteParser(),
          ),
        );
      },
    );
  }
}
