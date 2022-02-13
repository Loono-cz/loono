import 'package:loono/helpers/examination_extensions.dart';

class ExaminationRepository {
  const ExaminationRepository();

  Future<List<ExaminationRecordTemp>> getExaminationRecords() async {
    return fakeExaminationData;
  }
}
