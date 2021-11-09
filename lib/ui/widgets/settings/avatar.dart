import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';

class LoonoAvatar extends StatelessWidget {
  const LoonoAvatar({Key? key, this.radius = 50.0, this.imageBytes}) : super(key: key);

  final Uint8List? imageBytes;
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
        foregroundImage: imageBytes == null ? null : MemoryImage(imageBytes!),
        child: SvgPicture.asset(
          'assets/icons/default_avatar.svg',
          color: LoonoColors.primary,
        ),
      ),
    );
  }
}
