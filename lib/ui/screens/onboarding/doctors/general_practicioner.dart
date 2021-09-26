import 'package:flutter/material.dart';
import 'package:loono/helpers/sex_extensions.dart';
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
          questionHighlight: "Praktického lékaře",
          imagePath: "practicioner",
          numberOfSteps: sex.totalNumOfSteps,
          currentStep: sex.generalPractitionerStep,
          nextButton1Text: 'V posledních 2 letech',
          nextButton2Text: 'Jsou to více než 2 roky nebo nevím',
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
