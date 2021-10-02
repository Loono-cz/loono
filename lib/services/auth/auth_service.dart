import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/utils/crypto_utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class IAuth {
  Future<AuthUser?> signInWithGoogle();

  Future<AuthUser?> signInWithApple();

  Future<AuthUser?> signInAnonymously();

  Future<void> signOut();
}

class AuthService implements IAuth {
  final _auth = FirebaseAuth.instance;

  Future<AuthUser?> getCurrentUser() async => _authUserFromFirebase(_auth.currentUser);

  Stream<AuthUser?> get onAuthStateChanged =>
      _auth.authStateChanges().map((firebaseUser) => _authUserFromFirebase(firebaseUser));

  AuthUser? _authUserFromFirebase(User? firebaseUser) {
    final authUser = firebaseUser == null
        ? null
        : AuthUser(
            uid: firebaseUser.uid,
            name: firebaseUser.displayName,
            email: firebaseUser.email,
            avatarUrl: firebaseUser.photoURL,
            isAnonymous: firebaseUser.isAnonymous,
          );
    return authUser;
  }

  @override
  Future<AuthUser?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return _authUserFromFirebase(userCredential.user);
  }

  @override
  Future<AuthUser?> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    final userCredential = await _auth.signInWithCredential(oauthCredential);
    return _authUserFromFirebase(userCredential.user);
  }

  @override
  Future<AuthUser?> signInAnonymously() async {
    final userCredential = await _auth.signInAnonymously();
    return _authUserFromFirebase(userCredential.user);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
