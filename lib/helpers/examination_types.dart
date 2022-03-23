// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono_api/loono_api.dart';

part 'examination_types.freezed.dart';

extension ExaminationTypeExt on ExaminationType {
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
    late final ExaminationTypeUnion examinationTypeUnion;
    switch (this) {
      case ExaminationType.COLONOSCOPY:
        examinationTypeUnion = const ExaminationTypeUnion.colonoscopy();
        break;
      case ExaminationType.DENTIST:
        examinationTypeUnion = const ExaminationTypeUnion.dentist();
        break;
      case ExaminationType.DERMATOLOGIST:
        examinationTypeUnion = const ExaminationTypeUnion.dermatologist();
        break;
      case ExaminationType.GENERAL_PRACTITIONER:
        examinationTypeUnion = const ExaminationTypeUnion.generalPractitioner();
        break;
      case ExaminationType.GYNECOLOGIST:
        examinationTypeUnion = const ExaminationTypeUnion.gynecologist();
        break;
      case ExaminationType.MAMMOGRAM:
        examinationTypeUnion = const ExaminationTypeUnion.mammogram();
        break;
      case ExaminationType.OPHTHALMOLOGIST:
        examinationTypeUnion = const ExaminationTypeUnion.ophthalmologist();
        break;
      case ExaminationType.TOKS:
        examinationTypeUnion = const ExaminationTypeUnion.toks();
        break;
      case ExaminationType.ULTRASOUND_BREAST:
        examinationTypeUnion = const ExaminationTypeUnion.ultrasoundBreast();
        break;
      case ExaminationType.UROLOGIST:
        examinationTypeUnion = const ExaminationTypeUnion.urologist();
        break;
      case ExaminationType.VENEREAL_DISEASES:
        examinationTypeUnion = const ExaminationTypeUnion.venerealDiseases();
        break;
    }
    return examinationTypeUnion;
  }

  // ignore: non_constant_identifier_names
  String get l10n_name => mapToUnion.when(
        colonoscopy: () => 'Koloskopie',
        dentist: () => 'Zubař',
        dermatologist: () => 'Dermatolog',
        generalPractitioner: () => 'Praktický lékař',
        mammogram: () => 'Mamograf',
        gynecologist: () => 'Gynekolog',
        ophthalmologist: () => 'Oční',
        toks: () => 'Toks',
        ultrasoundBreast: () => 'Ultrazvuk prsu',
        urologist: () => 'Urolog',
        venerealDiseases: () => 'Pohlavní choroby',
      );

  String get assetPath {
    const basePath = 'assets/icons/prevention/doctors/';
    final doctor = mapToUnion.toString().split('.').last.replaceFirst('()', '.svg');
    return '$basePath$doctor';
  }
}

extension SelfExaminationTypeExt on SelfExaminationType {
  SelfExaminationTypeUnion get mapToUnion {
    late final SelfExaminationTypeUnion selfExaminationTypeUnion;
    switch (this) {
      case SelfExaminationType.BREAST:
        selfExaminationTypeUnion = const SelfExaminationTypeUnion.breast();
        break;
      case SelfExaminationType.TESTICULAR:
        selfExaminationTypeUnion = const SelfExaminationTypeUnion.testicular();
        break;
    }
    return selfExaminationTypeUnion;
  }

  // ignore: non_constant_identifier_names
  String get l10n_name => mapToUnion.when(
        breast: () => 'Samovyšetření prsu',
        testicular: () => 'Samovyšetření varlat',
      );

  String get assetPath {
    const basePath = 'assets/icons/prevention/self_examination/';
    final selfExamination = mapToUnion.toString().split('.').last.replaceFirst('()', '.svg');
    return '$basePath$selfExamination';
  }
}

@freezed
class ExaminationTypeUnion with _$ExaminationTypeUnion {
  const ExaminationTypeUnion._();

  const factory ExaminationTypeUnion.colonoscopy() = ColonoscopyExaminationTypeUnion;

  const factory ExaminationTypeUnion.dentist() = DentistExaminationTypeUnion;

  const factory ExaminationTypeUnion.dermatologist() = DermatologistExaminationTypeUnion;

  const factory ExaminationTypeUnion.generalPractitioner() =
      GeneralPractitionerExaminationTypeUnion;

  const factory ExaminationTypeUnion.mammogram() = MammogramExaminationTypeUnion;

  const factory ExaminationTypeUnion.gynecologist() = GynecologistExaminationTypeUnion;

  const factory ExaminationTypeUnion.ophthalmologist() = OphthalmologistExaminationTypeUnion;

  const factory ExaminationTypeUnion.toks() = ToksExaminationTypeUnion;

  const factory ExaminationTypeUnion.ultrasoundBreast() = UltrasoundBreastExaminationTypeUnion;

  const factory ExaminationTypeUnion.urologist() = UrologistExaminationTypeUnion;

  const factory ExaminationTypeUnion.venerealDiseases() = VenerealDiseasesExaminationTypeUnion;
}

@freezed
class SelfExaminationTypeUnion with _$SelfExaminationTypeUnion {
  const SelfExaminationTypeUnion._();

  const factory SelfExaminationTypeUnion.breast() = BrestSelfExaminationTypeUnion;

  const factory SelfExaminationTypeUnion.testicular() = TesticularSelfExaminationTypeUnion;
}
