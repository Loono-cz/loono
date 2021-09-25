import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';
import 'package:provider/provider.dart';

class GeneralPracticionerAchievementScreen extends StatelessWidget {
  const GeneralPracticionerAchievementScreen({Key? key}) : super(key: key);

  static const String id = 'GeneralPracticionerAchievementScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AchievementScreen(
          header: context.l10n.achievement_congrats_header,
          textLines: [
            context.l10n.achievement_general_practitioner_text_1,
            '${context.l10n.achievement_keep_it_up_text}...',
          ],
          onButtonTap: () => context.read<OnboardingStateService>().obtainAchievement(id),
          numberOfPoints: 200,
        ),
      ),
    );
  }
}
