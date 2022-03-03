// ignore_for_file: constant_identifier_names

import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/self_examination_category.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono_api/loono_api.dart';

const int MONTHS_IN_YEAR = 12;
const int TO_SCHEDULE_MONTHS_TRANSFER = 2;
const int SELF_EXAMINATION_ACTIVE_CARD_INTERVAL_IN_HOURS = 72;

extension ExaminationPreventionStatusExt on ExaminationPreventionStatus {
  ExaminationCategory calculateStatus([DateTime? dateTimeNow]) {
    final now = dateTimeNow ?? DateTime.now();

    // STATUS: waiting or newToSchedule
    if (state == ExaminationStatus.CONFIRMED && lastConfirmedDate != null) {
      final lastVisitDateTime = lastConfirmedDate!.toLocal();
      final lastVisitDateWithoutDay = DateTime(lastVisitDateTime.year, lastVisitDateTime.month);

      // if last visit date is before: CURRENT_MONTH - (INTERVAL - 2 months)
      final subtractedWaitingDate = DateTime(
        now.year,
        now.month - (intervalYears * MONTHS_IN_YEAR - TO_SCHEDULE_MONTHS_TRANSFER),
      );
      // then waiting time has ended, move to "TO BE SCHEDULED"
      if (lastVisitDateWithoutDay.isBefore(subtractedWaitingDate) ||
          lastVisitDateWithoutDay.isAtSameMomentAs(subtractedWaitingDate)) {
        return const ExaminationCategory.newToSchedule();
      }
      // else wait
      return const ExaminationCategory.waiting();
    }

    if (state == ExaminationStatus.UNKNOWN || state == ExaminationStatus.CANCELED) {
      return const ExaminationCategory.newToSchedule();
    }

    // STATUS: scheduled or scheduledSoonOrOverdue
    if (plannedDate != null) {
      final diffInDaysFromNow = plannedDate!.toLocal().difference(now).inDays;
      // if it is more than 30 days before the check-up visit the status is "SCHEDULED"
      if (diffInDaysFromNow > 30) return const ExaminationCategory.scheduled();
      // else 30 days or equal before check-up visit the status is "SCHEDULED_SOON_OR_OVERDUE"
      return const ExaminationCategory.scheduledSoonOrOverdue();
    }

    // else fallback to STATUS: unknownLastVisit
    return const ExaminationCategory.unknownLastVisit();
  }
}

extension SelfExaminationPreventionStatusExt on SelfExaminationPreventionStatus {
  // TODO: test statuses
  SelfExaminationCategory calculateStatus([DateTime? dateTimeNow]) {
    final now = dateTimeNow ?? DateTime.now();

    if (history.isEmpty) {
      return const SelfExaminationCategory.first();
    }

    if (history.last == SelfExaminationStatus.WAITING_FOR_RESULT) {
      return const SelfExaminationCategory.hasFindingExpectingResult();
    }

    if (history.last == SelfExaminationStatus.WAITING_FOR_CHECKUP) {
      return const SelfExaminationCategory.hasFinding();
    }

    if (history.last == SelfExaminationStatus.PLANNED) {
      if (plannedDate != null) {
        if (plannedDate!.toDateTime().difference(now).inHours.abs() <=
            SELF_EXAMINATION_ACTIVE_CARD_INTERVAL_IN_HOURS) {
          return const SelfExaminationCategory.active();
        } else {
          return const SelfExaminationCategory.waiting();
        }
      }
    }

    return const SelfExaminationCategory.waiting();
  }
}

extension CategorizedExaminationListExt on List<CategorizedExamination> {
  void sortExaminations() {
    if (isEmpty) return;
    first.category.whenOrNull(
      scheduledSoonOrOverdue: () =>
          sort((a, b) => b.examination.plannedDate!.compareTo(a.examination.plannedDate!)),
      newToSchedule: () => sort((a, b) {
        if (a.examination.lastConfirmedDate == null || b.examination.lastConfirmedDate == null) {
          return -1;
        }
        final lastVisitDateWithoutDayA = a.examination.lastConfirmedDate!;
        final lastVisitDateWithoutDayB = b.examination.lastConfirmedDate!;
        final lastVisitDateTimeA =
            DateTime(lastVisitDateWithoutDayA.year, lastVisitDateWithoutDayA.month);
        final lastVisitDateTimeB =
            DateTime(lastVisitDateWithoutDayB.year, lastVisitDateWithoutDayB.month);
        return lastVisitDateTimeA.compareTo(lastVisitDateTimeB);
      }),
      unknownLastVisit: () =>
          sort((a, b) => a.examination.priority.compareTo(b.examination.priority)),
      scheduled: () =>
          sort((a, b) => a.examination.plannedDate!.compareTo(b.examination.plannedDate!)),
      waiting: () => sort((a, b) {
        final lastVisitDateWithoutDayA = a.examination.lastConfirmedDate!;
        final lastVisitDateWithoutDayB = b.examination.lastConfirmedDate!;
        final lastVisitDateTimeA =
            DateTime(lastVisitDateWithoutDayA.year, lastVisitDateWithoutDayA.month);
        final lastVisitDateTimeB =
            DateTime(lastVisitDateWithoutDayB.year, lastVisitDateWithoutDayB.month);
        return lastVisitDateTimeA.compareTo(lastVisitDateTimeB);
      }),
    );
  }
}
