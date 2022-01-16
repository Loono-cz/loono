import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/button.dart';

class CarouselButton extends StatelessWidget {
   CarouselButton({Key? key, required this.heightMultiplier, required this.text, this.onTap}) : super(key: key);

  double heightMultiplier ;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * heightMultiplier,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: LoonoButton(onTap: onTap, text: text),
      ),
    );
  }
}
