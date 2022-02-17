import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationsProvider extends ChangeNotifier {
  ExaminationsProvider() {
    fetchExaminations();
  }

  PreventionStatus? examinations;
  bool loading = false;

  Future<void> fetchExaminations() async {
    log('fetching examinations from server');

    loading = true;
    notifyListeners();

    examinations = await registry.get<ExaminationRepository>().getExaminationRecords();
    loading = false;

    notifyListeners();
  }
}
