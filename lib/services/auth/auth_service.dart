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
import 'package:loono/utils/memoized_stream.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  AuthService() {
    _authStateStream = MemoizedStream(_authStateStreamController.stream);
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _changeAuthState(const AuthState.loggedIn());
      } else {
        // User is not logged in on app launch, navigate to Welcome screen.
        //
        // If user is logging out or logged out manually through sign out button,
        // navigate to LogoutScreen.
        if (_authState != const AuthState.loggingOut() &&
            _authState != const AuthState.loggedOutManually()) {
          _changeAuthState(const AuthState.notLoggedIn());
        }
      }
    });
  }

  final StreamController<AuthState> _authStateStreamController = StreamController.broadcast();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthState _authState = const AuthState.unknown();

  late MemoizedStream<AuthState> _authStateStream;

  late FirebaseAuth _auth;

  MemoizedStream<AuthState> get authStateStream => _authStateStream;

  Future<AuthUser?> get currentUser async => _authUserFromFirebase(_auth.currentUser);

  void _changeAuthState(AuthState state) {
    _authState = state;
    _authStateStreamController.add(state);
  }

  AuthUser? _authUserFromFirebase(User? firebaseUser) {
    final authUser = firebaseUser == null ? null : AuthUser(firebaseUser: firebaseUser);
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
    final authResult = await signInWithGoogle(isAccountNew: false);
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

  Future<Either<AuthFailure, AuthUser>> signInWithGoogle({bool isAccountNew = true}) async {
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
    } catch (_) {
      return const Left(AuthFailure.unknown());
    }
    if (userCredential.user == null) {
      return const Left(AuthFailure.unknown());
    } else {
      final authUser = _authUserFromFirebase(userCredential.user)!;
      if (isAccountNew) {
        _changeAuthState(AuthState.loggedIn(isAccountNew: true, authUser: authUser));
      }
      return Right(authUser);
    }
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
    } catch (_) {
      return const Left(AuthFailure.unknown());
    }
    if (userCredential.user == null) {
      return const Left(AuthFailure.unknown());
    } else {
      final authUser = _authUserFromFirebase(userCredential.user)!;
      if (idToken == null) {
        _changeAuthState(AuthState.loggedIn(isAccountNew: true, authUser: authUser));
      }
      return Right(authUser);
    }
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
      _changeAuthState(const AuthState.loggedIn(isAccountNew: true));
      return Right(_authUserFromFirebase(userCredential.user)!);
    }
  }

  Future<void> signOut() async {
    _changeAuthState(const AuthState.loggingOut());
    try {
      await _auth.signOut();
      _changeAuthState(const AuthState.loggedOutManually());
      await _googleSignIn.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
