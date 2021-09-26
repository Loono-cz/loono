import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/achievement.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';
import 'package:loono/utils/registry.dart';

class DentistAchievementScreen extends StatelessWidget {
  const DentistAchievementScreen({Key? key}) : super(key: key);

  static const String id = 'DentistAchievementScreen';
  static const int _worth = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AchievementScreen(
          header: context.l10n.achievement_congrats_header,
          textLines: [
            context.l10n.achievement_dentist_text_1,
          ],
          onButtonTap: () async => registry
              .get<DatabaseService>()
              .users
              .updateAchievementCollection(Achievement(id: id, points: _worth)),
          numberOfPoints: 200,
        ),
      ),
    );
  }
}
