import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/utils/crypto_utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class IAuth {
  Future<Either<AuthFailure, AuthUser>> signInWithGoogle();

  Future<Either<AuthFailure, AuthUser>> signInWithApple();

  Future<Either<AuthFailure, AuthUser>> signInAnonymously();

  Future<void> signOut();
}

class AuthService implements IAuth {
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

  @override
  Future<Either<AuthFailure, AuthUser>> signInWithGoogle() async {
    // TODO: better error handling
    GoogleSignInAccount? googleUser;
    try {
      googleUser = await _googleSignIn.signIn();
    } on PlatformException catch (e) {
      if (e.code == 'network_error') return const Left(NetworkFailure());
      const Left(UnknownFailure());
    } catch (_) {
      const Left(UnknownFailure());
    }

    // if googleUser is null, signIn was interrupted/cancelled
    if (googleUser == null) return const Left(NoMessageFailure());

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithCredential(credential);
    } catch (_) {
      return const Left(UnknownFailure());
    }
    return userCredential.user == null
        ? const Left(UnknownFailure())
        : Right(_authUserFromFirebase(userCredential.user)!);
  }

  @override
  Future<Either<AuthFailure, AuthUser>> signInWithApple() async {
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
    } on SignInWithAppleAuthorizationException catch (e) {
      return Left(UnknownFailure('Chyba: ${e.message}\nZkus to znovu později.'));
    } catch (_) {
      return const Left(UnknownFailure());
    }

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithCredential(oauthCredential);
    } catch (_) {
      return const Left(UnknownFailure());
    }
    return userCredential.user == null
        ? const Left(UnknownFailure())
        : Right(_authUserFromFirebase(userCredential.user)!);
  }

  @override
  Future<Either<AuthFailure, AuthUser>> signInAnonymously() async {
    final UserCredential? userCredential;
    try {
      userCredential = await _auth.signInAnonymously();
    } on FirebaseException catch (e) {
      if (e.code == 'network-request-failed') return const Left(NetworkFailure());
      return const Left(UnknownFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
    return userCredential.user == null
        ? const Left(UnknownFailure())
        : Right(_authUserFromFirebase(userCredential.user)!);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
