import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';

// Flushbar noConnectionFlushbar({bool isPreAuth = false, required BuildContext context}) {
//   return Flushbar<dynamic>(
//     forwardAnimationCurve: Curves.decelerate,
//     reverseAnimationCurve: Curves.easeOut,
//     isDismissible: false,
//     shouldIconPulse: !kDebugMode,
//     icon: const Icon(
//       Icons.signal_cellular_off,
//       color: Colors.white,
//     ),
//     // hardcoded strings here don't need context
//     title: context.l10n.no_connection_message,
//     message: context.l10n.no_connection_message_check_connection,
//     backgroundColor: LoonoColors.red,
//     flushbarStyle: FlushbarStyle.FLOATING,
//     flushbarPosition: isPreAuth ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
//     borderRadius: BorderRadius.circular(12),
//     margin: isPreAuth
//         ? const EdgeInsets.fromLTRB(8, 60, 8, 8) // Margin top to not overlap "Už mám účet" top bar
//         : const EdgeInsets.fromLTRB(8, 8, 8, BOTTOM_NAV_BAR_HEIGHT + 10),
//   );
// }

SnackBar noConnectionFlushbar({bool isPreAuth = false, required BuildContext context}) {
  return SnackBar(
    content: Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 15),
          child: Icon(
            Icons.signal_cellular_off,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.no_connection_message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                context.l10n.no_connection_message_check_connection,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    duration: const Duration(days: 1),
    backgroundColor: LoonoColors.red,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    margin: isPreAuth
        ? EdgeInsets.fromLTRB(
            8,
            60,
            8,
            MediaQuery.of(context).size.height -
                200) // Margin top to not overlap "Už mám účet" top bar
        : const EdgeInsets.fromLTRB(8, 8, 8, BOTTOM_NAV_BAR_HEIGHT + 10),
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.none,
  );
}
