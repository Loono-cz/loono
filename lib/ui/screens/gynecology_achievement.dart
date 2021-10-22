import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';
import 'package:provider/provider.dart';

class GynecologyAchievementScreen extends StatelessWidget {
  const GynecologyAchievementScreen({Key? key}) : super(key: key);

  static const type = ExaminationType.GYNECOLOGIST;
  static const int worth = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AchievementScreen(
          header: context.l10n.achievement_belt_gynecologist_header,
          textLines: [
            context.l10n.achievement_gynecology_text_1,
            '${context.l10n.achievement_keep_it_up_text}!',
          ],
          onButtonTap: () =>
              context.read<OnboardingStateService>().obtainAchievementForExamination(type),
          numberOfPoints: worth,
          itemPath: 'assets/icons/belt-gynecologist.svg',
        ),
      ),
    );
  }
}
