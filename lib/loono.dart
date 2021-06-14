import 'package:flutter/material.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/core/app_flavor.dart';
import 'package:loono/screens/home/home.screen.dart';
import 'package:loono/screens/screen_navigator.dart';

class Loono extends StatelessWidget {
  const Loono({
    required this.config,
    Key? key,
  }) : super(key: key);

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loono',
      theme: ThemeData(
        primarySwatch: config.flavor.map(
          prod: () => Colors.purple,
          dev: () => Colors.deepOrange,
        ),
      ),
      home: ScreenNavigator(
        initialPages: [
          HomeScreen.buildPage(context)
        ],
      ),
    );
  }
}