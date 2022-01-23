import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.sibling,
  }) : super(key: key);

  final String? text;
  final VoidCallback onPressed;
  final Widget? sibling;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox(child: sibling)),
        if (sibling != null) const SizedBox(width: 32),
        TextButton(
          onPressed: onPressed,
          child: Text(
            text ?? context.l10n.skip_questionnaire,
            style: const TextStyle(color: LoonoColors.black, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
