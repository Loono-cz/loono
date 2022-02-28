import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';

enum SocialLoginMethod { apple, google }

extension SocialLoginMethodExt on SocialLoginMethod {
  String getButtonText(BuildContext context) {
    switch (this) {
      case SocialLoginMethod.apple:
        return context.l10n.sign_in_with_apple;
      case SocialLoginMethod.google:
        return context.l10n.sign_in_with_google_account;
    }
  }
}
