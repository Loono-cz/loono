import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';

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
        child: ExtendedInkWell(
          onTap: onTap,
          materialColor: LoonoColors.primaryEnabled,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: SizedBox(
            height: 65.0,
            child: Align(
              child: Text(
                text,
                style: Theme.of(context).textTheme.button?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
