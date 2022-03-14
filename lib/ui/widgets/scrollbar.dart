import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class LoonoScrollbar extends StatelessWidget {
  const LoonoScrollbar({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        scrollbarTheme: Theme.of(context).scrollbarTheme.copyWith(
              thumbColor: MaterialStateProperty.all(LoonoColors.primaryWashed),
              trackColor: MaterialStateProperty.all(LoonoColors.beigeLighter),
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
