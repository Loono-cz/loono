import 'package:flutter/material.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';

extension PreventDate on DateTime {
  bool isPast(BuildContext context) {
    if (isAfter(DateTime.now())) {
      showFlushBarError(
        context,
        context.l10n.datepicker_error_is_future,
      );
      return false;
    }
    return true;
  }
}
