import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';

class LoonoAvatar extends StatelessWidget {
  const LoonoAvatar({Key? key, this.radius = 50.0}) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: LoonoColors.leaderboardPrimary,
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        child: SvgPicture.asset(
          'assets/icons/default_avatar.svg',
          color: LoonoColors.primary,
        ),
      ),
    );
  }
}
