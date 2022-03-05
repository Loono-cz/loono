import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class AvatarBubbleArrow extends StatelessWidget {
  const AvatarBubbleArrow({Key? key, required this.extent}) : super(key: key);

  final double extent;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        80;
    final width = MediaQuery.of(context).size.width;
    final topOffset = height - (height * extent);
    final leftOffset = (width - 180) * 0.22; // 180 is avatar width
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

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(leftOffset + 70, 300)
      ..lineTo(leftOffset, topOffset)
      ..lineTo(leftOffset + 35, topOffset)
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
