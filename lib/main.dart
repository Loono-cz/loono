import 'package:flutter/material.dart';
import 'package:loono/ui/screens/achievement.dart';
import 'package:loono/ui/screens/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/doctors/gynecology.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono/ui/screens/dashboard.dart';

Future<void> main() async {
  await setup();
  runApp(Loono());
}

class Loono extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loono',
      color: Colors.deepOrange,
      initialRoute: '/doctor/general-practicioner',
      routes: {
        '/doctor/general-practicioner': (_) => GeneralPracticionerScreen(),
        '/doctor/gynecology': (_) => GynecologyScreen(),
        '/achievement': (_) => AchievementScreen(),
        '/dashboard': (_) => DashboardScreen(),
      },
    );
  }
}
