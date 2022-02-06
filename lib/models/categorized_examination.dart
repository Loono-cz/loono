import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_extensions.dart';

class CategorizedExamination {
  const CategorizedExamination({
    required this.examination,
    required this.category,
  });

  final ExaminationRecordTemp examination;
  final ExaminationCategory category;

  @override
  String toString() {
    return 'CategorizedExamination{examination: $examination, category: $category}';
  }
}
