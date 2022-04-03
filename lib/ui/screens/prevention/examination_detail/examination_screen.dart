import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_detail.dart';
import 'package:loono/ui/screens/prevention/questionnaire/schedule_examination.dart';
import 'package:provider/provider.dart';

class ExaminationDetailScreen extends StatelessWidget {
  const ExaminationDetailScreen({
    Key? key,
    required this.categorizedExamination,
    this.initialMessage,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final String? initialMessage; // show flushbar message on init

  @override
  Widget build(BuildContext context) {
    final _examination = Provider.of<ExaminationsProvider>(context, listen: true)
        .examinations!
        .examinations
        .firstWhere(
          (item) => item.examinationType == categorizedExamination.examination.examinationType,
        );

    return Scaffold(
      body: SafeArea(
        child: categorizedExamination.category == const ExaminationCategory.unknownLastVisit()
            ? ScheduleExamination(
                examinationRecord: categorizedExamination.examination,
              )
            : SingleChildScrollView(
                child: ExaminationDetail(
                  categorizedExamination: CategorizedExamination(
                    examination: _examination,
                    category: _examination.calculateStatus(),
                  ),
                  initialMessage: initialMessage,
                ),
              ),
      ),
    );
  }
}
