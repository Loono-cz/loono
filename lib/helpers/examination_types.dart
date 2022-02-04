// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono_api/loono_api.dart';

part 'examination_types.freezed.dart';

extension ExaminationTypeEnumExt on ExaminationTypeEnum {
  int get awardPoints {
    switch (this) {
      case ExaminationTypeEnum.GENERAL_PRACTITIONER:
      case ExaminationTypeEnum.GYNECOLOGIST:
        return 200;
      case ExaminationTypeEnum.DENTIST:
        return 300;
      // TODO: Add the rest of ExaminationTypes
      default:
        return 0;
    }
  }

  ExaminationTypeUnion get mapToUnion {
    late final ExaminationTypeUnion examinationTypeUnion;
    switch (this) {
      case ExaminationTypeEnum.BREAST_SELF:
        examinationTypeUnion = const ExaminationTypeUnion.breastSelf();
        break;
      case ExaminationTypeEnum.COLONOSCOPY:
        examinationTypeUnion = const ExaminationTypeUnion.colonoscopy();
        break;
      case ExaminationTypeEnum.DENTIST:
        examinationTypeUnion = const ExaminationTypeUnion.dentist();
        break;
      case ExaminationTypeEnum.DERMATOLOGIST:
        examinationTypeUnion = const ExaminationTypeUnion.dermatologist();
        break;
      case ExaminationTypeEnum.GENERAL_PRACTITIONER:
        examinationTypeUnion = const ExaminationTypeUnion.generalPractitioner();
        break;
      case ExaminationTypeEnum.GYNECOLOGIST:
        examinationTypeUnion = const ExaminationTypeUnion.gynecologist();
        break;
      case ExaminationTypeEnum.MAMMOGRAM:
        examinationTypeUnion = const ExaminationTypeUnion.mammogram();
        break;
      case ExaminationTypeEnum.OPHTHALMOLOGIST:
        examinationTypeUnion = const ExaminationTypeUnion.ophthalmologist();
        break;
      case ExaminationTypeEnum.TESTICULAR_SELF:
        examinationTypeUnion = const ExaminationTypeUnion.testicularSelf();
        break;
      case ExaminationTypeEnum.TOKS:
        examinationTypeUnion = const ExaminationTypeUnion.toks();
        break;
      case ExaminationTypeEnum.ULTRASOUND_BREAST:
        examinationTypeUnion = const ExaminationTypeUnion.ultrasoundBreast();
        break;
      case ExaminationTypeEnum.UROLOGIST:
        examinationTypeUnion = const ExaminationTypeUnion.urologist();
        break;
      case ExaminationTypeEnum.VENEREAL_DISEASES:
        examinationTypeUnion = const ExaminationTypeUnion.venerealDiseases();
        break;
    }
    return examinationTypeUnion;
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
        venerealDiseases: () => 'Pohlavní choroby',
      );

  String get assetPath {
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

  const factory ExaminationTypeUnion.venerealDiseases() = VenerealDiseasesExaminationTypeUnion;
}
