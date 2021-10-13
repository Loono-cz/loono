import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/utils/crypto_utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum _SignInMethod { apple, google }

class AuthService {
  final _auth = FirebaseAuth.instance;

  final _googleSignIn = GoogleSignIn();

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

  Future<Either<AuthFailure, AuthUser>> signInWithGoogle() async => _signInWithGoogle();

  Future<Either<AuthFailure, AuthUser>> signInWithApple() async => _signInWithApple();

  Future<Tuple2<bool, AuthFailure?>> checkGoogleAccountExists() async =>
      _checkAccountExists(_SignInMethod.google);

  Future<Tuple2<bool, AuthFailure?>> checkAppleAccountExists() async =>
      _checkAccountExists(_SignInMethod.apple);

  Future<Tuple2<bool, AuthFailure?>> _checkAccountExists(_SignInMethod signInMethod) async {
    final Either<AuthFailure, AuthUser> result;
    switch (signInMethod) {
      case _SignInMethod.apple:
        result = await _signInWithApple(checkIfAccountExists: true);
        break;
      case _SignInMethod.google:
        result = await _signInWithGoogle(checkIfAccountExists: true);
        break;
    }
    return result.fold(
      (failure) => failure.maybeWhen(
        accountNotExists: (email) => Tuple2(false, AuthFailure.accountNotExists(email)),
        orElse: () => const Tuple2(true, null),
      ),
      (authUser) => const Tuple2(true, null),
    );
  }

  Future<Either<AuthFailure, AuthUser>> _signInWithGoogle({
    bool checkIfAccountExists = false,
  }) async {
    // TODO: better error handling
    GoogleSignInAccount? googleUser;
    try {
      googleUser = await _googleSignIn.signIn();
    } on PlatformException catch (e) {
      if (e.code == 'network_error') return const Left(AuthFailure.network());
      return const Left(AuthFailure.unknown());
    } catch (_) {
      return const Left(AuthFailure.unknown());
    }

    // if googleUser is null, signIn was interrupted/cancelled
    if (googleUser == null) return const Left(AuthFailure.noMessage());

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithCredential(credential);
      // TODO: isNewUser != accountNotExists
      // this actually checks if it is a new user and then registers him to the Firebase,
      // so it only works for the first time
      if (checkIfAccountExists) {
        final isNewUser = userCredential.additionalUserInfo?.isNewUser == true;
        if (isNewUser) {
          final email = userCredential.additionalUserInfo?.profile?['email'] as String?;
          return Left(AuthFailure.accountNotExists(email));
        }
      }
    } catch (_) {
      return const Left(AuthFailure.unknown());
    }
    return userCredential.user == null
        ? const Left(AuthFailure.unknown())
        : Right(_authUserFromFirebase(userCredential.user)!);
  }

  Future<Either<AuthFailure, AuthUser>> _signInWithApple({
    bool checkIfAccountExists = false,
  }) async {
    // TODO: better error handling
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    AuthorizationCredentialAppleID? appleCredential;
    try {
      appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
    } on SignInWithAppleException catch (_) {
      // TODO: find out network error code
      return const Left(AuthFailure.unknown());
    } catch (_) {
      return const Left(AuthFailure.unknown());
    }

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithCredential(oauthCredential);
      if (checkIfAccountExists) {
        final isNewUser = userCredential.additionalUserInfo?.isNewUser == true;
        if (isNewUser) {
          // TODO: add email to message
          return const Left(AuthFailure.accountNotExists());
        }
      }
    } catch (_) {
      return const Left(AuthFailure.unknown());
    }
    return userCredential.user == null
        ? const Left(AuthFailure.unknown())
        : Right(_authUserFromFirebase(userCredential.user)!);
  }

  Future<Either<AuthFailure, AuthUser>> signInAnonymously() async {
    final UserCredential? userCredential;
    try {
      userCredential = await _auth.signInAnonymously();
    } on FirebaseException catch (e) {
      if (e.code == 'network-request-failed') return const Left(AuthFailure.network());
      return const Left(AuthFailure.unknown());
    } catch (_) {
      return const Left(AuthFailure.unknown());
    }
    return userCredential.user == null
        ? const Left(AuthFailure.unknown())
        : Right(_authUserFromFirebase(userCredential.user)!);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
