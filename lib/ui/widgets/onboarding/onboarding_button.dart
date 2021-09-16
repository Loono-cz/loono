import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class OnboardingButton extends StatelessWidget {
  final bool active;
  final String label;
  final void Function() onClick;
  const OnboardingButton({Key? key, required this.label, required this.onClick, this.active = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 65,
      child: TextButton(
        onPressed: onClick,
        style: TextButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: LoonoColors.primaryEnabled,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(label),
      ),
    );
  }
}
