// ignore_for_file: constant_identifier_names

import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/examination_status.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/models/categorized_examination.dart';

const int MONTHS_IN_YEAR = 12;
const int TO_SCHEDULE_MONTHS_TRANSFER = 2;

extension ExaminationRecordExt on ExaminationRecord {
  ExaminationStatus calculateStatus([DateTime? dateTimeNow]) {
    final now = dateTimeNow ?? DateTime.now();

    // STATUS: waiting or newToSchedule
    if (nextVisitDate == null && lastVisitDate != null) {
      final lastVisitDateWithoutDay = lastVisitDate!;
      final lastVisitDateTime =
          DateTime(lastVisitDateWithoutDay.year, lastVisitDateWithoutDay.month.index + 1);

      // if last visit date is before: CURRENT_MONTH - (INTERVAL - 2 months)
      final subtractedWaitingDate =
          DateTime(now.year, now.month - (interval * MONTHS_IN_YEAR - TO_SCHEDULE_MONTHS_TRANSFER));
      // then waiting time has ended, move to "TO BE SCHEDULED"
      if (lastVisitDateTime.isBefore(subtractedWaitingDate) ||
          lastVisitDateTime.isAtSameMomentAs(subtractedWaitingDate)) {
        return const ExaminationStatus.newToSchedule();
      }
      // else wait
      return const ExaminationStatus.waiting();
    }

    // STATUS: scheduled or scheduledSoonOrOverdue
    if (nextVisitDate != null) {
      final diffInDaysFromNow = nextVisitDate!.difference(now).inDays;
      // if it is more than 30 days before the check-up visit the status is "SCHEDULED"
      if (diffInDaysFromNow > 30) return const ExaminationStatus.scheduled();
      // else 30 days or equal before check-up visit the status is "SCHEDULED_SOON_OR_OVERDUE"
      return const ExaminationStatus.scheduledSoonOrOverdue();
    }

    // else fallback to STATUS: unknownLastVisit
    return const ExaminationStatus.unknownLastVisit();
  }
}

extension CategorizedExaminationListExt on List<CategorizedExamination> {
  void sortExaminations() {
    if (isEmpty) return;
    first.status.when(
      scheduledSoonOrOverdue: () =>
          sort((a, b) => b.examination.nextVisitDate!.compareTo(a.examination.nextVisitDate!)),
      newToSchedule: () => sort((a, b) {
        final lastVisitDateWithoutDayA = a.examination.lastVisitDate!;
        final lastVisitDateWithoutDayB = b.examination.lastVisitDate!;
        final lastVisitDateTimeA =
            DateTime(lastVisitDateWithoutDayA.year, lastVisitDateWithoutDayA.month.index + 1);
        final lastVisitDateTimeB =
            DateTime(lastVisitDateWithoutDayB.year, lastVisitDateWithoutDayB.month.index + 1);
        return lastVisitDateTimeA.compareTo(lastVisitDateTimeB);
      }),
      unknownLastVisit: () =>
          sort((a, b) => a.examination.priority.compareTo(b.examination.priority)),
      scheduled: () =>
          sort((a, b) => a.examination.nextVisitDate!.compareTo(b.examination.nextVisitDate!)),
      waiting: () => sort((a, b) {
        final lastVisitDateWithoutDayA = a.examination.lastVisitDate!;
        final lastVisitDateWithoutDayB = b.examination.lastVisitDate!;
        final lastVisitDateTimeA =
            DateTime(lastVisitDateWithoutDayA.year, lastVisitDateWithoutDayA.month.index + 1);
        final lastVisitDateTimeB =
            DateTime(lastVisitDateWithoutDayB.year, lastVisitDateWithoutDayB.month.index + 1);
        return lastVisitDateTimeA.compareTo(lastVisitDateTimeB);
      }),
    );
  }
}

// Temporary class and data for DEV purposes - API is not ready yet. TODO: remove later
class ExaminationRecord {
  const ExaminationRecord({
    required this.examinationType,
    required this.worth,
    this.currentStreak = 0,
    required this.interval,
    this.lastVisitDate,
    this.nextVisitDate,
    required this.priority,
  });

  final ExaminationType examinationType;
  final int worth;
  final int currentStreak;
  final int interval;
  final DateWithoutDay? lastVisitDate;
  final DateTime? nextVisitDate;
  final int priority;

  @override
  String toString() {
    return 'ExaminationRecord{examinationType: $examinationType, worth: $worth, currentStreak: $currentStreak, interval: $interval, lastVisitDate: $lastVisitDate, nextVisitDate: $nextVisitDate, priority: $priority}';
  }
}

final fakeExaminationData = <ExaminationRecord>[
  //
  ExaminationRecord(
      examinationType: ExaminationType.GENERAL_PRACTITIONER,
      worth: 200,
      interval: 2,
      priority: 1,
      nextVisitDate: DateTime(2021, 12, 28, 11)),
  ExaminationRecord(
      examinationType: ExaminationType.GYNECOLOGIST,
      worth: 300,
      interval: 1,
      priority: 3,
      nextVisitDate: DateTime(2021, 12, 12, 10)),
  ExaminationRecord(
      examinationType: ExaminationType.DENTIST,
      worth: 300,
      interval: 1,
      priority: 8,
      nextVisitDate: DateTime(2022, 2, 11, 7)),
  ExaminationRecord(
      examinationType: ExaminationType.DERMATOLOGIST,
      worth: 200,
      interval: 1,
      priority: 6,
      nextVisitDate: DateTime(2022, 3, 10, 13)),

  //
  const ExaminationRecord(
      examinationType: ExaminationType.OPHTHALMOLOGIST, worth: 100, interval: 2, priority: 9),
  const ExaminationRecord(
      examinationType: ExaminationType.COLONOSCOPY, worth: 1000, interval: 10, priority: 4),

  //
  ExaminationRecord(
      examinationType: ExaminationType.UROLOGIST,
      worth: 500,
      interval: 2,
      priority: 2,
      lastVisitDate: DateWithoutDay(month: Months.september, year: 2021)),
  ExaminationRecord(
      examinationType: ExaminationType.MAMMOGRAM,
      worth: 500,
      interval: 2,
      priority: 3,
      lastVisitDate: DateWithoutDay(month: Months.march, year: 2021)),
];
