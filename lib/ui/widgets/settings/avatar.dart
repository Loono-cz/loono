import 'package:flutter/material.dart';

class LoonoAvatar extends StatelessWidget {
  const LoonoAvatar({Key? key, this.radius = 50.0}) : super(key: key);

  final double? radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: const Text('AVATAR'),
    );
  }
}
