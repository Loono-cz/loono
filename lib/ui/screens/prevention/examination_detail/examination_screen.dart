import 'package:flutter/material.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_detail.dart';

class ExaminationDetailScreen extends StatelessWidget {
  const ExaminationDetailScreen({
    Key? key,
    required this.categorizedExamination,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        /// TODO: commented out for testing of "unknown" status. First time after onboarding there should be "schedule" flow. We dont have flag for that for now
        /*child: categorizedExamination.category == const ExaminationCategory.unknownLastVisit()
            ? ScheduleExamination(
                examinationRecord: categorizedExamination.examination,
              )
            : */
        child: SingleChildScrollView(
          child: ExaminationDetail(
            categorizedExamination: categorizedExamination,
          ),
        ),
      ),
    );
  }
}
