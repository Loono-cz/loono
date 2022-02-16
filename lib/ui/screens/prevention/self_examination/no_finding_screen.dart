import 'package:flutter/material.dart';
import 'package:loono/helpers/ui_helpers.dart';

// TODO:
class NoFindingScreen extends StatelessWidget {
  const NoFindingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Jak dopadlo samovyšetření'),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
