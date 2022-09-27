import 'package:flutter/cupertino.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono_api/loono_api.dart';

String getAchievementTitle(BuildContext context, ExaminationType type) {
  var result = '';
  switch (type) {
    case ExaminationType.DERMATOLOGIST:
      result = context.l10n.achievement_dermatologist_header;
      break;
    case ExaminationType.COLONOSCOPY:
      result = context.l10n.achievement_colonoscopy_header;
      break;
    case ExaminationType.DENTIST:
      result = context.l10n.achievement_headband_dentist_header;
      break;
    case ExaminationType.GENERAL_PRACTITIONER:
      result = context.l10n.achievement_coat_practitioner_header;
      break;
    case ExaminationType.GYNECOLOGY_AND_OBSTETRICS:
      result = context.l10n.achievement_belt_gynecologist_header;
      break;
    case ExaminationType.MAMMOGRAM:
      result = context.l10n.achievement_body_mammogram_header;
      break;
    case ExaminationType.OPHTHALMOLOGIST:
      result = context.l10n.achievement_ophthalmologist_header;
      break;
    case ExaminationType.TOKS:
      result = context.l10n.achievement_toks_header;
      break;
    case ExaminationType.ULTRASOUND_BREAST:
      // TODO: Handle this case.
      break;
    case ExaminationType.UROLOGIST:
      result = context.l10n.achievement_belt_urologist_header;
      break;
    case ExaminationType.VENEREAL_DISEASES:
      // TODO: Handle this case.
      break;
  }

  return result;
}

String getAchievementAssetPath(ExaminationType type) {
  var name = '';
  const path = 'assets/badges/achievement/';
  switch (type) {
    case ExaminationType.COLONOSCOPY:
      name = 'boots_level_1.svg';
      break;
    case ExaminationType.DENTIST:
      name = 'headband_level_1.svg';
      break;
    case ExaminationType.DERMATOLOGIST:
      name = 'gloves_level_1.svg';
      break;
    case ExaminationType.GENERAL_PRACTITIONER:
      name = 'cloak_level_1.svg';
      break;
    case ExaminationType.GYNECOLOGY_AND_OBSTETRICS:
      name = 'belt_level_1.svg';
      break;
    case ExaminationType.MAMMOGRAM:
      name = 'armour_level_1.svg';
      break;
    case ExaminationType.OPHTHALMOLOGIST:
      name = 'goggles_level_1.svg';
      break;
    case ExaminationType.TOKS:
      name = 'boots_level_1.svg';
      break;
    case ExaminationType.ULTRASOUND_BREAST:
      name = 'armour_level_1.svg';
      break;
    case ExaminationType.UROLOGIST:
      name = 'belt_level_1.svg';
      break;
    case ExaminationType.VENEREAL_DISEASES:
      // TODO: Handle this case.
      break;
  }
  return path + name;
}
