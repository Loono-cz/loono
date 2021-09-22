import 'package:flutter/material.dart';
import 'package:loono/models/user.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/universal_doctor_screen.dart';
import 'package:loono/utils/registry.dart';

class OnboardingGynecologyScreen extends StatelessWidget {
  final _usersDao = registry.get<DatabaseService>().users;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UniversalDoctorScreen(
          questionHeader: "Gynekologii?",
          imagePath: "gynecology",
          numberOfSteps: 3,
          currentStep: 2,
          nextCallback1: () async {
            await _usersDao.updateGynecologyCcaVisit(CcaDoctorVisit.inLastTwoYears);
            Navigator.pushNamed(context, "/gynecology_achievement");
          },
          nextCallback2: () async {
            await _usersDao.updateGynecologyCcaVisit(CcaDoctorVisit.moreThanTwoYearsOrIdk);
            Navigator.pushNamed(context, "/onboarding/doctor/gynecology-date");
          },
          skipScreen: "/create-account",
        ),
      ),
    );
  }
}
