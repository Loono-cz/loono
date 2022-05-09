import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/self_examination_category.dart';
import 'package:loono/models/api_response.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationsProvider extends ChangeNotifier {
  PreventionStatus? examinations;
  bool loading = false;
  bool hasNotification = false;

  Future<ApiResponse<PreventionStatus>> fetchExaminations() async {
    log('fetching examinations from server');

    loading = true;
    notifyListeners();

    final examResponse = await registry.get<ApiService>().getExaminations();
    examResponse.map(
      success: (exams) {
        examinations = exams.data;
        evaluateExaminations();
        loading = false;
      },
      failure: (err) {
        loading = false;
      },
    );

    notifyListeners();
    return examResponse;
  }

  void clearExaminations() {
    examinations = null;
    notifyListeners();
  }

  void updateExaminationsRecord(ExaminationRecord record) {
    final indexToUpdate = examinations?.examinations
        .indexWhere((examination) => examination.examinationType == record.type);
    if (indexToUpdate != null && indexToUpdate >= 0) {
      final updatedItem = examinations?.examinations.elementAt(indexToUpdate).rebuild(
            (item) => item
              ..uuid = record.uuid
              ..examinationType = record.type
              ..plannedDate =
                  (record.status == ExaminationStatus.CONFIRMED || record.firstExam == true)
                      ? item.plannedDate
                      : record.plannedDate?.toLocal()
              ..lastConfirmedDate =
                  (record.status == ExaminationStatus.CONFIRMED || record.firstExam == true)
                      ? record.plannedDate?.toLocal()
                      : item.lastConfirmedDate
              ..state = record.status ?? item.state
              ..firstExam = record.firstExam ?? item.firstExam,
          );

      final builder = examinations?.toBuilder();
      builder?.examinations.removeAt(indexToUpdate);
      builder?.examinations.add(updatedItem!);
      examinations = builder?.build();
      evaluateExaminations();
      notifyListeners();
    }
  }

  void evaluateExaminations() {
    if (examinations != null) {
      final preventionExamsWithPriority = examinations!.examinations.firstWhereOrNull(
        (e) =>
            [const ExaminationCategory.newToSchedule()].contains(e.calculateStatus()) ||
            e.calculateStatus() == const ExaminationCategory.scheduledSoonOrOverdue() &&
                isOverdue(CategorizedExamination(examination: e, category: e.calculateStatus())),
      );
      final selfExamsWithPriority = examinations!.selfexaminations.firstWhereOrNull(
        (e) => [
          const SelfExaminationCategory.active(),
          const SelfExaminationCategory.first(),
          const SelfExaminationCategory.hasFindingExpectingResult(),
        ].contains(e.calculateStatus()),
      );

      if (preventionExamsWithPriority != null || selfExamsWithPriority != null) {
        hasNotification = true;
      } else {
        hasNotification = false;
      }
    }
  }
}
