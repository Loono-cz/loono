import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loono/constants.dart';

class SkipButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget? sibling;

  const SkipButton({Key? key, required this.onPressed, this.sibling}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox(child: sibling)),
        if (sibling != null) const SizedBox(width: 32),
        TextButton(
          onPressed: onPressed,
          child: Text(
            AppLocalizations.of(context)!.skip,
            style: const TextStyle(color: LoonoColors.black, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
