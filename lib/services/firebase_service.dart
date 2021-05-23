import 'package:firebase_core/firebase_core.dart';
import 'package:loono/core/app_config.dart';

class FirebaseService {
  FirebaseService._(this.app);

  final FirebaseApp app;

  static Future<FirebaseService> init(AppConfig config) async {
    final app = await Firebase.initializeApp();
    return FirebaseService._(app);
  }
}
