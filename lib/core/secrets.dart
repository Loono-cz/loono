import 'dart:convert';

import 'package:flutter/services.dart';

/// Create the file secrets.json in the root directory of this app.
/// Replace the mocked values with the actual values.
/// Ask a colleague for the up-to-date ones.
///
/// {
///   "sentryDns": "secret-value",
/// }
class Secrets {
  Secrets._({required Map<String, dynamic> config}) : _config = config;

  static Future<Secrets> create() async {
    final configAsString = await rootBundle.loadString('secrets.json');
    final config = json.decode(configAsString) as Map<String, dynamic>;

    return Secrets._(
      config: Map<String, dynamic>.unmodifiable(config),
    );
  }

  final Map<String, dynamic> _config;

  String get sentryDns => _config['sentryDns'] as String;
}
