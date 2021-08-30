import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';

class GynecologyAchievementScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: AchievementScreen(
              textLower: "Jen tak dál",
              textMiddle: "Tato prohlídka je důležitá pro včasné odhalení rakoviny děložního čípku a jiných obtíží.",
              textUpper: "Báječné! Jsi poctivější než polovina žen v Česku",
              nextScreen: '/onboarding/doctor/gynecology-date',
              numberOfPoints: 200,
            )
        )
    );
  }
}