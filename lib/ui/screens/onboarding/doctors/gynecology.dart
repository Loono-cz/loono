import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/progress_dots.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/universal_doctor.dart';

class OnboardingGynecologyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SkipButton(
                onPressed: () => Navigator.pushNamed(context, '/achievement'),
                sibling: const LoonoProgressIndicator(
                  numberOfSteps: 3,
                  currentStep: 2,
                ),
              ),
              Expanded(
                child: UniversalDoctor(
                  questionHeader: 'Gynekologii?',
                  imagePath: 'gynecology',
                  nextCallback: () {
                    Navigator.pushNamed(context, '/achievement');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
