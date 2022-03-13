import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class AvatarBubbleArrow extends StatelessWidget {
  const AvatarBubbleArrow({Key? key, required this.extent, required this.height}) : super(key: key);

  final double extent;
  final double height;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final topOffset = height - (height * extent);
    final leftOffset = (width - 180) * 0.15; // 180 is avatar width
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: DrawTriangle(topOffset: topOffset, leftOffset: leftOffset),
      ),
    );
  }
}

class DrawTriangle extends CustomPainter {
  DrawTriangle({required this.topOffset, required this.leftOffset});

  double topOffset;
  double leftOffset;
  final double maxOffset = 2000;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(leftOffset + 80, (topOffset - 85).clamp(150, maxOffset))
      ..lineTo(leftOffset, (topOffset + 50).clamp(250, maxOffset))
      ..lineTo(leftOffset + 42, (topOffset + 50).clamp(250, maxOffset))
      ..close();
    canvas.drawPath(
      path,
      Paint()..color = LoonoColors.bottomSheetPrevention,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
