import 'package:flutter/material.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/user.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/universal_doctor_screen.dart';
import 'package:loono/utils/registry.dart';

class OnboardingGeneralPracticionerScreen extends StatelessWidget {
  OnboardingGeneralPracticionerScreen({Key? key, required this.sex}) : super(key: key);

  final Sex sex;

  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UniversalDoctorScreen(
          question: sex.getUniversalDoctorLabel(context),
          questionHighlight: context.l10n.practitioner_question_highlight,
          imagePath: 'practicioner',
          numberOfSteps: sex.totalNumOfSteps,
          currentStep: sex.generalPractitionerStep,
          nextButton1Text: context.l10n.practitioner_next_button1,
          nextButton2Text: context.l10n.practitioner_next_button2,
          nextCallback1: () async {
            await _usersDao.updateGeneralPracticionerCcaVisit(CcaDoctorVisit.inLastTwoYears);
          },
          nextCallback2: () async {
            await _usersDao.updateGeneralPracticionerCcaVisit(CcaDoctorVisit.moreThanTwoYearsOrIdk);
          },
        ),
      ),
    );
  }
}
