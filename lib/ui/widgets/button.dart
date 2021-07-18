import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class LoonoButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final bool enabled;
  const LoonoButton(this.onPressed, this.text, this.enabled);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: enabled ? LoonoColors.primary : LoonoColors.primaryLight,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(text),
      ),
    );
  }
}
