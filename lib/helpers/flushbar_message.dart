import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';

Flushbar<dynamic> _showFlushBar(BuildContext context, String message, Color bgColor) {
  return Flushbar<dynamic>(
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
    borderRadius: BorderRadius.circular(8),
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(seconds: 4),
    backgroundColor: bgColor,
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  )..show(context);
}

Object showFlushBarSuccess(
  BuildContext context,
  String message, {
  bool sync = true,
}) {
  if (message.isEmpty) return Object;
  if (sync) return _showFlushBar(context, message, LoonoColors.greenSuccess);
  return Future.delayed(
    const Duration(),
    () => _showFlushBar(context, message, LoonoColors.greenSuccess),
  );
}

Object showFlushBarError(
  BuildContext context,
  String message, {
  bool sync = true,
}) {
  if (message.isEmpty) return Object;
  if (sync) {
    return _showFlushBar(
      context,
      message,
      LoonoColors.red,
    );
  }
  return Future.delayed(
    const Duration(),
    () => _showFlushBar(
      context,
      message,
      LoonoColors.red,
    ),
  );
}

String statusCodeToText(BuildContext context, int? statusCode) {
  final l10n = context.l10n;
  var result = l10n.something_went_wrong;
  switch (statusCode) {
    case 422:
      result = l10n.too_early_checkup;
      break;
  }
  return result;
}
