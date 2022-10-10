import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class LoonoRadioButton extends StatelessWidget {
  const LoonoRadioButton({super.key, required this.isChecked});

  final bool isChecked;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isChecked ? LoonoColors.primaryEnabled : Colors.black87,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      height: 26,
      width: 26,
      child: Transform.scale(
        scale: 1.4,
        child: isChecked
            ? const Icon(
                Icons.circle,
                color: LoonoColors.primaryEnabled,
                size: 12.0,
              )
            : null,
      ),
    );
  }
}
