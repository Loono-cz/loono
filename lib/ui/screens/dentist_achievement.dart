import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';
import 'package:provider/provider.dart';

class DentistAchievementScreen extends StatelessWidget {
  const DentistAchievementScreen({Key? key}) : super(key: key);

  static const String id = 'DentistAchievementScreen';
  static const int _worth = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AchievementScreen(
          header: context.l10n.achievement_headband_dentist_header,
          textLines: [
            context.l10n.achievement_dentist_text_1,
          ],
          onButtonTap: () => context.read<OnboardingStateService>().obtainAchievement(id),
          numberOfPoints: _worth,
          itemPath: 'assets/icons/headband-dentist.svg',
        ),
      ),
    );
  }
}
