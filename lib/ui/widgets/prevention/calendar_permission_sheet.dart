import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/registry.dart';
import 'package:permission_handler/permission_handler.dart';

void showCalendarPermissionSheet(BuildContext context) {
  final l10n = context.l10n;

  registry.get<FirebaseAnalytics>().logEvent(name: 'OpenCalendarPermissionModal');
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (context) {
      return Container(
        height: 350,
        decoration: const BoxDecoration(
          color: LoonoColors.bottomSheetPrevention,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, size: 32),
                      onPressed: () => AutoRouter.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(l10n.calendar_permission_sheet_title, style: LoonoFonts.headerFontStyle),
                const SizedBox(height: 20),
                Text(l10n.calendar_permission_sheet_desc, style: LoonoFonts.fontStyle),
                const SizedBox(height: 20),
                LoonoButton(
                  text: l10n.calendar_permission_sheet_button,
                  onTap: openAppSettings,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    },
  ).whenComplete(() {
    registry.get<FirebaseAnalytics>().logEvent(name: 'CloseCalendarPermissionModal');
  });
}
