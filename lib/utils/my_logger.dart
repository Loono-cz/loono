import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MyLogger {
  factory MyLogger() {
    return _instance;
  }

  MyLogger._internal();
  static final MyLogger _instance = MyLogger._internal();
  Directory? directory;
  File? file;
  List<String> logs = [];

  Future<void> writeToFile(String text) async {
    logs.add('log: ${DateTime.now()}: $text\n');
    file?.writeAsString(logs.toString()).ignore();
  }

  Future<void> initFile() async {
    directory = await getApplicationDocumentsDirectory();
    file = File('${directory?.path}/SplashscreenLogs.txt');
    // print(directory);
    logs.add('log: ${DateTime.now()}: Initializing logs...\n');
  }
}
