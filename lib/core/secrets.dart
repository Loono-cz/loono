import 'dart:convert';

import 'package:flutter/services.dart';

/// Create the file secrets.json in the root directory of this app.
/// Replace the mocked values with the actual values.
/// Ask a colleague for the up-to-date ones.
///
/// {
///   "example-key": "example-value",
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

  // ignore: unused_field
  final Map<String, dynamic> _config;

  // String get exampleKey => _config['exampleKey'] as String;
}
