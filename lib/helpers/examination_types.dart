// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'examination_types.freezed.dart';

const onboardingExaminations = <ExaminationType>[
  ExaminationType.GENERAL_PRACTITIONER,
  ExaminationType.GYNECOLOGIST,
  ExaminationType.DENTIST,
  ExaminationType.OPHTHALMOLOGIST,
  ExaminationType.DERMATOLOGIST,
];

enum ExaminationType {
  BREAST_SELF,
  COLONOSCOPY,
  DENTIST,
  DERMATOLOGIST,
  GENERAL_PRACTITIONER,
  GYNECOLOGIST,
  MAMMOGRAM,
  OPHTHALMOLOGIST,
  TESTICULAR_SELF,
  TOKS,
  ULTRASOUND_BREAST,
  UROLOGIST,
}

// TODO: localization
extension ExaminationTypesExt on ExaminationType {
  int get awardPoints {
    switch (this) {
      case ExaminationType.GENERAL_PRACTITIONER:
      case ExaminationType.GYNECOLOGIST:
        return 200;
      case ExaminationType.DENTIST:
        return 300;
      // TODO: Add the rest of ExaminationTypes
      default:
        return 0;
    }
  }

  ExaminationTypeUnion get mapToUnion {
    switch (this) {
      case ExaminationType.BREAST_SELF:
        return const ExaminationTypeUnion.breastSelf();
      case ExaminationType.COLONOSCOPY:
        return const ExaminationTypeUnion.colonoscopy();
      case ExaminationType.DENTIST:
        return const ExaminationTypeUnion.dentist();
      case ExaminationType.DERMATOLOGIST:
        return const ExaminationTypeUnion.dermatologist();
      case ExaminationType.GENERAL_PRACTITIONER:
        return const ExaminationTypeUnion.generalPractitioner();
      case ExaminationType.GYNECOLOGIST:
        return const ExaminationTypeUnion.gynecologist();
      case ExaminationType.MAMMOGRAM:
        return const ExaminationTypeUnion.mammogram();
      case ExaminationType.OPHTHALMOLOGIST:
        return const ExaminationTypeUnion.ophthalmologist();
      case ExaminationType.TESTICULAR_SELF:
        return const ExaminationTypeUnion.testicularSelf();
      case ExaminationType.TOKS:
        return const ExaminationTypeUnion.toks();
      case ExaminationType.ULTRASOUND_BREAST:
        return const ExaminationTypeUnion.ultrasoundBreast();
      case ExaminationType.UROLOGIST:
        return const ExaminationTypeUnion.urologist();
    }
  }

  String get name => mapToUnion.when(
        breastSelf: () => 'Samovyšetření prsa',
        colonoscopy: () => 'Koloskopie',
        dentist: () => 'Zubař',
        dermatologist: () => 'Dermatolog',
        generalPractitioner: () => 'Praktický lékař',
        mammogram: () => 'Mamograf',
        gynecologist: () => 'Gynekolog',
        ophthalmologist: () => 'Oční',
        testicularSelf: () => 'Samovyšetření varlata',
        toks: () => 'Toks',
        ultrasoundBreast: () => 'Ultrazvuk prsu',
        urologist: () => 'Urolog',
      );

  String get assetName {
    const basePath = 'assets/icons/prevention/doctors/';
    final doctor = mapToUnion.toString().split('.').last.replaceFirst('()', '.svg');
    return '$basePath$doctor';
  }
}

@freezed
class ExaminationTypeUnion with _$ExaminationTypeUnion {
  const ExaminationTypeUnion._();

  const factory ExaminationTypeUnion.breastSelf() = BreastSelfExaminationTypeUnion;

  const factory ExaminationTypeUnion.colonoscopy() = ColonoscopyExaminationTypeUnion;

  const factory ExaminationTypeUnion.dentist() = DentistExaminationTypeUnion;

  const factory ExaminationTypeUnion.dermatologist() = DermatologistExaminationTypeUnion;

  const factory ExaminationTypeUnion.generalPractitioner() =
      GeneralPractitionerExaminationTypeUnion;

  const factory ExaminationTypeUnion.mammogram() = MammogramExaminationTypeUnion;

  const factory ExaminationTypeUnion.gynecologist() = GynecologistExaminationTypeUnion;

  const factory ExaminationTypeUnion.ophthalmologist() = OphthalmologistExaminationTypeUnion;

  const factory ExaminationTypeUnion.testicularSelf() = TesticularSelfExaminationTypeUnion;

  const factory ExaminationTypeUnion.toks() = ToksExaminationTypeUnion;

  const factory ExaminationTypeUnion.ultrasoundBreast() = UltrasoundBreastExaminationTypeUnion;

  const factory ExaminationTypeUnion.urologist() = UrologistExaminationTypeUnion;
}
