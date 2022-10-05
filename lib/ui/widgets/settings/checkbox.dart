import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class CheckboxCustom extends StatelessWidget {
  const CheckboxCustom({
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
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: LoonoColors.grey,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                height: 30,
                width: 30,
                child: Transform.scale(
                  scale: 1.4,
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(width: 2, color: LoonoColors.grey),
                    ),
                    fillColor: MaterialStateProperty.all<Color>(Colors.white),
                    checkColor: LoonoColors.checkBoxMark,
                    value: isChecked,
                    onChanged: (bool? value) {
                      whatIsChecked(value!);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
