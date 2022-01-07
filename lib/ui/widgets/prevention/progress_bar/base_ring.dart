import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class Ring extends CustomPainter {
  const Ring({required this.progressColor});

  final Color progressColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double radius = min((size.width / 2) - 8, (size.height / 2) - 8);
    final double angle = 2 * pi * 0.5;

    /// Draw top base ring
    final Paint topBaseArc = Paint()
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
    final Paint bottomBaseArc = Paint()
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
    final Paint topProgressArc = Paint()
      ..strokeWidth = 8
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final double topProgressAngle = 2 * pi * (0.8 / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi,
      topProgressAngle,
      false,
      topProgressArc,
    );

    /// Draw bottom progress ring
    final Paint bottomLowerProgressArc = Paint()
      ..strokeWidth = 4
      ..color = LoonoColors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final double bottomLowerProgressAngle = 2 * pi * (0.9 / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 2,
      bottomLowerProgressAngle,
      false,
      bottomLowerProgressArc,
    );

    /// Draw bottom progress ring
    final Paint bottomProgressArc = Paint()
      ..strokeWidth = 4
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final double bottomProgressAngle = 2 * pi * (0.8 / 2);
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
