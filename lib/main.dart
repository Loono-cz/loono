import 'package:flutter/material.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono/ui/screens/dashboard.dart';
import 'package:loono/ui/screens/intro_video.dart';

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
      initialRoute: '/intro_video',
      routes: {
        '/dashboard': (_) => DashboardScreen(),
        '/intro_video': (_) => IntroVideoScreen(),
      },
    );
  }
}
