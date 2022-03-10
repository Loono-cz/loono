import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';

class ContactButton extends StatelessWidget {
  const ContactButton({Key? key, required this.text, required this.iconPath, required this.action})
      : super(key: key);

  final String text;
  final String iconPath;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return ExtendedInkWell(
      onTap: action,
      splashColor: null,
      materialColor: LoonoColors.buttonLight,
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        height: 65.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SvgPicture.asset(
                iconPath,
                width: 26,
                color: LoonoColors.primaryEnabled,
              ),
            ),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.button?.copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
