import 'package:firebase_auth/firebase_auth.dart';
import 'package:loono/services/db/database.dart' as db;

/// A wrapper for Firebase [User] to avoid conflicts with the local [db.User].
class AuthUser {
  const AuthUser({required User firebaseUser}) : _firebaseUser = firebaseUser;

  final User _firebaseUser;

  String get uid => _firebaseUser.uid;

  String? get name => _firebaseUser.displayName;

  String? get email => _firebaseUser.email;

  bool get isAnonymous => _firebaseUser.isAnonymous;

  Future<String> getIdToken({bool forceRefresh = false}) async =>
      _firebaseUser.getIdToken(forceRefresh);
}
