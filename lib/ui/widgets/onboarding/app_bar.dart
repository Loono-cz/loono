import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';

AppBar createAccountAppBar(
  BuildContext context, {
  required int step,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      '${context.l10n.new_account} ($step/2)',
      style: LoonoFonts.headerFontStyle,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
    iconTheme: const IconThemeData(color: LoonoColors.black),
    leading: IconButton(
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset('assets/icons/arrow_back.svg'),
      ),
      onPressed: () => AutoRouter.of(context).pop(),
    ),
  );
}
