import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';

AppBar settingsAppBar(
  BuildContext context, {
  bool showBackButton = true,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(color: LoonoColors.black),
    leading: showBackButton
        ? IconButton(
            key: const Key('settingsAppBar_backButton'),
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
          key: const Key('settingsAppBar_closeButton'),
          icon: const Icon(Icons.close, size: 37),
          onPressed: () => AutoRouter.of(context).popForced(),
        ),
      ),
    ],
  );
}
