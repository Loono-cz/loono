import 'package:built_collection/built_collection.dart';
import 'package:loono_api/loono_api.dart';

/// To create test data, we're using dart objects instead of plain JSON data, so when something
/// on API changes, it is much easier to maintain these data.

Account createAccountObject({
  String uid = '123abcdabcd',
  String nickname = 'Adam Novák',
  String preferredEmail = 'test@loono.cz',
  Sex sex = Sex.MALE,
  Date? birthdate,
  String? profileImageUrl,
  bool leaderboardAnonymizationOptIn = true,
  bool appointmentReminderEmailsOptIn = true,
  bool newsletterOptIn = false,
  int points = 0,
  List<Badge> badges = const <Badge>[],
}) {
  return Account((b) {
    b
      ..uid = uid
      ..nickname = nickname
      ..preferredEmail = preferredEmail
      ..sex = sex
      ..birthdate = birthdate ?? Date(2000, 5, 20)
      ..profileImageUrl = profileImageUrl
      ..leaderboardAnonymizationOptIn = leaderboardAnonymizationOptIn
      ..appointmentReminderEmailsOptIn = appointmentReminderEmailsOptIn
      ..newsletterOptIn = newsletterOptIn
      ..points = points
      ..badges = BuiltList.of(badges).toBuilder();
  });
}

AccountOnboarding createAccountOnboardingObject({
  String nickname = 'Adam Novák',
  String preferredEmail = 'test@loono.cz',
  Sex sex = Sex.MALE,
  Date? birthdate,
  List<ExaminationRecord> examinations = const <ExaminationRecord>[],
}) {
  return AccountOnboarding((b) {
    b
      ..nickname = nickname
      ..preferredEmail = preferredEmail
      ..sex = sex
      ..birthdate = birthdate ?? Date(2000, 5, 20)
      ..examinations = BuiltList.of(examinations).toBuilder();
  });
}

Badge createBadgeObject({
  BadgeType type = BadgeType.GLOVES,
  int level = 1,
}) {
  return Badge((b) {
    b
      ..type = type
      ..level = level;
  });
}

ExaminationRecord createExaminationRecordObject({
  String? uuid,
  ExaminationType type = ExaminationType.GENERAL_PRACTITIONER,
  DateTime? date,
  ExaminationStatus status = ExaminationStatus.UNKNOWN,
  bool? firstExam,
}) {
  return ExaminationRecord((b) {
    b
      ..uuid = uuid
      ..type = type
      ..date = date
      ..status = status
      ..firstExam = firstExam;
  });
}

PreventionStatus createExaminationsObject({
  List<ExaminationPreventionStatus> examinations = const <ExaminationPreventionStatus>[],
  List<SelfExaminationPreventionStatus> selfExaminations =
      const <SelfExaminationPreventionStatus>[],
}) {
  return PreventionStatus((b) {
    b
      ..examinations = BuiltList.of(examinations).toBuilder()
      ..selfexaminations = BuiltList.of(selfExaminations).toBuilder();
  });
}

ExaminationPreventionStatus createExaminationPreventionObject({
  String uuid = 'abcdefghijkl',
  ExaminationType examinationType = ExaminationType.GENERAL_PRACTITIONER,
  int intervalYears = 2,
  DateTime? plannedDate,
  bool firstExam = true,
  int priority = 1,
  ExaminationStatus state = ExaminationStatus.UNKNOWN,
  int count = 1,
  DateTime? lastConfirmedDate,
  int points = 100,
  BadgeType badge = BadgeType.BELT,
}) {
  return ExaminationPreventionStatus((b) {
    b
      ..uuid = uuid
      ..examinationType = examinationType
      ..intervalYears = intervalYears
      ..plannedDate = plannedDate
      ..firstExam = firstExam
      ..priority = priority
      ..state = state
      ..count = count
      ..lastConfirmedDate = lastConfirmedDate
      ..points = points
      ..badge = badge;
  });
}

SelfExaminationPreventionStatus createSelfExaminationPreventionObject({
  String? lastExamUuid,
  Date? plannedDate,
  SelfExaminationType type = SelfExaminationType.TESTICULAR,
  List<SelfExaminationStatus> history = const <SelfExaminationStatus>[],
  int points = 50,
  BadgeType badge = BadgeType.SHIELD,
}) {
  return SelfExaminationPreventionStatus((b) {
    b
      ..lastExamUuid = lastExamUuid
      ..plannedDate = plannedDate
      ..type = type
      ..history = BuiltList.of(history).toBuilder()
      ..points = points
      ..badge = badge;
  });
}

Leaderboard createLeaderboardObject({
  List<LeaderboardUser> top = const <LeaderboardUser>[],
  List<LeaderboardUser> peers = const <LeaderboardUser>[],
  int myOrder = 1,
}) {
  return Leaderboard((b) {
    b
      ..top = BuiltList.of(top).toBuilder()
      ..peers = BuiltList.of(peers).toBuilder()
      ..myOrder = myOrder;
  });
}

LeaderboardUser createLeaderboardUserObject({
  required String name,
  String? profileImageUrl,
  required int points,
  bool? isThisMe,
}) {
  return LeaderboardUser((b) {
    b
      ..name = name
      ..profileImageUrl = profileImageUrl
      ..points = points
      ..isThisMe = isThisMe;
  });
}
