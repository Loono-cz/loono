import 'package:loono/models/api_response.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationRepository {
  const ExaminationRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<ApiResponse<ExaminationRecord>> cancelExamination(
    String uuid,
  ) async {
    final response = await _apiService.cancelExamination(uuid);
    return response;
  }

  Future<ApiResponse<ExaminationRecord>> postExamination(
    ExaminationType type, {
    String? uuid,
    DateTime? newDate,
    ExaminationStatus? status,
    bool? firstExam,
  }) async {
    final response = await _apiService.postExamination(
      type,
      uuid: uuid,
      newDate: newDate,
      status: status,
      firstExam: firstExam,
    );
    return response;
  }

  Future<ApiResponse<ExaminationRecord>> confirmExamination(
    String? uuid,
  ) async {
    final response = await _apiService.confirmExamination(uuid);
    return response;
  }
}
