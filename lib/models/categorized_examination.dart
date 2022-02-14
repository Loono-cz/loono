import 'package:loono/helpers/examination_category.dart';
import 'package:loono_api/loono_api.dart';

class CategorizedExamination {
  const CategorizedExamination({
    required this.examination,
    required this.category,
  });

  final PreventionStatus examination;
  final ExaminationCategory category;

  @override
  String toString() {
    return 'CategorizedExamination{examination: $examination, category: $category}';
  }
}
