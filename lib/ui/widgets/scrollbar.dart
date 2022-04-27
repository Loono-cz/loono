import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class LoonoScrollbar extends StatelessWidget {
  const LoonoScrollbar({
    Key? key,
    required this.child,
    this.thumbColor,
    this.trackColor,
  }) : super(key: key);

  final Widget child;
  final Color? thumbColor;
  final Color? trackColor;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        scrollbarTheme: Theme.of(context).scrollbarTheme.copyWith(
              thumbColor: MaterialStateProperty.all(thumbColor ?? LoonoColors.primaryWashed),
              trackColor: MaterialStateProperty.all(trackColor ?? LoonoColors.beigeLighter),
              trackBorderColor: MaterialStateProperty.all(Colors.transparent),
              trackVisibility: MaterialStateProperty.all(true),
            ),
      ),
      child: Scrollbar(
        isAlwaysShown: true,
        child: child,
      ),
    );
  }
}
