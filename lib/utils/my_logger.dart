import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MyLogger{
  static Future<void> writeToFile(String text) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/SplashscreenLogs.txt');
    await file.writeAsString('log: ${DateTime.now()}: $text', mode: FileMode.append);
    await file.writeAsString('\n', mode: FileMode.append);
  }

  static Future<void> initFile() async {
    final directory = await getApplicationDocumentsDirectory();
    // print(directory);
    final file = File('${directory.path}/SplashscreenLogs.txt');
    await file.writeAsString('log: ${DateTime.now()}: Initializing logs...');
    await file.writeAsString('\n', mode: FileMode.append);
  }
}
