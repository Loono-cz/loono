import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';

Flushbar noConnectionFlushbar() {
  return Flushbar<dynamic>(
    forwardAnimationCurve: Curves.decelerate,
    reverseAnimationCurve: Curves.easeOut,
    isDismissible: false,
    icon: const Icon(
      Icons.signal_cellular_off,
      color: Colors.white,
    ),
    // hardcoded strings here don't need context
    title: 'Žádné připojení',
    message: 'Prosím zkontroluj své připojení k síti',
    backgroundColor: LoonoColors.red,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.BOTTOM,
    borderRadius: BorderRadius.circular(12),
    margin: const EdgeInsets.fromLTRB(8, 8, 8, BOTTOM_NAV_BAR_HEIGHT + 10),
  );
}
