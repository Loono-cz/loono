import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class SelfExaminationRing extends CustomPainter {
  SelfExaminationRing({
    required this.backgroundColor,
    this.progress = 0,
  });

  final Color backgroundColor;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min((size.width / 2) - 8, (size.height / 2) - 8);
    const angle = 2 * pi;

    /// Draw top base ring
    final topBaseArc = Paint()
      ..strokeWidth = 8
      ..color = progress > .9 ? LoonoColors.redButton : backgroundColor
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi,
      angle,
      false,
      topBaseArc,
    );

    /// Draw top progress ring
    final topProgressArc = Paint()
      ..strokeWidth = 8
      ..color = LoonoColors.greenSuccess
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final topProgressAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi,
      topProgressAngle,
      false,
      topProgressArc,
    );
  }

  @override
  bool shouldRepaint(covariant SelfExaminationRing oldDelegate) {
    return true;
  }
}
