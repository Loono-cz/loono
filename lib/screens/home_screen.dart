import 'package:flutter/material.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/core/app_flavor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.config, Key? key}) : super(key: key);

  final AppConfig config;

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
