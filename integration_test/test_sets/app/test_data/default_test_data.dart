import 'package:loono_api/loono_api.dart';

import '../../../test_helpers/dart_objects_gens.dart';

final defaultAccount = createAccountObject(
  uid: 'uUzgkYpV9zg5msVszcZ0cD8z3oi1',
  nickname: 'Adam',
  prefferedEmail: 'test@loono.cz',
  sex: Sex.MALE,
  birthdate: Date(1985, 1, 22),
  points: 500,
  badges: [
    createBadgeObject(type: BadgeType.COAT, level: 1),
    createBadgeObject(type: BadgeType.HEADBAND, level: 1),
  ],
);
final defaultExaminations = createExaminationsObject(
  examinations: [
    createExaminationPreventionObject(
      uuid: '82c74315-14b6-45aa-8767-7c21e479bd2e',
      examinationType: ExaminationType.GENERAL_PRACTITIONER,
      intervalYears: 2,
      firstExam: false,
      priority: 1,
      state: ExaminationStatus.CANCELED,
      count: 0,
      points: 200,
      badge: BadgeType.COAT,
      plannedDate: DateTime.now().add(const Duration(days: 1)).toUtc(),
      lastConfirmedDate: null,
    ),
    createExaminationPreventionObject(
      uuid: '31ad2333-cbc5-4d4d-9779-598eca4154b3',
      examinationType: ExaminationType.DERMATOLOGIST,
      intervalYears: 1,
      firstExam: true,
      priority: 6,
      state: ExaminationStatus.NEW,
      count: 0,
      points: 200,
      badge: BadgeType.GLOVES,
      plannedDate: null,
      lastConfirmedDate: null,
    ),
    createExaminationPreventionObject(
      uuid: 'c205f7c0-71e9-401c-acf5-f1a3e8cbea48',
      examinationType: ExaminationType.OPHTHALMOLOGIST,
      intervalYears: 2,
      firstExam: true,
      priority: 9,
      state: ExaminationStatus.NEW,
      count: 0,
      points: 100,
      badge: BadgeType.GLASSES,
      plannedDate: null,
      lastConfirmedDate: null,
    ),
    createExaminationPreventionObject(
      uuid: '4184e002-8be5-4c7d-a87f-4854a27fbefd',
      examinationType: ExaminationType.DENTIST,
      intervalYears: 1,
      firstExam: false,
      priority: 8,
      state: ExaminationStatus.CONFIRMED,
      count: 1,
      points: 300,
      badge: BadgeType.HEADBAND,
      plannedDate: DateTime.now().subtract(const Duration(days: 2)).toUtc(),
      lastConfirmedDate: DateTime.now().subtract(const Duration(days: 2)).toUtc(),
    ),
  ],
  selfExaminations: [
    createSelfExaminationPreventionObject(
      type: SelfExaminationType.TESTICULAR,
      history: [],
      points: 50,
      badge: BadgeType.SHIELD,
      lastExamUuid: null,
      plannedDate: null,
    ),
  ],
);
