import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselContentWidget extends StatelessWidget {
  final String text;
  final Widget? button;
  final Widget? image;

  const CarouselContentWidget({required this.text, this.button, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Text(
            'K čemu prevence?',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(26, 25, 25, 1),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24.0,
              color: Color.fromRGBO(26, 25, 25, 1),
            ),
          ),
        ),
        const Spacer(),
        if (image != null) image!,
        if (button != null) button!,
      ],
    );
  }
}
