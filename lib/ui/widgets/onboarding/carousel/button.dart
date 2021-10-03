import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/button.dart';

class CarouselButton extends StatelessWidget {
  const CarouselButton({Key? key, required this.text, this.onTap}) : super(key: key);

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.14,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: LoonoButton(onTap: onTap, text: text),
      ),
    );
  }
}
