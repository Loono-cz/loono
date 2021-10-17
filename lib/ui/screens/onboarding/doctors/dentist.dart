import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/models/user.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/universal_doctor_screen.dart';
import 'package:loono/utils/registry.dart';

class OnboardingDentistScreen extends StatelessWidget {
  OnboardingDentistScreen({Key? key, required this.sex}) : super(key: key);

  final Sex sex;

  final _userRepository = registry.get<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UniversalDoctorScreen(
          question: sex.getUniversalDoctorLabel(context),
          questionHighlight: "Zubaře",
          imagePath: "dentist",
          numberOfSteps: sex.totalNumOfSteps,
          currentStep: sex.dentistStep,
          nextCallback1: () async =>
              _userRepository.updateDentistCcaVisit(CcaDoctorVisit.inLastTwoYears),
          nextCallback2: () async {
            await _userRepository.updateDentistCcaVisit(CcaDoctorVisit.moreThanTwoYearsOrIdk);
            AutoRouter.of(context).push(CreateAccountRoute());
          },
        ),
      ),
    );
  }
}
