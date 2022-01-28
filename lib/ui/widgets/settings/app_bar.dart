import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            icon: SizedBox(
              height: 25,
              width: 25,
              child: SvgPicture.asset('assets/icons/arrow_back.svg'),
            ),
            onPressed: () => AutoRouter.of(context).pop(),
          )
        : const SizedBox.shrink(),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: IconButton(
          icon: const Icon(Icons.close, size: 37),
          onPressed: () => AutoRouter.of(context).navigate(closeRoute),
        ),
      ),
    ],
  );
}
