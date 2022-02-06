import 'package:built_collection/built_collection.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono_api/loono_api.dart';

/// This file exists just to avoid migration from PreventionStatus to ExaminationTypeTemp
///
///
List<ExaminationRecordTemp> parseExaminations(BuiltList<PreventionStatus> records) {
  return records
      .map(
        (item) => ExaminationRecordTemp(
          examinationType: item.examinationType,
          worth: 200,
          interval: item.intervalYears,
          priority: item.priority,
          nextVisitDate: item.plannedDate,
          lastVisitDate: item.lastConfirmedDate != null
              ? DateWithoutDay(
                  year: item.lastConfirmedDate!.year,
                  month: Months.values.elementAt(
                    item.lastConfirmedDate!.month - 1,
                  ),
                )
              : null,
        ),
      )
      .toList();
}
