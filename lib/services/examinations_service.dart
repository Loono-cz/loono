import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationsProvider extends ChangeNotifier {
  PreventionStatus? examinations;
  bool loading = false;

  Future<void> fetchExaminations() async {
    log('fetching examinations from server');

    loading = true;
    notifyListeners();

    await registry.get<ApiService>().getExaminations().then((res) {
      res.map(
        success: (exams) {
          examinations = exams.data;
          loading = false;
        },
        failure: (err) {
          loading = false;
        },
      );
    });

    notifyListeners();
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
      notifyListeners();
    }
  }
}
