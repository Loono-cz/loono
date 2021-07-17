import 'package:flutter/material.dart';
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
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (_) => DashboardScreen(),
      },
    );
  }
}
