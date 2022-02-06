import 'package:flutter/material.dart';

import '../../../constants.dart';

class Checkbox_custom extends StatefulWidget {
  ValueChanged<bool> whatIsChecked;

  Checkbox_custom(
      {Key? key, required this.text, this.isChecked = false, required this.whatIsChecked})
      : super(key: key);

  final String text;
  bool isChecked;

  @override
  _Checkbox_customState createState() => _Checkbox_customState();
}

class _Checkbox_customState extends State<Checkbox_custom> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 17.0),
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
                    value: widget.isChecked,
                    onChanged: (bool? value) {
                      widget.whatIsChecked(value!);
                      setState(
                        () {
                          widget.isChecked = value;
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 17),
                child: Text(
                  widget.text,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
