import 'dart:developer';

import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_parser.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationRepository {
  const ExaminationRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<List<ExaminationRecordTemp>> getExaminationRecords() async {
    var records = <ExaminationRecordTemp>[];
    final response = await _apiService.getExaminations();
    response.when(
      success: (data) {
        records = parseExaminations(data);
      },
      failure: (err) {},
    );
    return records;
  }

  Future<bool> cancelExamination(ExaminationTypeEnum type) async {
    final response = await _apiService.cancelExamination(type);
    response.when(
      success: (data) {
        return true;
      },
      failure: (err) {},
    );
    return false;
  }
}
