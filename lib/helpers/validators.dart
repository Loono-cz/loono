// ignore_for_file: avoid_classes_with_only_static_members
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';

class Validators {
  static FormFieldValidator<String>? email(BuildContext context) {
    return (input) {
      if (input == null || !EmailValidator.validate(input)) {
        return context.l10n.email_validator_wrong_input;
      }
      if (input.length > MAX_ALLOWED_INPUT_FORM_LENGTH) {
        return context.l10n.email_validator_too_long_input;
      }
      return null;
    };
  }

  static FormFieldValidator<String>? nickname(BuildContext context) {
    return (input) {
      if (input == null || input.isEmpty) {
        return context.l10n.nickname_validator_empty_input;
      }
      if (input.length > MAX_ALLOWED_INPUT_FORM_LENGTH) {
        return context.l10n.nickname_validator_too_long_input;
      }
      return null;
    };
  }
}
