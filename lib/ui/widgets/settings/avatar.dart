import 'package:flutter/material.dart';

class LoonoAvatar extends StatelessWidget {
  const LoonoAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50.0,
      child: Text('AVATAR'),
    );
  }
}
