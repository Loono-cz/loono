import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/router/app_router.gr.dart';

AppBar settingsAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(color: LoonoColors.black),
    actions: [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => AutoRouter.of(context).navigate(const MainScreenRouter()),
      ),
    ],
  );
}
