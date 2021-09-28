import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';

class GeneralPracticionerAchievementScreen extends StatelessWidget {
  const GeneralPracticionerAchievementScreen({Key? key}) : super(key: key);

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
          nextScreen: '/onboarding/doctor/general-practitioner-date',
          numberOfPoints: 200,
          itemPath: 'assets/icons/coat-practitioner.svg',
        ),
      ),
    );
  }
}
