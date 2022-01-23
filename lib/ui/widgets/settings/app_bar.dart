import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/router/app_router.gr.dart';

AppBar settingsAppBar(
  BuildContext context, {
  bool showBackButton = true,
  PageRouteInfo<dynamic> closeRoute = const MainScreenRouter(),
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(color: LoonoColors.black),
    leading: showBackButton
        ? IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 32,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        : const SizedBox.shrink(),
    actions: [
      IconButton(
        icon: const Icon(Icons.close, size: 37),
        onPressed: () => AutoRouter.of(context).navigate(closeRoute),
      ),
    ],
  );
}
