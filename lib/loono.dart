import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class Loono extends StatelessWidget {
  const Loono({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = registry.get<AuthService>();
    final _appRouter = registry.get<AppRouter>();
    final _healthcareProviderRepository = registry.get<HealthcareProviderRepository>();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return StreamBuilder<AuthUser?>(
      stream: _auth.onAuthStateChanged,
      builder: (context, snapshot) {
        final authUser = snapshot.data;
        if (authUser == null &&
            !_appRouter.isPathActive('logout') &&
            !_appRouter.isRouteActive(AfterDeletionRoute(sex: Sex.MALE).routeName)) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            _appRouter.removeWhere((_) => true);
            // ignore: cascade_invocations
            _appRouter.push(const MainScreenRouter());
          });
          _healthcareProviderRepository.checkAndUpdateIfNeeded();
        }

        return ChangeNotifierProvider(
          create: (_) => ExaminationsProvider(),
          child: MaterialApp.router(
            title: 'Loono',
            color: Colors.deepOrange,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerDelegate: AutoRouterDelegate(_appRouter),
            routeInformationParser: _appRouter.defaultRouteParser(),
          ),
        );
      },
    );
  }
}
