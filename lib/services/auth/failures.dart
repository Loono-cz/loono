import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/social_login_account.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'failures.freezed.dart';

const _appleLoginNotSupportedErrCode = '0x00';

extension AuthFailureMessageExt on AuthFailure {
  String getMessage(BuildContext context) {
    return when(
      unknown: (message, errCode) {
        if (errCode == null) return message ?? context.l10n.auth_unknown_failure_message;
        if (errCode == _appleLoginNotSupportedErrCode) {
          return context.l10n.auth_apple_not_supported_message;
        }
        return '${message ?? context.l10n.auth_unknown_failure_message} (${context.l10n.auth_error_code_message}: $errCode)';
      },
      noMessage: () => '',
      accountNotExists: (socialAccount) {
        final email = socialAccount.email;
        return '${context.l10n.auth_account_not_exists_message} ${email == null ? '' : '($email).'}';
      },
      network: (message) => message ?? context.l10n.auth_network_failure_message,
    );
  }
}

/// Let's reserve 0-99 for [SignInWithAppleException] errors.
AuthFailure authFailureFromSignInWithAppleException(SignInWithAppleException e) {
  // Thrown in case of authorization errors.
  if (e is SignInWithAppleAuthorizationException) {
    switch (e.code) {
      case AuthorizationErrorCode.canceled:
        // The user cancelled the sign in flow on purpose. Do not show error message.
        return const AuthFailure.noMessage();
      case AuthorizationErrorCode.failed:
        return const AuthFailure.unknown(null, '0x01');
      case AuthorizationErrorCode.invalidResponse:
        return const AuthFailure.unknown(null, '0x02');
      case AuthorizationErrorCode.notHandled:
        return const AuthFailure.unknown(null, '0x03');
      case AuthorizationErrorCode.notInteractive:
        return const AuthFailure.unknown(null, '0x04');
      case AuthorizationErrorCode.unknown:
        return const AuthFailure.unknown(null, '0x05');
    }
  }

  // In case Sign in with Apple is not available (e.g. iOS < 13, macOS < 10.15).
  if (e is SignInWithAppleNotSupportedException) {
    return const AuthFailure.unknown(null, _appleLoginNotSupportedErrCode);
  }

  if (e is SignInWithAppleCredentialsException) {
    return const AuthFailure.unknown(null, '0x80');
  }

  return const AuthFailure.unknown(null, '0x99');
}

/// Let's reserve 100-199 for [FirebaseAuthException] errors.
AuthFailure authFailureFromFirebaseAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'account-exists-with-different-credential':
      return const AuthFailure.unknown(null, '0x101');
    case 'invalid-credential':
      return const AuthFailure.unknown(null, '0x102');
    case 'operation-not-allowed':
      return const AuthFailure.unknown(null, '0x103');
    case 'user-disabled':
      return const AuthFailure.unknown(null, '0x104');
    case 'user-not-found':
      return const AuthFailure.unknown(null, '0x105');
    case 'wrong-password':
      return const AuthFailure.unknown(null, '0x106');
    case 'invalid-verification-code':
      return const AuthFailure.unknown(null, '0x107');
    case 'invalid-verification-id':
      return const AuthFailure.unknown(null, '0x108');
  }

  return const AuthFailure.unknown(null, '0x199');
}

@freezed
class AuthFailure with _$AuthFailure {
  const AuthFailure._();

  /// [errCode]
  /// * 0 - 99 - Apple Login related errors.
  /// * 100 - 199 - Firebase Auth related errors.
  const factory AuthFailure.unknown([String? message, String? errCode]) = UnknownFailure;

  const factory AuthFailure.noMessage() = NoMessageFailure;

  const factory AuthFailure.accountNotExists(SocialLoginAccount socialLoginAccount) =
      AccountNotExists;

  const factory AuthFailure.network([String? message]) = NetworkFailure;
}
