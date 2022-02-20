import 'package:flutter/material.dart';
import 'package:loono/helpers/ui_helpers.dart';

// TODO:
class ProgressRewardScreen extends StatelessWidget {
  const ProgressRewardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Pokračuj dál v samovyšetřování a získáš další odměny.'),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
