import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/progress_dots.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/universal_doctor.dart';
import 'package:loono_api/loono_api.dart';

class UniversalDoctorScreen extends StatelessWidget {
  const UniversalDoctorScreen({
    Key? key,
    required this.question,
    required this.questionHighlight,
    required this.assetPath,
    required this.numberOfSteps,
    required this.currentStep,
    required this.nextButton1Text,
    required this.nextButton2Text,
    required this.nextCallback1,
    required this.nextCallback2,
    required this.examinationType,
  }) : super(key: key);

  final String question;
  final String questionHighlight;
  final String assetPath;
  final int numberOfSteps;
  final int currentStep;
  final String nextButton1Text;
  final String nextButton2Text;
  final VoidCallback nextCallback1;
  final VoidCallback nextCallback2;
  final ExaminationTypeEnum examinationType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SkipButton(
                onPressed: () => AutoRouter.of(context).push(const FillOnboardingFormLaterRoute()),
                sibling: numberOfSteps > 2
                    ? LoonoProgressIndicator(numberOfSteps: numberOfSteps, currentStep: currentStep)
                    : Row(
                        children: [
                          Flexible(
                            flex: 5,
                            child: LoonoProgressIndicator(
                              numberOfSteps: numberOfSteps,
                              currentStep: currentStep,
                            ),
                          ),
                          const Flexible(flex: 4, child: SizedBox()),
                        ],
                      ),
              ),
              Expanded(
                child: UniversalDoctor(
                  question: question,
                  questionHeader: questionHighlight,
                  assetPath: assetPath,
                  button1Text: nextButton1Text,
                  button2Text: nextButton2Text,
                  nextCallback1: nextCallback1,
                  nextCallback2: nextCallback2,
                  examinationType: examinationType,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
