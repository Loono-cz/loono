import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/progress_dots.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/universal_doctor.dart';

class UniversalDoctorScreen extends StatelessWidget {
  final String question;
  final String questionHeader;
  final String imagePath;
  final int numberOfSteps;
  final int currentStep;
  final void Function() nextCallback1;
  final void Function() nextCallback2;
  final String skipScreen;
  const UniversalDoctorScreen({
    this.question = 'Kdy jsi byla naposledy na preventivní prohlídce u',
    required this.questionHeader,
    required this.imagePath,
    required this.numberOfSteps,
    required this.currentStep,
    required this.nextCallback1,
    required this.nextCallback2,
    required this.skipScreen,
  });

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
                onPressed: () => Navigator.pushNamed(context, skipScreen),
                sibling: LoonoProgressIndicator(
                  numberOfSteps: numberOfSteps,
                  currentStep: currentStep,
                ),
              ),
              Expanded(
                child: UniversalDoctor(
                  questionHeader: questionHeader,
                  imagePath: imagePath,
                  nextCallback1: nextCallback1,
                  nextCallback2: nextCallback2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
