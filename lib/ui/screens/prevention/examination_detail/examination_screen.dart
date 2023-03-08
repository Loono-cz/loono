import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_detail.dart';
import 'package:loono/ui/screens/prevention/questionnaire/schedule_examination.dart';
import 'package:loono/ui/widgets/prevention/examination_edit_modal.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class ExaminationDetailScreen extends StatelessWidget {
  const ExaminationDetailScreen({
    Key? key,
    required this.categorizedExamination,
    this.initialMessage,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final String? initialMessage; // show flushbar message on init
  ExaminationPreventionStatus get _exam => categorizedExamination.examination;

  bool get _isMandatory => _exam.examinationCategoryType == ExaminationCategoryType.MANDATORY;

  @override
  Widget build(BuildContext context) {
    final exams =
        Provider.of<ExaminationsProvider>(context, listen: true).examinations!.examinations;

    final examination = exams.firstWhere(
      (item) => item.uuid != null && item.uuid == _exam.uuid,
      orElse: () => exams.firstWhere(
        (item) => _exam.examinationType == item.examinationType,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white24,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            key: const Key('examinationDetailPage_btn_back'),
            onPressed: () => AutoRouter.of(context).pop(),
            icon: SvgPicture.asset(
              'assets/icons/arrow_back.svg',
            ),
          ),
        ),
        actions: examination.examinationCategoryType == ExaminationCategoryType.CUSTOM
            ? [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    key: const Key('examinationDetailPage_btn_menu'),
                    onPressed: () => showCustomExamEditModal(context, examination),
                    icon: SvgPicture.asset(
                      'assets/icons/more_vertical.svg',
                    ),
                  ),
                )
              ]
            : null,
      ),
      body: SafeArea(
        child: categorizedExamination.category == const ExaminationCategory.unknownLastVisit() &&
                _isMandatory
            ? ScheduleExamination(
                examinationRecord: examination,
              )
            : SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: ExaminationDetail(
                  categorizedExamination: CategorizedExamination(
                    examination: examination,
                    category: examination.calculateStatus(),
                  ),
                  initialMessage: initialMessage,
                ),
              ),
      ),
    );
  }
}
