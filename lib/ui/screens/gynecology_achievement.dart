import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/achievement.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';
import 'package:loono/utils/registry.dart';

class GynecologyAchievementScreen extends StatelessWidget {
  const GynecologyAchievementScreen({Key? key}) : super(key: key);

  static const String id = 'GynecologyAchievementScreen';
  static const int _worth = 200;

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
          onButtonTap: () async => registry
              .get<DatabaseService>()
              .users
              .updateAchievementCollection(Achievement(id: id, points: _worth)),
          numberOfPoints: _worth,
          itemPath: 'assets/icons/belt-gynecologist.svg',
        ),
      ),
    );
  }
}
