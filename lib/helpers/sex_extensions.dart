import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono_api/loono_api.dart';

extension SexLabelsExt on Sex {
  String getBirthdateLabel(BuildContext context) {
    late final String label;
    switch (this) {
      case Sex.MALE:
        label = context.l10n.birthdate_male_header;
        break;
      case Sex.FEMALE:
        label = context.l10n.birthdate_female_header;
        break;
    }
    return label;
  }

  String getUniversalDoctorLabel(BuildContext context) {
    late final String label;
    switch (this) {
      case Sex.MALE:
        label = context.l10n.universal_doctor_male_question;
        break;
      case Sex.FEMALE:
        label = context.l10n.universal_doctor_female_question;
        break;
    }
    return label;
  }

  String getNicknameHintLabel(BuildContext context) {
    switch (this) {
      case Sex.MALE:
        return 'Adam';
      case Sex.FEMALE:
        return 'Ema';
    }
  }
}

extension SexProgressDotsExt on Sex {
  int get totalNumOfSteps {
    late final int step;
    switch (this) {
      case Sex.MALE:
        step = 2;
        break;
      case Sex.FEMALE:
        step = 3;
        break;
    }
    return step;
  }

  int get generalPractitionerStep {
    late final int step;
    switch (this) {
      case Sex.MALE:
        step = 1;
        break;
      case Sex.FEMALE:
        step = 1;
        break;
    }
    return step;
  }

  int get gynecologyStep {
    late final int step;
    switch (this) {
      case Sex.MALE:
        step = 2;
        break;
      case Sex.FEMALE:
        step = 2;
        break;
    }
    return step;
  }

  int get dentistStep {
    late final int step;
    switch (this) {
      case Sex.MALE:
        step = 2;
        break;
      case Sex.FEMALE:
        step = 3;
        break;
    }
    return step;
  }
}
