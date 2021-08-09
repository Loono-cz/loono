import 'package:flutter/material.dart';

class TapArea extends StatelessWidget {
  const TapArea._({Key? key, required this.alignment, this.onTap}) : super(key: key);

  const TapArea.leftSide({Key? key, this.onTap})
      : alignment = Alignment.centerLeft,
        super(key: key);

  const TapArea.rightSide({Key? key, this.onTap})
      : alignment = Alignment.centerRight,
        super(key: key);

  final Alignment alignment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: double.infinity,
        ),
      ),
    );
  }
}
