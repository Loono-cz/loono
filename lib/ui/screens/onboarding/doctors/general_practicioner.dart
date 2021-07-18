import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/universal_doctor.dart';
import 'package:loono/ui/widgets/progress_dots.dart';

class OnboardingGeneralPracticionerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: LoonoProgressIndicator(
                      numberOfSteps: 3,
                      currentStep: 1,
                    ),
                  ),
                  const SizedBox(width: 32),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/onboarding/doctor/gynecology');
                    },
                    child: const Text('přeskočit'),
                  )
                ],
              ),
              Expanded(
                child: UniversalDoctor(
                  questionHeader: 'Praktického lékaře?',
                  imagePath: 'practicioner',
                  nextCallback: () {
                    Navigator.pushNamed(context, '/onboarding/doctor/gynecology');
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
