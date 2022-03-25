import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loono/helpers/social_login_helpers.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/utils/crypto_utils.dart';
import 'package:loono/utils/registry.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLoginAccount {
  const SocialLoginAccount.apple(AuthorizationCredentialAppleID appleID, CryptoNonce cryptoNonce)
      : _socialLoginMethod = SocialLoginMethod.apple,
        _googleUser = null,
        _cryptoNonce = cryptoNonce,
        _appleID = appleID;

  const SocialLoginAccount.google(GoogleSignInAccount googleUser)
      : _socialLoginMethod = SocialLoginMethod.google,
        _appleID = null,
        _cryptoNonce = null,
        _googleUser = googleUser;

  final SocialLoginMethod _socialLoginMethod;
  final GoogleSignInAccount? _googleUser;
  final AuthorizationCredentialAppleID? _appleID;
  final CryptoNonce? _cryptoNonce;

  String? get email {
    switch (_socialLoginMethod) {
      case SocialLoginMethod.apple:
        return _appleID?.email;
      case SocialLoginMethod.google:
        return _googleUser?.email;
    }
  }

  String? get nickname {
    switch (_socialLoginMethod) {
      case SocialLoginMethod.apple:
        return _appleID?.givenName;
      case SocialLoginMethod.google:
        return _googleUser?.displayName?.split(' ').firstOrNull;
    }
  }

  Future<Either<AuthFailure, AuthUser>> createAccount() async {
    final authService = registry.get<AuthService>();
    switch (_socialLoginMethod) {
      case SocialLoginMethod.apple:
        return authService.signInWithApple(_appleID?.identityToken, _cryptoNonce);
      case SocialLoginMethod.google:
        return authService.signInWithGoogle(_googleUser);
    }
  }
}
