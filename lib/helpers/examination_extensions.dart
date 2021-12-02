// ignore_for_file: constant_identifier_names

import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/examination_status.dart';
import 'package:loono/helpers/examination_types.dart';

const int DAYS_IN_YEAR = 365;
const int TWO_MONTHS_IN_DAYS = 60;

extension ExaminationRecordExt on ExaminationRecord {
  ExaminationStatus calcStatus() {
    final examinationRecord = this;

    if (examinationRecord.nextVisitDate == null && examinationRecord.lastVisitDate != null) {
      final lastVisitDateWithoutDay = examinationRecord.lastVisitDate!;
      final lastVisitDateTime =
          DateTime(lastVisitDateWithoutDay.year, lastVisitDateWithoutDay.month.index + 1);
      // if last visit date is older than CURRENT_MONTH - (INTERVAL - 2 months)
      final toSubtract =
          Duration(days: examinationRecord.interval * DAYS_IN_YEAR + TWO_MONTHS_IN_DAYS);
      if (lastVisitDateTime.difference(DateTime.now().subtract(toSubtract)).inDays < 0) {
        return const ExaminationStatus.never();
      }
      return const ExaminationStatus.waiting();
    }

    final nextVisitDate = examinationRecord.nextVisitDate;
    if (nextVisitDate != null) {
      final diffInDaysFromNow = nextVisitDate.difference(DateTime.now()).inDays;
      if (diffInDaysFromNow > 30) return const ExaminationStatus.scheduled();
      return const ExaminationStatus.scheduledSoonOrOverdue();
    }

    if (examinationRecord.lastVisitDate == null &&
        onboardingExaminations.contains(examinationRecord.examinationType)) {
      return const ExaminationStatus.unfinished();
    }

    return const ExaminationStatus.never();
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
  ExaminationRecord(examinationType: ExaminationType.GENERAL_PRACTITIONER, worth: 200, interval: 2, priority: 1, nextVisitDate: DateTime(2021, 12, 28, 11)),
  ExaminationRecord(examinationType: ExaminationType.GYNECOLOGIST, worth: 300, interval: 1, priority: 3, nextVisitDate: DateTime(2021, 12, 10, 10)),
  ExaminationRecord(examinationType: ExaminationType.DENTIST, worth: 300, interval: 1, priority: 8, nextVisitDate: DateTime(2021, 12, 1, 6)),
  const ExaminationRecord(examinationType: ExaminationType.MAMMOGRAM, worth: 500, interval: 2, priority: 2),
  const ExaminationRecord(examinationType: ExaminationType.OPHTHALMOLOGIST, worth: 100, interval: 2, priority: 9),
  ExaminationRecord(examinationType: ExaminationType.DERMATOLOGIST, worth: 200, interval: 1, priority: 6, nextVisitDate: DateTime(2021, 2, 10, 13)),
  ExaminationRecord(examinationType: ExaminationType.DENTIST, worth: 300, interval: 1, priority: 8, lastVisitDate: DateWithoutDay(month: Months.september, year: 2021)),
  ExaminationRecord(examinationType: ExaminationType.GYNECOLOGIST, worth: 300, interval: 1, priority: 3, lastVisitDate: DateWithoutDay(month: Months.march, year: 2021)),
];
