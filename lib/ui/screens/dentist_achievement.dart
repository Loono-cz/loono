import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';
import 'package:provider/provider.dart';

class DentistAchievementScreen extends StatelessWidget {
  const DentistAchievementScreen({Key? key}) : super(key: key);

  static const type = ExaminationType.DENTIST;
  static const int worth = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AchievementScreen(
          header: context.l10n.achievement_headband_dentist_header,
          textLines: [
            context.l10n.achievement_dentist_text_1,
          ],
          onButtonTap: () =>
              context.read<OnboardingStateService>().obtainAchievementForExamination(type),
          numberOfPoints: worth,
          itemPath: 'assets/icons/headband-dentist.svg',
        ),
      ),
    );
  }
}
