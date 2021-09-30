import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';

enum Sex { male, female }

extension SexLabelsExt on Sex {
  String getBirthdateLabel(BuildContext context) {
    switch (this) {
      case Sex.male:
        return context.l10n.birthdate_male_header;
      case Sex.female:
        return context.l10n.birthdate_female_header;
    }
  }

  String getUniversalDoctorLabel(BuildContext context) {
    switch (this) {
      case Sex.male:
        return context.l10n.universal_doctor_male_question;
      case Sex.female:
        return context.l10n.universal_doctor_female_question;
    }
  }

  String getNicknameHintLabel(BuildContext context) {
    switch (this) {
      case Sex.male:
        return 'Adam';
      case Sex.female:
        return 'Ema';
    }
  }
}

extension SexProgressDotsExt on Sex {
  int get totalNumOfSteps {
    switch (this) {
      case Sex.male:
        return 2;
      case Sex.female:
        return 3;
    }
  }

  int get generalPractitionerStep {
    switch (this) {
      case Sex.male:
        return 1;
      case Sex.female:
        return 1;
    }
  }

  int get gynecologyStep {
    switch (this) {
      case Sex.male:
        return 2;
      case Sex.female:
        return 2;
    }
  }

  int get dentistStep {
    switch (this) {
      case Sex.male:
        return 2;
      case Sex.female:
        return 3;
    }
  }
}
