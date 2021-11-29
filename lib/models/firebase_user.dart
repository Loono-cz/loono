import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:loono/services/db/database.dart' as db;

/// A wrapper for Firebase [User] to avoid conflicts with the local [db.User].
class AuthUser {
  const AuthUser({required User firebaseUser}) : _firebaseUser = firebaseUser;

  final User _firebaseUser;

  String get uid => _firebaseUser.uid;

  String? get name => _firebaseUser.displayName;

  String? get email => _firebaseUser.email;

  bool get isAnonymous => _firebaseUser.isAnonymous;

  String? get token => _firebaseUser.refreshToken;

  Future<void> delete() async => _firebaseUser.delete();

  Future<String> getIdToken({bool forceRefresh = false}) async =>
      _firebaseUser.getIdToken(forceRefresh);

  Future<UserCredential> linkWithCredential(AuthCredential credential) async =>
      _firebaseUser.linkWithCredential(credential);

  Future<UserCredential> linkWithPopup(AuthProvider provider) async =>
      _firebaseUser.linkWithPopup(provider);

  Future<User> unlink(String providerId) async => _firebaseUser.unlink(providerId);
}
