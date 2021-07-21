import 'dart:convert';

import 'package:logging/logging.dart';

class AppLogger {
  AppLogger(String className) : _logger = Logger(className);

  static final _levelEmoji = <Level, String>{
    Level.FINE: '🔎',
    Level.CONFIG: '💬',
    Level.INFO: '💡',
    Level.WARNING: '⚠️',
    Level.SEVERE: '⛔',
  };

  static final _levelName = <Level, String>{
    Level.FINE: 'TRACE',
    Level.CONFIG: 'DEBUG',
    Level.INFO: 'INFO',
    Level.WARNING: 'WARN',
    Level.SEVERE: 'ERROR',
  };

  static const JsonEncoder jsonEncoder = JsonEncoder.withIndent('  ');

  final Logger _logger;

  static void initialize({required bool isReleaseMode}) {
    String stringifyMessage(dynamic message) {
      return message is Map || message is Iterable
          ? jsonEncoder.convert(message)
          : message.toString();
    }

    Logger.root.level = isReleaseMode ? Level.WARNING : Level.FINE;

    Logger.root.onRecord.listen((rec) async {
      final entry =
          '${rec.time.toIso8601String()} '
          '${_levelEmoji[rec.level]} ${_levelName[rec.level]} - '
          '[${rec.loggerName}] ${stringifyMessage(rec.message)}';

      if (isReleaseMode) {
        // TODO(any): send logs to Firebase
      } else {
        // ignore: avoid_print
        print(entry);
      }
    });
  }

  void trace(Object? message, [Object? error, StackTrace? stackTrace]) {
    _logger.fine(message, error, stackTrace);
  }

  void debug(Object? message, [Object? error, StackTrace? stackTrace]) {
    _logger.config(message, error, stackTrace);
  }

  void info(Object? message, [Object? error, StackTrace? stackTrace]) {
    _logger.info(message, error, stackTrace);
  }

  void warning(Object? message, [Object? error, StackTrace? stackTrace]) {
    _logger.warning(message, error, stackTrace);
  }

  void error(Object? message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }
}
