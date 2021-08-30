import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';

class DentistAchievementScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: AchievementScreen(
              textLower: "Jen tak dál",
              textMiddle: "Zubní prohlídka ti dává jistotu, že je v tvé ústní dutině vše v pořádku a neděje se v ní nic skrytého, co by časem mohlo zbytečně bolet.",
              textUpper: "Gratulujeme!",
              nextScreen: '/onboarding/doctor/dentist-date',
              numberOfPoints: 200,
            )
        )
    );
  }
}
