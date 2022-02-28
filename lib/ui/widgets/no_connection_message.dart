import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

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
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(12),
    margin: const EdgeInsets.all(8.0),
  );
}
