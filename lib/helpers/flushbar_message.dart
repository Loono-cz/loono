import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

Flushbar<dynamic> _showFlushBar(BuildContext context, String message, Color bgColor) {
  return Flushbar(
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(seconds: 4),
    backgroundColor: bgColor,
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
  )..show(context);
}

Object showFlushBarSuccess(
  BuildContext context,
  String message, {
  bool sync = true,
}) {
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
  if (sync) return _showFlushBar(context, message, LoonoColors.red);
  return Future.delayed(
    const Duration(),
    () => _showFlushBar(context, message, LoonoColors.red),
  );
}
