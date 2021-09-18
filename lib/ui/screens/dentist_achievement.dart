import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';

class DentistAchievementScreen extends StatelessWidget {
  const DentistAchievementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AchievementScreen(
          header: context.l10n.achievement_congrats_header,
          textLines: [
            context.l10n.achievement_dentist_text_1,
          ],
          nextScreen: '/onboarding/doctor/dentist-date',
          numberOfPoints: 200,
        ),
      ),
    );
  }
}
