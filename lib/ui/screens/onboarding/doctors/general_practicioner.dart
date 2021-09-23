import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/models/user.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/universal_doctor_screen.dart';
import 'package:loono/utils/registry.dart';

class OnboardingGeneralPracticionerScreen extends StatelessWidget {
  final _usersDao = registry.get<DatabaseService>().users;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UniversalDoctorScreen(
          questionHeader: "Praktického lékaře?",
          imagePath: "practicioner",
          numberOfSteps: 3,
          currentStep: 1,
          nextCallback1: () async {
            await _usersDao.updateGeneralPracticionerCcaVisit(CcaDoctorVisit.inLastTwoYears);
            AutoRouter.of(context).pushNamed('general-practicioner-achievement');
          },
          nextCallback2: () async {
            await _usersDao.updateGeneralPracticionerCcaVisit(CcaDoctorVisit.moreThanTwoYearsOrIdk);
            AutoRouter.of(context).pushNamed('onboarding/doctor/general-practitioner-date');
          },
          skipScreen: "onboarding/doctor/gynecology",
        ),
      ),
    );
  }
}
