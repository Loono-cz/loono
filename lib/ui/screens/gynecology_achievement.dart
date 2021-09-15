import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';

class GynecologyAchievementScreen extends StatelessWidget {
  const GynecologyAchievementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AchievementScreen(
          header: context.l10n.achievement_gynecology_header,
          textLines: [
            context.l10n.achievement_gynecology_text_1,
            '${context.l10n.achievement_keep_it_up_text}!',
          ],
          nextScreen: '/onboarding/doctor/gynecology-date',
          numberOfPoints: 200,
        ),
      ),
    );
  }
}
