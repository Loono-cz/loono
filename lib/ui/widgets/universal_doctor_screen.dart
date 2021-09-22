import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/progress_dots.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/universal_doctor.dart';

class UniversalDoctorScreen extends StatelessWidget {
  final String questionHeader;
  final String imagePath;
  final int numberOfSteps;
  final int currentStep;
  final String nextButton1Text;
  final String nextButton2Text;
  final void Function() nextCallback1;
  final void Function() nextCallback2;

  const UniversalDoctorScreen({
    required this.questionHeader,
    required this.imagePath,
    required this.numberOfSteps,
    required this.currentStep,
    this.nextButton1Text = 'V posledním roce',
    this.nextButton2Text = 'Je to více než rok nebo nevím',
    required this.nextCallback1,
    required this.nextCallback2,
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
                onPressed: () => Navigator.pushNamed(context, '/create-account'),
                sibling: LoonoProgressIndicator(
                  numberOfSteps: numberOfSteps,
                  currentStep: currentStep,
                ),
              ),
              Expanded(
                child: UniversalDoctor(
                  questionHeader: questionHeader,
                  imagePath: imagePath,
                  button1Text: nextButton1Text,
                  button2Text: nextButton2Text,
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
