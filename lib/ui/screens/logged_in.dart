import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/routers/app_router.dart';
import 'package:loono/utils/registry.dart';

class LoggedInScreen extends StatelessWidget {
  LoggedInScreen({Key? key}) : super(key: key);

  final _appRouter = registry.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    final backButtonDispatcher = Router.of(context).backButtonDispatcher;

    return Router(
      backButtonDispatcher:
          backButtonDispatcher == null ? null : ChildBackButtonDispatcher(backButtonDispatcher)
            ?..takePriority(),
      routerDelegate: AutoRouterDelegate(_appRouter),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
