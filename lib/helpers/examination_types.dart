// ignore_for_file: constant_identifier_names
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
  VENEREAL_DISEASES,
}

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
}
