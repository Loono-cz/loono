import 'package:loono/models/api_response.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationRepository {
  const ExaminationRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;
  UserRepository get _userRepository => registry.get<UserRepository>();

  Future<ApiResponse<ExaminationRecord>> cancelExamination(
    String uuid,
  ) async {
    final response = await _apiService.cancelExamination(uuid);
    await _userRepository.sync();
    return response;
  }

  Future<ApiResponse<void>> deleteExamination(
    String uuid,
  ) async {
    final response = await _apiService.deleteExamination(uuid);
    await _userRepository.sync();
    return response;
  }

  Future<ApiResponse<ExaminationRecord>> postExamination(
    ExaminationType type, {
    String? uuid,
    DateTime? newDate,
    ExaminationStatus? status,
    bool? firstExam,
    ExaminationCategoryType categoryType = ExaminationCategoryType.MANDATORY,
    String? note,
    int? customInterval,
    bool? periodicExam,
    ExaminationActionType? actionType,
  }) async {
    final response = await _apiService.postExamination(
      type,
      uuid: uuid,
      newDate: newDate,
      status: status,
      firstExam: firstExam,
      note: note,
      customInterval: customInterval,
      periodicExam: periodicExam,
      categoryType: categoryType,
      actionType: actionType,
    );
    await _userRepository.sync();
    return response;
  }

  Future<ApiResponse<ExaminationRecord>> confirmExamination(
    String? uuid,
  ) async {
    final response = await _apiService.confirmExamination(uuid);
    await _userRepository.sync();
    return response;
  }

  Future<ApiResponse<SelfExaminationCompletionInformation>> confirmSelfExamination(
    SelfExaminationType type, {
    required SelfExaminationResult result,
  }) async {
    final response = await _apiService.confirmSelfExamination(
      type,
      result: result,
    );
    await _userRepository.sync();
    return response;
  }

  /// if the user had a finding, this is the POST api for the result from the undergone doctor examination
  Future<ApiResponse<SelfExaminationFindingResponse>> resultSelfExamination(
    SelfExaminationType type, {
    required SelfExaminationResult result,
  }) async {
    final response = await _apiService.resultSelfExamination(
      type,
      result: result,
    );
    await _userRepository.sync();
    return response;
  }
}
