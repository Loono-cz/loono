import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/radio_button.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    required this.text,
    this.isChecked = false,
    required this.whatIsChecked,
  }) : super(key: key);

  final String text;
  final bool isChecked;
  final ValueChanged<bool> whatIsChecked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: GestureDetector(
            onTap: () => whatIsChecked(isChecked),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                LoonoRadioButton(isChecked: isChecked),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
