import 'package:flutter/material.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/core/app_flavor.dart';
import 'package:loono/screens/screen_names.dart';
import 'package:loono/utils/state_management.dart';

class HomeScreen extends StatelessWidget {
  @visibleForTesting
  const HomeScreen({
    required this.config,
    Key? key,
  }) : super(key: key);

  final AppConfig config;

  static Page<Object> buildPage(BuildContext context) {
    return MaterialPage(
      key: const ValueKey(ScreenNames.homeScreen),
      name: ScreenNames.homeScreen,
      child: HomeScreen(
        config: find<AppConfig>(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loono'),
      ),
      body: Center(
        child: Text(
          config.flavor.map(
            prod: () => 'PROD',
            dev: () => 'DEV',
          ),
        ),
      ),
    );
  }
}
