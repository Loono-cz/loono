// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono_api/loono_api.dart';

part 'examination_types.freezed.dart';

extension ExaminationTypeExt on ExaminationType {
  int get awardPoints {
    switch (this) {
      case ExaminationType.GENERAL_PRACTITIONER:
      case ExaminationType.GYNECOLOGY_AND_OBSTETRICS:
      case ExaminationType.DERMATOLOGIST:
        return 200;
      case ExaminationType.DENTIST:
      case ExaminationType.UROLOGIST:
        return 300;
      case ExaminationType.COLONOSCOPY:
        return 1000;
      case ExaminationType.MAMMOGRAM:
        return 500;
      case ExaminationType.OPHTHALMOLOGIST:
      case ExaminationType.ULTRASOUND_BREAST:
        return 100;

      case ExaminationType.ALLERGOLOGY:

      case ExaminationType.CARDIOLOGY:

      case ExaminationType.ENDOCRINOLOGY_AND_HORMONES:

      case ExaminationType.GASTROENTEROLOGY:

      case ExaminationType.GENETICS:

      case ExaminationType.HEMATOLOGY:

      case ExaminationType.IMMUNOLOGY:

      case ExaminationType.INTERN:

      case ExaminationType.NEPHROLOGY:

      case ExaminationType.NEUROLOGY:

      case ExaminationType.NUTRITION:

      case ExaminationType.OCULAR:

      case ExaminationType.ONCOLOGY:

      case ExaminationType.ORL:

      case ExaminationType.ORTHODONTICS:

      case ExaminationType.ORTHOPEDICS:

      case ExaminationType.OTHER:

      case ExaminationType.PALLIATIVE_MEDICINE:

      case ExaminationType.PEDIATRICIAN:

      case ExaminationType.PHONIATRICS:

      case ExaminationType.PHYSIOTHERAPY:

      case ExaminationType.PSYCHIATRY:

      case ExaminationType.PSYCHOLOGY:

      case ExaminationType.PULMONARY:

      case ExaminationType.REHABILITATION:

      case ExaminationType.REPRODUCTIVE_MEDICINE:

      case ExaminationType.RHEUMATOLOGY:

      case ExaminationType.SEXOLOGY:

      case ExaminationType.SPEECH_THERAPIST:

      case ExaminationType.SPORTS_MEDICINE:

      case ExaminationType.SURGERY:

      case ExaminationType.TANNER:

      case ExaminationType.UROLOGY:

      case ExaminationType.VASCULAR:

      case ExaminationType.dENTALHYGIENE:
        return 0;
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
      case ExaminationType.GYNECOLOGY_AND_OBSTETRICS:
        examinationTypeUnion = const ExaminationTypeUnion.gynecologist();
        break;
      case ExaminationType.MAMMOGRAM:
        examinationTypeUnion = const ExaminationTypeUnion.mammogram();
        break;
      case ExaminationType.ERGOTHERAPY:
        examinationTypeUnion = const ExaminationTypeUnion.ergotherapy();
        break;
      case ExaminationType.OCULAR:
      case ExaminationType.OPHTHALMOLOGIST:
        examinationTypeUnion = const ExaminationTypeUnion.ophthalmologist();
        break;
      case ExaminationType.ULTRASOUND_BREAST:
        examinationTypeUnion = const ExaminationTypeUnion.ultrasoundBreast();
        break;
      case ExaminationType.UROLOGIST:
        examinationTypeUnion = const ExaminationTypeUnion.urologist();
        break;
      case ExaminationType.ALLERGOLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.allergology();
        break;
      case ExaminationType.CARDIOLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.cardiology();
        break;
      case ExaminationType.ENDOCRINOLOGY_AND_HORMONES:
        examinationTypeUnion = const ExaminationTypeUnion.endocrinologyandhormones();
        break;
      case ExaminationType.GASTROENTEROLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.gastroenterology();
        break;
      case ExaminationType.GENETICS:
        examinationTypeUnion = const ExaminationTypeUnion.genetics();
        break;
      case ExaminationType.HEMATOLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.hematology();
        break;
      case ExaminationType.IMMUNOLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.immunology();
        break;
      case ExaminationType.INTERN:
        examinationTypeUnion = const ExaminationTypeUnion.intern();
        break;
      case ExaminationType.NEPHROLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.nephrology();
        break;
      case ExaminationType.NEUROLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.neurology();
        break;
      case ExaminationType.NUTRITION:
        examinationTypeUnion = const ExaminationTypeUnion.nutrition();
        break;
      case ExaminationType.ONCOLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.oncology();
        break;
      case ExaminationType.ORL:
        examinationTypeUnion = const ExaminationTypeUnion.orl();
        break;
      case ExaminationType.ORTHODONTICS:
        examinationTypeUnion = const ExaminationTypeUnion.orthodontics();
        break;
      case ExaminationType.ORTHOPEDICS:
        examinationTypeUnion = const ExaminationTypeUnion.orthopedics();
        break;
      case ExaminationType.OTHER:
        examinationTypeUnion = const ExaminationTypeUnion.other();
        break;
      case ExaminationType.PALLIATIVE_MEDICINE:
        examinationTypeUnion = const ExaminationTypeUnion.pallativemedicine();
        break;
      case ExaminationType.PEDIATRICIAN:
        examinationTypeUnion = const ExaminationTypeUnion.pediatrician();
        break;
      case ExaminationType.PHONIATRICS:
        examinationTypeUnion = const ExaminationTypeUnion.phoniatrics();
        break;
      case ExaminationType.PHYSIOTHERAPY:
        examinationTypeUnion = const ExaminationTypeUnion.physiotherapy();
        break;
      case ExaminationType.PSYCHIATRY:
        examinationTypeUnion = const ExaminationTypeUnion.psychiatry();
        break;
      case ExaminationType.PSYCHOLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.psychology();
        break;
      case ExaminationType.PULMONARY:
        examinationTypeUnion = const ExaminationTypeUnion.pulmonary();
        break;
      case ExaminationType.REHABILITATION:
        examinationTypeUnion = const ExaminationTypeUnion.rehabilitation();
        break;
      case ExaminationType.REPRODUCTIVE_MEDICINE:
        examinationTypeUnion = const ExaminationTypeUnion.reproductivemedicine();
        break;
      case ExaminationType.RHEUMATOLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.rheumatology();
        break;
      case ExaminationType.SEXOLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.sexology();
        break;
      case ExaminationType.SPEECH_THERAPIST:
        examinationTypeUnion = const ExaminationTypeUnion.speechtherapist();
        break;
      case ExaminationType.SPORTS_MEDICINE:
        examinationTypeUnion = const ExaminationTypeUnion.sportmedicine();
        break;
      case ExaminationType.SURGERY:
        examinationTypeUnion = const ExaminationTypeUnion.surgey();
        break;
      case ExaminationType.TANNER:
        examinationTypeUnion = const ExaminationTypeUnion.tanner();
        break;
      case ExaminationType.UROLOGY:
        examinationTypeUnion = const ExaminationTypeUnion.urlogy();
        break;
      case ExaminationType.VASCULAR:
        examinationTypeUnion = const ExaminationTypeUnion.vascular();
        break;
      case ExaminationType.dENTALHYGIENE:
        examinationTypeUnion = const ExaminationTypeUnion.dentalhygiene();
        break;
    }
    return examinationTypeUnion;
  }

  // ignore: non_constant_identifier_names
  String get l10n_name => mapToUnion.when(
        colonoscopy: () => 'Kolonoskopie',
        ergotherapy: () => 'Ergoterapie',
        dentist: () => 'Zubař',
        dermatologist: () => 'Kožař',
        generalPractitioner: () => 'Praktický lékař',
        mammogram: () => 'Mamograf',
        gynecologist: () => 'Gynekolog',
        ophthalmologist: () => 'Očař',
        ultrasoundBreast: () => 'Ultrazvuk prsu',
        urologist: () => 'Urolog',
        allergology: () => 'Alergologie',
        cardiology: () => 'Kardiologie',
        dentalhygiene: () => 'Dentální hygiena',
        endocrinologyandhormones: () => 'Endokrinologie, hormony',
        gastroenterology: () => 'Gastroenterologie, Koloskopie',
        genetics: () => 'Genetika',
        hematology: () => 'Hematologie, krevní',
        immunology: () => 'Imunologie',
        intern: () => 'Interna, vnitřní lékařství',
        nephrology: () => 'Nefrologie, ledviny',
        neurology: () => 'Neurologie',
        nutrition: () => 'Výživa',
        oncology: () => 'Onkologie',
        orl: () => 'ORL',
        orthodontics: () => 'Ortodoncie, rovnátka',
        orthopedics: () => 'Ortopedie',
        other: () => 'Ostatní',
        pallativemedicine: () => 'Paliativní medicína',
        pediatrician: () => 'Dětský lékař',
        phoniatrics: () => 'Foniatrie',
        physiotherapy: () => 'Fyzioterapie',
        psychiatry: () => 'Psychiatrie',
        psychology: () => 'Psychologie',
        pulmonary: () => 'Plicní',
        rehabilitation: () => 'Rehabilitace',
        reproductivemedicine: () => 'Reprodukční medicína',
        rheumatology: () => 'Revmatologie',
        sexology: () => 'Sexuologie',
        speechtherapist: () => 'Logoped',
        sportmedicine: () => 'Sportovní medicína',
        surgey: () => 'Chirurgie',
        tanner: () => 'Kožař',
        urlogy: () => 'Urologie',
        vascular: () => 'Cévní',
      );


  String getName(BuildContext? context){
    if(context == null){
      return l10n_name;
    }
    final l10n = context.l10n;
    return mapToUnion.when(
      colonoscopy: () => l10n.colonoscopy_nomativ,
      ergotherapy: () => l10n.ergotherapy_nomativ,
      dentist: () => l10n.dentist_nomativ,
      dermatologist: () => l10n.dermatologist_nomativ,
      generalPractitioner: () => l10n.generalPractitioner_nomativ,
      mammogram: () => l10n.mammogram_nomativ,
      gynecologist: () => l10n.gynecologist_nomativ,
      ophthalmologist: () => l10n.ophthalmologist_nomativ,
      ultrasoundBreast: () => l10n.ultrasoundBreast_nomativ,
      urologist: () => l10n.urologist_nomativ,
      allergology: () => l10n.allergology_nomativ,
      cardiology: () => l10n.cardiology_nomativ,
      dentalhygiene: () => l10n.dental_hygiene_nomativ,
      endocrinologyandhormones: () => l10n.endocrinology_and_hormones_nomativ,
      gastroenterology: () => l10n.gastroenterology_nomativ,
      genetics: () => l10n.genetics_nomativ,
      hematology: () => l10n.hematology_nomativ,
      immunology: () => l10n.immunology_nomativ,
      intern: () => l10n.intern_nomativ,
      nephrology: () => l10n.nephrology_nomativ,
      neurology: () => l10n.neurology_nomativ,
      nutrition: () => l10n.nutrition_nomativ,
      oncology: () => l10n.oncology_nomativ,
      orl: () => l10n.orl_nomativ,
      orthodontics: () => l10n.orthodontics_nomativ,
      orthopedics: () => l10n.orthopaedics_nomativ,
      other: () => l10n.other_nomativ,
      pallativemedicine: () => l10n.palliative_medicine_nomativ,
      pediatrician: () => l10n.pediatrician_nomativ,
      phoniatrics: () => l10n.phoniatrics_nomativ,
      physiotherapy: () => l10n.physiotherapy_nomativ,
      psychiatry: () => l10n.psychiatry_nomativ,
      psychology: () => l10n.psychology_nomativ,
      pulmonary: () => l10n.pulmonary_nomativ,
      rehabilitation: () => l10n.rehabilitation_nomativ,
      reproductivemedicine: () => l10n.reproductive_medicine_nomativ,
      rheumatology: () => l10n.rheumatology_nomativ,
      sexology: () => l10n.sexology_nomativ,
      speechtherapist: () => l10n.speech_therapist_nomativ,
      sportmedicine: () => l10n.sports_medicine_nomativ,
      surgey: () => l10n.surgery_nomativ,
      tanner: () => l10n.tanner_nomativ,
      urlogy: () => l10n.urology_nomativ,
      vascular: () => l10n.vascular_nomativ,
    );
  }


  String get assetPath {
    const basePath = 'assets/icons/prevention/doctors/';
    final doctor = mapToUnion.toString().split('.').last.replaceFirst('()', '.svg');
    return '$basePath$doctor';
  }

  String get customExamAssetPath => 'assets/icons/prevention/doctors/universal_specialist.svg';
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
      case SelfExaminationType.SKIN:
        selfExaminationTypeUnion = const SelfExaminationTypeUnion.skin();
        break;
    }
    return selfExaminationTypeUnion;
  }

  // ignore: non_constant_identifier_names
  String get l10n_name => mapToUnion.when(
        breast: () => 'Samovyšetření prsu',
        testicular: () => 'Samovyšetření varlat',
        skin: () => 'Samovyšetření kůže',
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

  const factory ExaminationTypeUnion.ultrasoundBreast() = UltrasoundBreastExaminationTypeUnion;

  const factory ExaminationTypeUnion.urologist() = UrologistExaminationTypeUnion;

  const factory ExaminationTypeUnion.allergology() = AlergollogyExamTypeUnion;
  const factory ExaminationTypeUnion.cardiology() = CardiologyExamTypeUnion;
  const factory ExaminationTypeUnion.endocrinologyandhormones() =
      EndocrinologyAndHormonesExamTypeUnion;
  const factory ExaminationTypeUnion.gastroenterology() = GastroenterologyExamTypeUnion;
  const factory ExaminationTypeUnion.genetics() = GeneticsExamTypeUnion;
  const factory ExaminationTypeUnion.hematology() = HematologyExamTypeUnion;
  const factory ExaminationTypeUnion.immunology() = ImmunologyExamTypeUnion;
  const factory ExaminationTypeUnion.intern() = InternExamTypeUnion;
  const factory ExaminationTypeUnion.nephrology() = NephrologyTypeUnion;

  const factory ExaminationTypeUnion.neurology() = NeurologyExamTypeUnion;
  const factory ExaminationTypeUnion.nutrition() = NutritionExamTypeUnion;
  const factory ExaminationTypeUnion.oncology() = OncologyExamTypeUnion;
  const factory ExaminationTypeUnion.orl() = OrlExamTypeUnion;
  const factory ExaminationTypeUnion.orthodontics() = OrthodonticsExamTypeUnion;
  const factory ExaminationTypeUnion.orthopedics() = OrthopedicsExamTypeUnion;
  const factory ExaminationTypeUnion.other() = OtherExamTypeUnion;

  const factory ExaminationTypeUnion.pallativemedicine() = PallativemedicineExamTypeUnion;
  const factory ExaminationTypeUnion.pediatrician() = PediatricianExamTypeUnion;
  const factory ExaminationTypeUnion.phoniatrics() = PhoniatricsExamTypeUnion;
  const factory ExaminationTypeUnion.physiotherapy() = PhysiotherapyExamTypeUnion;
  const factory ExaminationTypeUnion.psychiatry() = PsychiatryExamTypeUnion;
  const factory ExaminationTypeUnion.psychology() = PsychologyExamTypeUnion;
  const factory ExaminationTypeUnion.pulmonary() = PumonaryExamTypeUnion;
  const factory ExaminationTypeUnion.rehabilitation() = RegabilitationExamTypeUnion;
  const factory ExaminationTypeUnion.reproductivemedicine() = ProductiveMedicineExamTypeUnion;
  const factory ExaminationTypeUnion.rheumatology() = RheumatologyExamTypeUnion;

  const factory ExaminationTypeUnion.sexology() = SexologyExamTypeUnion;
  const factory ExaminationTypeUnion.speechtherapist() = SpeechTherapistExamTypeUnion;
  const factory ExaminationTypeUnion.sportmedicine() = SportMedicineExamTypeUnion;
  const factory ExaminationTypeUnion.surgey() = SurgeyExamTypeUnion;
  const factory ExaminationTypeUnion.tanner() = TannerExamTypeUnion;
  const factory ExaminationTypeUnion.urlogy() = UrlogoyExamTypeUnion;
  const factory ExaminationTypeUnion.vascular() = VascularExamTypeUnion;
  const factory ExaminationTypeUnion.dentalhygiene() = DentalhygieneExamTypeUnion;
  const factory ExaminationTypeUnion.ergotherapy() = ErgotherapyTypeUnion;
}

@freezed
class SelfExaminationTypeUnion with _$SelfExaminationTypeUnion {
  const SelfExaminationTypeUnion._();

  const factory SelfExaminationTypeUnion.breast() = BrestSelfExaminationTypeUnion;

  const factory SelfExaminationTypeUnion.testicular() = TesticularSelfExaminationTypeUnion;

  const factory SelfExaminationTypeUnion.skin() = SkinSelfExaminationTypeUnion;
}
