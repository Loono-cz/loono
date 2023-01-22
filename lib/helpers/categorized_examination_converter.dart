import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono_api/loono_api.dart';

///Converts [ExaminationPreventionStatus] to [CategorizedExamination]
class CategorizedExaminationConverter {
  static List<CategorizedExamination> convert(
    final List<ExaminationPreventionStatus> preventionStatuses,
  ) {
    return preventionStatuses
        .map(
          (e) => CategorizedExamination(
            examination: e,
            category: e.calculateStatus(),
          ),
        )
        .toList()
      ..sortExaminations();
  }
}
