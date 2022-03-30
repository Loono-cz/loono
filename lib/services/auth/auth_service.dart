import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loono/models/apple_account_info.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/models/social_login_account.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/services/secure_storage_service.dart';
import 'package:loono/utils/crypto_utils.dart';
import 'package:loono_api/loono_api.dart' as api;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  AuthService({
    required api.LoonoApi api,
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required SecureStorageService secureStorageService,
  })  : _api = api,
        _auth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _secureStorage = secureStorageService {
    _auth.authStateChanges().listen((authUser) async {
      if (authUser == null) {
        _clearUserToken();
      }
    });
  }

  final api.LoonoApi _api;

  final FirebaseAuth _auth;

  final GoogleSignIn _googleSignIn;

  final SecureStorageService _secureStorage;

  Future<AuthUser?> getCurrentUser() async => _authUserFromFirebase(_auth.currentUser);

  Future<String?> get userUid async {
    final user = await getCurrentUser();
    return user?.uid;
  }

  Stream<AuthUser?> get onAuthStateChanged => _auth.authStateChanges().map(_authUserFromFirebase);

  AuthUser? _authUserFromFirebase(User? firebaseUser) =>
      firebaseUser == null ? null : AuthUser(firebaseUser: firebaseUser);

  Future<Either<AuthFailure, AuthUser>> checkGoogleAccountExistsAndSignIn() async {
    // clear existing saved account from Google account picker
    await _googleSignIn.signOut();

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
      return Left(AuthFailure.accountNotExists(SocialLoginAccount.google(googleUser)));
    }

    // account exists, sign in
    final authResult = await signInWithGoogle(googleUser);
    return authResult;
  }

  Future<Either<AuthFailure, AuthUser>> checkAppleAccountExistsAndSignIn() async {
    final cryptoNonce = CryptoNonce();
    final appleCredential = await getAppleCredential(cryptoNonce);

    if (appleCredential == null) return const Left(AuthFailure.unknown());

    final appleUserId = appleCredential.userIdentifier;
    if (appleUserId == null) return const Left(AuthFailure.unknown());

    final AppleAccountInfo appleAccountInfo;
    final appleUserEmail = appleCredential.email;
    if (appleUserEmail == null) {
      // try to obtain the account from the secure storage
      final savedAccountInfo = await _secureStorage.getAppleAccountInfoById(appleUserId);
      if (savedAccountInfo == null) {
        return Left(
          AuthFailure.accountNotExists(SocialLoginAccount.apple(appleCredential, cryptoNonce)),
        );
      } else {
        appleAccountInfo = savedAccountInfo;
      }
    } else {
      // we got the email and other user details, save it so we can get it later
      // we get these details only during first authorization
      appleAccountInfo = AppleAccountInfo(
        userIdentifier: appleUserId,
        email: appleUserEmail,
        givenName: appleCredential.givenName,
        familyName: appleCredential.familyName,
      );
      await _secureStorage.saveAppleAccountInfo(appleAccountInfo);
    }

    final signInMethods = await _auth.fetchSignInMethodsForEmail(appleAccountInfo.email);
    if (signInMethods.isEmpty) {
      return Left(
        AuthFailure.accountNotExists(
          SocialLoginAccount.apple(appleCredential, cryptoNonce, appleAccountInfo),
        ),
      );
    }

    // account exists, sign in
    final authResult = await signInWithApple(appleCredential.identityToken, cryptoNonce);
    return authResult;
  }

  Future<Either<AuthFailure, AuthUser>> signInWithGoogle([
    GoogleSignInAccount? existingGoogleUser,
  ]) async {
    if (existingGoogleUser == null) {
      await _googleSignIn.signOut();
    }

    var googleUser = existingGoogleUser;
    if (existingGoogleUser == null) {
      try {
        googleUser = await _googleSignIn.signIn();
      } on PlatformException catch (e) {
        if (e.code == 'network_error') return const Left(AuthFailure.network());
        return const Left(AuthFailure.unknown());
      } catch (_) {
        return const Left(AuthFailure.unknown());
      }
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

  Future<Either<AuthFailure, AuthUser>> signInWithApple([
    String? existingIdToken,
    CryptoNonce? existingNonce,
  ]) async {
    assert(
      (existingIdToken != null && existingNonce != null) ||
          (existingIdToken == null && existingNonce == null),
    );
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.

    AuthorizationCredentialAppleID? appleCredential;

    final cryptoNonce = existingNonce ?? CryptoNonce();

    if (existingIdToken == null) {
      try {
        appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: cryptoNonce.nonce,
        );
      } on SignInWithAppleException catch (_) {
        // TODO: find out network error code
        return const Left(AuthFailure.unknown());
      } catch (_) {
        return const Left(AuthFailure.unknown());
      }
    }

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: existingIdToken ?? appleCredential?.identityToken,
      rawNonce: cryptoNonce.rawNonce,
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

  Future<AuthorizationCredentialAppleID?> getAppleCredential([CryptoNonce? existingNonce]) async {
    final cryptoNonce = existingNonce ?? CryptoNonce();

    AuthorizationCredentialAppleID? appleCredential;
    try {
      appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: cryptoNonce.nonce,
      );
    } catch (o) {
      debugPrint(o.toString());
    }
    return appleCredential;
  }

  Future<void> signOut() async {
    _clearUserToken();
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<String?> refreshUserToken() async {
    final token = await _auth.currentUser?.getIdToken();
    if (token != null) {
      _api.dio.options.headers['Authorization'] = 'Bearer $token';
    }
    return token;
  }

  void _clearUserToken() => _api.dio.options.headers.remove('Authorization');

  Future<void> switchApi(String newUrl) async {
    _api.dio.options.baseUrl = newUrl;
  }
}
