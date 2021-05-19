import 'package:flutter/material.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/main_common.dart';

void main() {
  runApp(
    buildApp(
      config: const ProdConfig(),
    ),
  );
}