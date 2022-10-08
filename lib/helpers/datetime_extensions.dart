import 'package:flutter/material.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';

extension PreventDate on DateTime {
  bool datePickerIsPast(BuildContext context) {
    if (isAfter(DateTime.now())) {
      showFlushBarError(
        context,
        context.l10n.datepicker_error_is_future,
      );
      return false;
    }
    return true;
  }

  bool datePickerIsInFuture(BuildContext context) {
    if (isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) ||
        isAtSameMomentAs(DateTime.now())) {
      showFlushBarError(
        context,
        context.l10n.error_must_be_in_future,
      );
      return false;
    }
    return true;
  }

  bool timePickerIsInFuture(BuildContext context) {
    if (isBefore(DateTime(DateTime.now().year, DateTime.now().hour, DateTime.now().month)) ||
        isAtSameMomentAs(DateTime.now())) {
      showFlushBarError(
        context,
        context.l10n.error_must_be_in_future,
      );
      return false;
    }
    return true;
  }
}
