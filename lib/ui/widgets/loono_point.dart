import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';

class LoonoPointIcon extends StatelessWidget {
  const LoonoPointIcon({
    Key? key,
    this.color = LoonoColors.primaryEnabled,
    this.width,
  }) : super(key: key);

  final Color color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/star.svg',
      color: color,
      width: width,
    );
  }
}
