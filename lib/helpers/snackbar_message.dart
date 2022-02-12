import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

const _defaultVisibilityDuration = Duration(seconds: 10);

void _showSnackBar(
  BuildContext context, {
  required String message,
  required Color backgroundColor,
  required Duration duration,
}) {
  if (message.isEmpty) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.vertical,
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      width: MediaQuery.of(context).size.width * 0.95,
      content: SizedBox(
        height: 50.0,
        child: Center(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    ),
  );
}

void showSnackBarSuccess(
  BuildContext context, {
  required String message,
  Duration duration = _defaultVisibilityDuration,
}) =>
    _showSnackBar(
      context,
      message: message,
      backgroundColor: LoonoColors.greenSuccess,
      duration: duration,
    );

void showSnackBarError(
  BuildContext context, {
  required String message,
  Duration duration = _defaultVisibilityDuration,
}) =>
    _showSnackBar(
      context,
      message: message,
      backgroundColor: LoonoColors.red,
      duration: duration,
    );
