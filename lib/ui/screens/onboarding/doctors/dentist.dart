import 'package:flutter/material.dart';
import 'package:loono/models/user.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/universal_doctor_screen.dart';
import 'package:loono/utils/registry.dart';

class OnboardingDentistScreen extends StatelessWidget {
  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UniversalDoctorScreen(
          questionHeader: "Zubaře",
          imagePath: "dentist",
          numberOfSteps: 3,
          currentStep: 3,
          nextCallback1: () async {
            await _usersDao.updateDentistCcaVisit(CcaDoctorVisit.inLastTwoYears);
            Navigator.pushNamed(context, '/dentist_achievement');
          },
          nextCallback2: () async {
            await _usersDao.updateDentistCcaVisit(CcaDoctorVisit.moreThanTwoYearsOrIdk);
            Navigator.pushNamed(context, '/create-account');
          },
        ),
      ),
    );
  }
}
