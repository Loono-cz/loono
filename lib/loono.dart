import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/utils/registry.dart';

class Loono extends StatelessWidget {
  final _auth = registry.get<AuthService>();
  final _appRouter = registry.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthUser?>(
      stream: _auth.onAuthStateChanged,
      builder: (context, snapshot) {
        final authUser = snapshot.data;
        if (authUser == null && !_appRouter.isPathActive('logout')) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            _appRouter.removeWhere((_) => true);
            _appRouter.push(const MainScreenRouter());
          });
        }

        return MaterialApp.router(
          title: 'Loono',
          color: Colors.deepOrange,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerDelegate: AutoRouterDelegate(_appRouter),
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
