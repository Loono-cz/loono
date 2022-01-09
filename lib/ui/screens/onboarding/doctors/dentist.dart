import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/user.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/universal_doctor_screen.dart';
import 'package:loono/utils/registry.dart';

class OnboardingDentistScreen extends StatelessWidget {
  OnboardingDentistScreen({Key? key, required this.sex}) : super(key: key);

  final Sex sex;

  final _userRepository = registry.get<UserRepository>();

  static const _type = ExaminationType.DENTIST;
  static const _interval = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UniversalDoctorScreen(
          examinationType: _type,
          question: sex.getUniversalDoctorLabel(context),
          questionHighlight: context.l10n.dentist_question_highlight,
          assetPath: _type.assetPath,
          numberOfSteps: sex.totalNumOfSteps,
          currentStep: sex.dentistStep,
          nextButton1Text: getQuestionnaireFirstAnswer(context, interval: _interval),
          nextButton2Text: getQuestionnaireSecondAnswer(context, interval: _interval),
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
