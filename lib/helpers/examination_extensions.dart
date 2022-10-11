// ignore_for_file: constant_identifier_names

import 'package:loono/constants.dart';
import 'package:loono/helpers/date_helpers.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/self_examination_category.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono_api/loono_api.dart';

const int TO_SCHEDULE_MONTHS_TRANSFER = 2;
const int SELF_EXAMINATION_ACTIVE_CARD_INTERVAL_IN_HOURS = 72;

extension ExaminationPreventionStatusExt on ExaminationPreventionStatus {
  ExaminationCategory calculateStatus([DateTime? dateTimeNow]) {
    final now = dateTimeNow ?? DateTime.now();
    final isCustom = examinationCategoryType == ExaminationCategoryType.CUSTOM;

    // STATUS: waiting or newToSchedule
    if (([ExaminationStatus.CONFIRMED, ExaminationStatus.UNKNOWN].contains(state)) &&
        lastConfirmedDate != null &&
        (periodicExam == true || periodicExam == null)) {
      final lastVisitDateTime = lastConfirmedDate!.toLocal();
      final lastVisitDateWithoutDay = DateTime(lastVisitDateTime.year, lastVisitDateTime.month);
      DateTime subtractedWaitingDate;
      if (isCustom && customInterval != null) {
        subtractedWaitingDate = DateTime(
          now.year,
          now.month -
              (transformMonthToYear(customInterval!) * LoonoStrings.monthInYear -
                  TO_SCHEDULE_MONTHS_TRANSFER),
        );
      } else {
        // if last visit date is before: CURRENT_MONTH - (INTERVAL - 2 months)
        subtractedWaitingDate = DateTime(
          now.year,
          now.month - (intervalYears * LoonoStrings.monthInYear - TO_SCHEDULE_MONTHS_TRANSFER),
        );
      }

      // then waiting time has ended, move to "TO BE SCHEDULED"
      if (lastVisitDateWithoutDay.isBefore(subtractedWaitingDate) ||
          lastVisitDateWithoutDay.isAtSameMomentAs(subtractedWaitingDate)) {
        return const ExaminationCategory.newToSchedule();
      }
      // else wait
      return const ExaminationCategory.waiting();
    }
    if ([ExaminationStatus.UNKNOWN, ExaminationStatus.CANCELED].contains(state)) {
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
        final nowDate = DateTime(now.year, now.month, now.day); //now with set hour and minute to 0
        final difference = plannedDate!.toDateTime().difference(nowDate).inHours.abs();
        if (difference <= SELF_EXAMINATION_ACTIVE_CARD_INTERVAL_IN_HOURS) {
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
      scheduledSoonOrOverdue: () => sort((a, b) {
        if ((a.examination.plannedDate != b.examination.plannedDate) &&
            (a.examination.plannedDate != null && b.examination.plannedDate != null)) {
          return a.examination.plannedDate!.compareTo(b.examination.plannedDate!);
        } else if ((a.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                a.examination.examinationCategoryType == null) &&
            (b.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                b.examination.examinationCategoryType == null)) {
          return a.examination.priority.compareTo(b.examination.priority);
        } else if (a.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM &&
            b.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM) {
          return a.examination.examinationType.name.compareTo(b.examination.examinationType.name);
        } else if ((a.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                a.examination.examinationCategoryType == null) &&
            b.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM) {
          return 0;
        } else {
          return 1;
        }
      }),
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

        if (lastVisitDateTimeA != lastVisitDateTimeB) {
          return lastVisitDateTimeA.compareTo(lastVisitDateTimeB);
        } else if ((a.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                a.examination.examinationCategoryType == null) &&
            (b.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                b.examination.examinationCategoryType == null)) {
          return a.examination.priority.compareTo(b.examination.priority);
        } else if (a.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM &&
            b.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM) {
          return a.examination.examinationType.name.compareTo(b.examination.examinationType.name);
        } else if ((a.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                a.examination.examinationCategoryType == null) &&
            b.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM) {
          return 0;
        } else {
          return 1;
        }
      }),
      unknownLastVisit: () => sort(
        (a, b) => a.examination.priority.compareTo(b.examination.priority),
      ),
      scheduled: () => sort((a, b) {
        if ((a.examination.plannedDate != b.examination.plannedDate) &&
            (a.examination.plannedDate != null && b.examination.plannedDate != null)) {
          return a.examination.plannedDate!.compareTo(b.examination.plannedDate!);
        } else if ((a.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                a.examination.examinationCategoryType == null) &&
            (b.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                b.examination.examinationCategoryType == null)) {
          return a.examination.priority.compareTo(b.examination.priority);
        } else if (a.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM &&
            b.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM) {
          return a.examination.examinationType.name.compareTo(b.examination.examinationType.name);
        } else if ((a.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                a.examination.examinationCategoryType == null) &&
            b.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM) {
          return 0;
        } else {
          return 1;
        }
      }),
      waiting: () => sort((a, b) {
        if (a.examination.lastConfirmedDate != null && b.examination.lastConfirmedDate != null) {
          final lastVisitDateWithoutDayA = a.examination.lastConfirmedDate!;
          final lastVisitDateWithoutDayB = b.examination.lastConfirmedDate!;
          final lastVisitDateTimeA =
              DateTime(lastVisitDateWithoutDayA.year, lastVisitDateWithoutDayA.month);
          final lastVisitDateTimeB =
              DateTime(lastVisitDateWithoutDayB.year, lastVisitDateWithoutDayB.month);

          if (lastVisitDateTimeA != lastVisitDateTimeB) {
            return lastVisitDateTimeA.compareTo(lastVisitDateTimeB);
          } else if ((a.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                  a.examination.examinationCategoryType == null) &&
              (b.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                  b.examination.examinationCategoryType == null)) {
            return a.examination.priority.compareTo(b.examination.priority);
          } else if (a.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM &&
              b.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM) {
            return a.examination.examinationType.name.compareTo(b.examination.examinationType.name);
          } else if ((a.examination.examinationCategoryType == ExaminationCategoryType.MANDATORY ||
                  a.examination.examinationCategoryType == null) &&
              b.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM) {
            return 0;
          } else {
            return 1;
          }
        }
        return 1;
      }),
    );
  }
}
