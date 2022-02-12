import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/utils/crypto_utils.dart';
import 'package:loono_api/loono_api.dart' as api;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  AuthService({required api.LoonoApi api}) {
    _api = api;
    _auth.authStateChanges().listen((authUser) async {
      if (authUser == null) {
        _clearUserToken();
      }
    });
  }

  late final api.LoonoApi _api;

  final _auth = FirebaseAuth.instance;

  final _googleSignIn = GoogleSignIn();

  Future<AuthUser?> getCurrentUser() async => _authUserFromFirebase(_auth.currentUser);

  Future<String?> get userUid async {
    final user = await getCurrentUser();
    return user?.uid;
  }

  Stream<AuthUser?> get onAuthStateChanged => _auth.authStateChanges().map(_authUserFromFirebase);

  AuthUser? _authUserFromFirebase(User? firebaseUser) =>
      firebaseUser == null ? null : AuthUser(firebaseUser: firebaseUser);

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
    return userCredential.user == null
        ? const Left(AuthFailure.unknown())
        : Right(_authUserFromFirebase(userCredential.user)!);
  }

  Future<Either<AuthFailure, AuthUser>> signInWithApple([String? idToken]) async {
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
    return userCredential.user == null
        ? const Left(AuthFailure.unknown())
        : Right(_authUserFromFirebase(userCredential.user)!);
  }

  Future<void> signOut() async {
    _clearUserToken();
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  // TODO: refresh token more often - maybe on each api call ? (https://cesko-digital.atlassian.net/browse/LOON-477)
  Future<void> refreshUserToken(AuthUser authUser) async {
    final token = await authUser.getIdToken();
    _api.dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void _clearUserToken() => _api.dio.options.headers.remove('Authorization');
}
