import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'examination_status.freezed.dart';

const examinationStatusOrdering = <ExaminationStatus>[
  ExaminationStatus.scheduledSoonOrOverdue(),
  ExaminationStatus.never(),
  ExaminationStatus.unfinished(),
  ExaminationStatus.scheduled(),
  ExaminationStatus.waiting(),
];

// TODO: localization
extension ExaminationStatusExt on ExaminationStatus {
  String getHeaderMessage(BuildContext context) {
    return when(
      scheduledSoonOrOverdue: () => 'běž na prohlídku',
      never: () => 'objednej se',
      unfinished: () => 'další prohlídky',
      scheduled: () => 'připomeneme ti prohlídku',
      waiting: () => 'připomeneme ti objednání',
    ).toUpperCase();
  }
}

/// Examination statuses are based on
/// [these rules](https://cesko-digital.atlassian.net/browse/LOON-324).
@freezed
class ExaminationStatus with _$ExaminationStatus {
  const ExaminationStatus._();

  const factory ExaminationStatus.scheduledSoonOrOverdue() = ScheduledSoonOrOverdueExamination;

  const factory ExaminationStatus.never() = NeverExamination;

  const factory ExaminationStatus.unfinished() = UnfinishedExamination;

  const factory ExaminationStatus.scheduled() = ScheduledExamination;

  const factory ExaminationStatus.waiting() = WaitingExamination;
}
