import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loono/models/apple_account_info.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/models/social_login_account.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/services/secure_storage_service.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/crypto_utils.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart' as api;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  AuthService({
    required api.LoonoApi api,
    required SecureStorageService secureStorageService,
  })  : _api = api,
        _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn(),
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

  /// Used only in testing.
  ///
  /// A token which has not been signed from Firebase Auth yet.
  String? get _customToken => dotenv.env['CUSTOM_TOKEN'];

  bool get isInBackendIntegrationTestingMode =>
      kDebugMode && registry.get<AppConfig>().flavor == AppFlavors.dev && _customToken != null;

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
    // Apple does not expose network error: https://github.com/aboutyou/dart_packages/issues/296.
    final connectivityState = await Connectivity().checkConnectivity();
    if (connectivityState == ConnectivityResult.none) {
      return const Left(AuthFailure.network());
    }

    final cryptoNonce = CryptoNonce();
    AuthorizationCredentialAppleID? appleCredential;
    try {
      appleCredential = await getAppleCredential(cryptoNonce);
    } on SignInWithAppleException catch (e) {
      return Left(authFailureFromSignInWithAppleException(e));
    } catch (e) {
      debugPrint(e.toString());
      return const Left(AuthFailure.unknown(null, '0x90'));
    }

    if (appleCredential == null) return const Left(AuthFailure.unknown(null, '0x91'));

    final appleUserId = appleCredential.userIdentifier;
    if (appleUserId == null) return const Left(AuthFailure.unknown(null, '0x92'));

    final AppleAccountInfo appleAccountInfo;
    final decodedToken = JwtDecoder.decode(appleCredential.identityToken ?? '');
    final appleUserEmail = appleCredential.email ?? decodedToken['email'].toString();
    final savedAccountInfo = await _secureStorage.getAppleAccountInfoById(appleUserId);
    appleAccountInfo = AppleAccountInfo(
      userIdentifier: appleUserId,
      email: appleUserEmail,
      givenName: appleCredential.givenName ?? savedAccountInfo?.givenName ?? '',
      familyName: appleCredential.familyName ?? savedAccountInfo?.familyName ?? '',
      identifierToken: appleCredential.identityToken,
    );
    await _secureStorage.saveAppleAccountInfo(appleAccountInfo);
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
      } catch (_) {
        return const Left(AuthFailure.unknown(null, '0x96'));
      }
    }

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: existingIdToken ?? appleCredential?.identityToken,
      rawNonce: cryptoNonce.rawNonce,
    );

    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithCredential(oauthCredential);
    } on FirebaseAuthException catch (e) {
      return Left(authFailureFromFirebaseAuthException(e));
    } catch (_) {
      return const Left(AuthFailure.unknown(null, '0x97'));
    }
    return userCredential.user == null
        ? const Left(AuthFailure.unknown(null, '0x98'))
        : Right(_authUserFromFirebase(userCredential.user)!);
  }

  Future<AuthorizationCredentialAppleID?> getAppleCredential([CryptoNonce? existingNonce]) async {
    final cryptoNonce = existingNonce ?? CryptoNonce();
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: cryptoNonce.nonce,
    );

    return appleCredential;
  }

  /// This login method is a way to proceed through the login without needing a Google Account.
  /// Custom token can be generated only from Firebase Admin SDK and lasts for 1 hour. This token
  /// needs to be then exchanged for a signed token from Firebase Auth
  /// in order to call Backend API as valid user.
  ///
  /// Should be used only in testing.
  Future<Either<AuthFailure, AuthUser>> signInWithCustomToken() async {
    if (!isInBackendIntegrationTestingMode) {
      throw (Exception('This login method can be used only in testing'));
    }

    final customToken = _customToken;
    if (customToken == null) {
      throw (Exception('Custom token is not defined'));
    }

    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithCustomToken(customToken);
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
