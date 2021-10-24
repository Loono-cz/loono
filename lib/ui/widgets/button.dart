import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';

enum ButtonStyle { dark, light }

class LoonoButton extends StatelessWidget {
  const LoonoButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.enabled = true,
    this.enabledColor,
    this.disabledColor,
    this.buttonStyle = ButtonStyle.dark,
  }) : super(key: key);

  const LoonoButton.light({
    Key? key,
    required this.text,
    required this.onTap,
    this.enabled = true,
    this.enabledColor,
    this.disabledColor,
  })  : buttonStyle = ButtonStyle.light,
        super(key: key);

  /// Called only if [enabled] is `true`.
  final VoidCallback? onTap;
  final String text;
  final bool enabled;
  final Color? enabledColor;
  final Color? disabledColor;
  final ButtonStyle buttonStyle;

  bool get isLight => buttonStyle == ButtonStyle.light;

  @override
  Widget build(BuildContext context) {
    return ExtendedInkWell(
      onTap: enabled ? onTap : null,
      splashColor: enabled ? null : Colors.transparent,
      materialColor: enabled
          ? (enabledColor ?? (isLight ? LoonoColors.buttonLight : LoonoColors.primaryEnabled))
          : (disabledColor ??
              (isLight ? LoonoColors.buttonLight.withOpacity(0.5) : LoonoColors.primaryDisabled)),
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        height: 65.0,
        child: Align(
          child: Text(
            text,
            style: Theme.of(context).textTheme.button?.copyWith(
                  color: isLight ? Colors.black : Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
