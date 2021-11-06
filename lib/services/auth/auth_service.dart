import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/services/auth/auth_state.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/utils/crypto_utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final StreamController<AuthState> _authStateStreamController = StreamController.broadcast();

  AuthState _authState = const AuthState.unknown();

  // Account is new, go to Nickname edit route
  bool get _isAccountNewlyCreated => _authState == const AuthState.accountCreated();

  AuthService() {
    _authStateStream = _authStateStreamController.stream;
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        if (!_isAccountNewlyCreated) {
          _changeAuthState(const AuthState.loggedIn());
        }
      } else {
        // If user is logged out manually through sign out button,
        // do not go to WelcomeScreen, but to LogoutScreen (handled in registry.dart)
        if (_authState != const AuthState.loggingOut() &&
            _authState != const AuthState.loggedManually()) {
          _changeAuthState(const AuthState.loggedOut());
        }
      }
    });
  }

  late Stream<AuthState> _authStateStream;

  late FirebaseAuth _auth;

  Stream<AuthState> get authStateStream => _authStateStream;

  final _googleSignIn = GoogleSignIn();

  Future<AuthUser?> getCurrentUser() async => _authUserFromFirebase(_auth.currentUser);

  void _changeAuthState(AuthState state) {
    _authState = state;
    _authStateStreamController.add(state);
  }

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

  Future<Either<AuthFailure, AuthUser>> checkGoogleAccountExistsAndSignIn() async {
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

    final signInMethods = await _auth.fetchSignInMethodsForEmail(googleUser.email);
    if (signInMethods.isEmpty) {
      await _googleSignIn.signOut();
      return Left(AuthFailure.accountNotExists(googleUser.email));
    }

    // account exists, sign in
    final authResult = await signInWithGoogle();
    return authResult;
  }

  Future<Either<AuthFailure, AuthUser>> checkAppleAccountExistsAndSignIn() async {
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
    } catch (_) {
      return const Left(AuthFailure.unknown());
    }

    if (appleCredential.email == null) return const Left(AuthFailure.unknown());

    final signInMethods = await _auth.fetchSignInMethodsForEmail(appleCredential.email!);
    if (signInMethods.isEmpty) {
      return Left(AuthFailure.accountNotExists(appleCredential.email));
    }

    // account exists, sign in
    final authResult = await signInWithApple(appleCredential.identityToken);
    return authResult;
  }

  Future<Either<AuthFailure, AuthUser>> signInWithGoogle() async {
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

      final isNewUser = userCredential.additionalUserInfo?.isNewUser == true;
      if (isNewUser) _changeAuthState(const AuthState.accountCreated());
    } catch (_) {
      return const Left(AuthFailure.unknown());
    }
    return userCredential.user == null
        ? const Left(AuthFailure.unknown())
        : Right(_authUserFromFirebase(userCredential.user)!);
  }

  Future<Either<AuthFailure, AuthUser>> signInWithApple([String? idToken]) async {
    // TODO: better error handling
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.

    AuthorizationCredentialAppleID? appleCredential;
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    if (idToken == null) {
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
    }

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: idToken ?? appleCredential?.identityToken,
      rawNonce: rawNonce,
    );

    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithCredential(oauthCredential);

      final isNewUser = userCredential.additionalUserInfo?.isNewUser == true;
      if (isNewUser) _changeAuthState(const AuthState.accountCreated());
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
    if (userCredential.user == null) {
      return const Left(AuthFailure.unknown());
    } else {
      _changeAuthState(const AuthState.accountCreated());
      return Right(_authUserFromFirebase(userCredential.user)!);
    }
  }

  Future<void> finishCreateAccountProcess() async {
    if (await getCurrentUser() != null) {
      _changeAuthState(const AuthState.loggedIn());
    }
  }

  Future<void> signOut() async {
    _changeAuthState(const AuthState.loggingOut());
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      _changeAuthState(const AuthState.loggedManually());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
