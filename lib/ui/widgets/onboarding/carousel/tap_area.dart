import 'package:flutter/material.dart';

class TapArea extends StatelessWidget {
  const TapArea._({
    Key? key,
    required this.alignment,
    this.width,
    this.height,
    this.onTap,
    this.onPanEnd,
    this.onPanDown,
  }) : super(key: key);

  const TapArea.leftSide({
    Key? key,
    this.onTap,
    this.onPanDown,
    this.onPanEnd,
  })  : alignment = Alignment.centerLeft,
        width = null,
        height = double.infinity,
        super(key: key);

  const TapArea.rightSide({
    Key? key,
    this.onTap,
    this.onPanDown,
    this.onPanEnd,
  })  : alignment = Alignment.centerRight,
        width = null,
        height = double.infinity,
        super(key: key);

  const TapArea.max({
    Key? key,
    this.onTap,
    this.onPanDown,
    this.onPanEnd,
  })  : alignment = Alignment.center,
        width = double.infinity,
        height = double.infinity,
        super(key: key);

  final Alignment alignment;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final GestureDragDownCallback? onPanDown;
  final GestureDragEndCallback? onPanEnd;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        onPanDown: onPanDown,
        onPanEnd: onPanEnd,
        child: SizedBox(
          width: width ?? MediaQuery.of(context).size.width / 2,
          height: height ?? double.infinity,
        ),
      ),
    );
  }
}
