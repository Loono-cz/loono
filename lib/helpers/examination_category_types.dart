import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono_api/loono_api.dart';

extension ExaminationCategoryTypeExt on ExaminationCategoryType {
  int compareTo(ExaminationCategoryType? other) {
    if (other == null) return 1;
    return _toInt().compareTo(other._toInt());
  }

  int _toInt() {
    switch (this) {
      case ExaminationCategoryType.CUSTOM:
        return 1;
      case ExaminationCategoryType.MANDATORY:
        return 0;
    }
    return -1;
  }
}

int compareExaminationType(
  CategorizedExamination a,
  CategorizedExamination b, {
  bool compareByDate = true,
  bool repeat = true,
}) {
  final aType = a.examination.examinationCategoryType;
  final bType = b.examination.examinationCategoryType;
  final comparedCategoryType = aType?.compareTo(bType) ?? 0;
  if (comparedCategoryType == 0) {
    switch (aType) {
      case ExaminationCategoryType.CUSTOM:
        final compared = compareByDate
            ? _compareExamDate(a, b)
            : a.examination.examinationType.l10n_name.compareTo(
                b.examination.examinationType.l10n_name,
              );
        return _processComparedValue(
          a: a,
          b: b,
          compared: compared,
          compareByDate: compareByDate,
          tryAgainOnEquality: repeat,
        );
      case ExaminationCategoryType.MANDATORY:
        final compared = compareByDate
            ? _compareExamDate(a, b)
            : a.examination.priority.compareTo(b.examination.priority);
        return _processComparedValue(
          a: a,
          b: b,
          compared: compared,
          compareByDate: compareByDate,
          tryAgainOnEquality: repeat,
        );
    }
  }
  return comparedCategoryType;
}

int _compareExamDate(CategorizedExamination a, CategorizedExamination b) {
  if (a.examination.targetExamDate == null || b.examination.targetExamDate == null) {
    return 0;
  }
  final duration =
      a.examination.targetExamDate!.difference(b.examination.targetExamDate!).inMinutes;
  return duration > 0
      ? 1
      : duration < 0
          ? -1
          : 0;
}

int _processComparedValue({
  required CategorizedExamination a,
  required CategorizedExamination b,
  required int compared,
  required bool compareByDate,
  required bool tryAgainOnEquality,
}) {
  return compared == 0 && tryAgainOnEquality
      ? compareExaminationType(
          a,
          b,
          compareByDate: !compareByDate,
          repeat: false,
        )
      : compared;
}
