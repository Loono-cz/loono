import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/l10n/ext.dart';

part 'failures.freezed.dart';

extension AuthFailureMessageExt on AuthFailure {
  String getMessage(BuildContext context) {
    return when(
      unknown: (message) => message ?? context.l10n.auth_unknown_failure_message,
      noMessage: () => '',
      network: (message) => message ?? context.l10n.auth_network_failure_message,
    );
  }
}

@freezed
class AuthFailure with _$AuthFailure {
  const AuthFailure._();

  const factory AuthFailure.unknown([String? message]) = UnknownFailure;

  const factory AuthFailure.noMessage() = NoMessageFailure;

  const factory AuthFailure.network([String? message]) = NetworkFailure;
}
