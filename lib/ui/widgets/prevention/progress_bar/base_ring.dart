import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class Ring extends CustomPainter {
  Ring({
    required this.progressColor,
    this.upperArcAngle = 0,
    this.lowerArcAngle = 0,
    this.isOverdue = false,
  });

  final Color progressColor;
  final double upperArcAngle;
  final double lowerArcAngle;
  final bool isOverdue;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min((size.width / 2) - 8, (size.height / 2) - 8);
    const angle = 2 * pi * 0.5;

    /// Draw top base ring
    final topBaseArc = Paint()
      ..strokeWidth = 8
      ..color = LoonoColors.beigeLight
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi,
      angle,
      false,
      topBaseArc,
    );

    /// Draw bottom base ring
    final bottomBaseArc = Paint()
      ..strokeWidth = 4
      ..color = LoonoColors.beigeLight
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 2,
      angle,
      false,
      bottomBaseArc,
    );

    /// Draw top progress ring
    final topProgressArc = Paint()
      ..strokeWidth = 8
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final topProgressAngle = 2 * pi * (upperArcAngle / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi,
      topProgressAngle,
      false,
      topProgressArc,
    );

    /// Draw bottom lower progress ring
    final bottomLowerProgressArc = Paint()
      ..strokeWidth = 4
      ..color = LoonoColors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final bottomLowerProgressAngle = 2 * pi * (lowerArcAngle / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 2,
      bottomLowerProgressAngle,
      false,
      bottomLowerProgressArc,
    );

    /// Draw bottom progress ring
    final bottomProgressArc = Paint()
      ..strokeWidth = 4
      ..color = isOverdue ? LoonoColors.red : progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final bottomProgressAngle = 2 * pi * (lowerArcAngle.clamp(0, 0.82) / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 2,
      bottomProgressAngle,
      false,
      bottomProgressArc,
    );
  }

  @override
  bool shouldRepaint(covariant Ring oldDelegate) {
    return true;
  }
}
