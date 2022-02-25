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
    final indexToUpdate =
        examinations?.examinations.indexWhere((examination) => examination.uuid == record.uuid);
    if (indexToUpdate != null) {
      final updatedItem = examinations?.examinations.elementAt(indexToUpdate).rebuild(
            (item) => item
              ..uuid = record.uuid
              ..examinationType = record.type
              ..plannedDate = record.date
              ..state = record.status
              ..firstExam = record.firstExam,
          );

      final builder = examinations?.toBuilder();
      builder?.examinations.removeAt(indexToUpdate);
      builder?.examinations.add(updatedItem!);
      examinations = builder?.build();
      notifyListeners();
    }
  }
}
