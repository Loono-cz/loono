import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';
import 'package:provider/provider.dart';

class GeneralPracticionerAchievementScreen extends StatelessWidget {
  const GeneralPracticionerAchievementScreen({Key? key}) : super(key: key);

  static const type = ExaminationType.GENERAL_PRACTITIONER;
  static const int _worth = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AchievementScreen(
          header: context.l10n.achievement_coat_practitioner_header,
          textLines: [
            context.l10n.achievement_general_practitioner_text_1,
            '${context.l10n.achievement_keep_it_up_text}...',
          ],
          onButtonTap: () =>
              context.read<OnboardingStateService>().obtainAchievementForExamination(type),
          numberOfPoints: _worth,
          itemPath: 'assets/icons/coat-practitioner.svg',
        ),
      ),
    );
  }
}
