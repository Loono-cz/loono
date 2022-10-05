import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

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
                Container(
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
