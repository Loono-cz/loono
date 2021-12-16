import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_status.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_detail.dart';
import 'package:loono/ui/screens/prevention/examination_detail/schedule_examination.dart';

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
        child: categorizedExamination.status == const ExaminationStatus.unknownLastVisit()
            ? ScheduleExamination(
                categorizedExamination: categorizedExamination,
              )
            : ExaminationDetail(
                categorizedExamination: categorizedExamination,
              ),
      ),
    );
  }
}
