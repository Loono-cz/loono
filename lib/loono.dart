import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/utils/registry.dart';

class Loono extends StatelessWidget {
  final _router = registry<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Loono',
      color: Colors.deepOrange,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerDelegate: AutoRouterDelegate(_router),
      routeInformationParser: _router.defaultRouteParser(),
    );
  }
}
