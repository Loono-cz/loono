import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';

class Loono extends StatelessWidget {
  final _router = registry<AppRouter>();
  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: _usersDao.watchUser(),
        builder: (context, snapshot) {
          return MaterialApp.router(
            title: 'Loono',
            color: Colors.deepOrange,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerDelegate: AutoRouterDelegate(_router),
            routeInformationParser: _router.defaultRouteParser(),
          );
        });
  }
}
