import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class LoonoButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final bool enabled;
  const LoonoButton(this.onPressed, this.text, {required this.enabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            primary: enabled ? LoonoColors.primary : LoonoColors.primaryLight,
            padding: const EdgeInsets.symmetric(vertical: 24),
            elevation: 0),
        child: Text(
          text,
          style: LoonoFonts.fontStyleWhite,
        ),
      ),
    );
  }
}
