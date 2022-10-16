import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono_api/loono_api.dart';

///Converts [ExaminationPreventionStatus] to [CategorizedExamination] and sorts it by [CategorizedExaminationSorter]
class CategorizedExaminationConverter {
  CategorizedExaminationConverter(this._preventionStatuses);

  List<ExaminationPreventionStatus>? _preventionStatuses;
  List<CategorizedExamination> exams = [];

  var converting = false;

  Future<List<CategorizedExamination>> convert([final List<ExaminationPreventionStatus>? newStatuses]) async {
    if(newStatuses != null){
      _preventionStatuses = newStatuses;
    }
    if(_preventionStatuses == null){
      return [];
    }
    converting = true;
    exams = [];
    exams = _preventionStatuses!
        .map(
          (e) => CategorizedExamination(
            examination: e,
            category: e.calculateStatus(),
          ),
        )
        .toList();
    final sorted = await CategorizedExaminationSorter(exams).sort();
    converting = false;
    return sorted;
  }
}

class CategorizedExaminationSorter {
  CategorizedExaminationSorter(this.exams);

  List<CategorizedExamination>? exams;

  var sorting = false;

  Future<List<CategorizedExamination>> sort(
      [final List<CategorizedExamination>? newExams]) async {
    if (newExams != null) {
      exams = newExams;
    }
    sorting = true;
    if (exams == null) {
      sorting = false;
      return [];
    }
    await exams!.sortExaminations();
    sorting = false;
    return exams!;
  }
}
