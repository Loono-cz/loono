import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SaveDirectories {
  Future<void> init() async {
    supportDir = await getApplicationSupportDirectory();
  }

  late final Directory supportDir;
}
