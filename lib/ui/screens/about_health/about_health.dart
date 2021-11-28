import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

class AboutHealthScreen extends StatelessWidget {
  const AboutHealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Screen: O zdraví',
            style: LoonoFonts.headerFontStyle,
          ),
        ),
      ),
    );
  }
}
