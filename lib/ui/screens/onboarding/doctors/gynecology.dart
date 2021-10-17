import 'package:flutter/material.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/user.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/ui/widgets/universal_doctor_screen.dart';
import 'package:loono/utils/registry.dart';

class OnboardingGynecologyScreen extends StatelessWidget {
  OnboardingGynecologyScreen({Key? key, required this.sex}) : super(key: key);

  final Sex sex;

  final _userRepository = registry.get<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UniversalDoctorScreen(
          question: sex.getUniversalDoctorLabel(context),
          questionHighlight: context.l10n.gynecology_question_highlight,
          imagePath: 'gynecology',
          numberOfSteps: sex.totalNumOfSteps,
          currentStep: sex.gynecologyStep,
          nextButton1Text: context.l10n.gynecology_next_button1,
          nextButton2Text: context.l10n.gynecology_next_button2,
          nextCallback1: () async =>
              _userRepository.updateGynecologyCcaVisit(CcaDoctorVisit.inLastTwoYears),
          nextCallback2: () async =>
              _userRepository.updateGynecologyCcaVisit(CcaDoctorVisit.moreThanTwoYearsOrIdk),
        ),
      ),
    );
  }
}
