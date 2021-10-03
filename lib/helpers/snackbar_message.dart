import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String message}) {
  if (message.isEmpty) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
