// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:loono_api/loono_api.dart';

import '../../../test_helpers/dart_objects_gens.dart';

final defaultMaleAccount = createAccountObject(
  uid: 'uUzgkYpV9zg5msVszcZ0cD8z3oi1',
  nickname: 'Adam',
  preferredEmail: 'test@loono.cz',
  sex: Sex.MALE,
  birthdate: Date(1985, 1, 22),
  points: 500,
  badges: [
    createBadgeObject(type: BadgeType.COAT, level: 1),
    createBadgeObject(type: BadgeType.HEADBAND, level: 1),
  ],
);

final defaultFemaleAccount = createAccountObject(
  uid: 'uUzgkYpV9zg5msVszcZ0cD8z3oi1',
  nickname: 'Ema',
  preferredEmail: 'test@loono.cz',
  sex: Sex.FEMALE,
  birthdate: Date(1985, 1, 22),
  points: 500,
  badges: [
    createBadgeObject(type: BadgeType.BELT, level: 1),
    createBadgeObject(type: BadgeType.HEADBAND, level: 1),
  ],
);

/// * He's performing his first self examination
final defaultMaleExaminations = createExaminationsObject(
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
      uuid: null,
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
      uuid: null,
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

/// * She's performing her first self examination
final defaultFemaleExaminations = createExaminationsObject(
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
      uuid: 'd4fa99fe-87b2-467a-a5e9-c04808868f2c',
      examinationType: ExaminationType.GYNECOLOGY_AND_OBSTETRICS,
      intervalYears: 1,
      firstExam: true,
      priority: 3,
      state: ExaminationStatus.UNKNOWN,
      count: 1,
      points: 200,
      badge: BadgeType.BELT,
      plannedDate: DateTime.now().subtract(const Duration(days: 10)).toUtc(),
      lastConfirmedDate: DateTime.now().subtract(const Duration(days: 10)).toUtc(),
    ),
    createExaminationPreventionObject(
      uuid: null,
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
      uuid: null,
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
      uuid: null,
      examinationType: ExaminationType.ULTRASOUND_BREAST,
      intervalYears: 2,
      firstExam: false,
      priority: 7,
      state: ExaminationStatus.NEW,
      count: 0,
      points: 100,
      badge: BadgeType.TOP,
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
      type: SelfExaminationType.BREAST,
      history: [],
      points: 50,
      badge: BadgeType.SHIELD,
      lastExamUuid: null,
      plannedDate: null,
    ),
  ],
);

/// Gets single encoded instance of [SimpleHealthcareProvider] object to silence the [DioError]
/// errors during integration tests which does not test 'Find doctor' section.
final Uint8List ENCODED_SINGLE_HEALTHCARE_PROVIDER = getEncodedProviders(
  providers: [
    createSimpleHealthcareProviderObject(
      locationId: 1,
      institutionId: 1,
      title: 'title',
      city: 'city',
      postalCode: '1234',
      lat: 0.005,
      lng: 0.002,
    ),
  ],
);
