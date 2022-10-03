import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_detail.dart';
import 'package:loono/ui/screens/prevention/questionnaire/schedule_examination.dart';
import 'package:loono/ui/widgets/prevention/examination_edit_flow.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class ExaminationDetailScreen extends StatelessWidget {
  const ExaminationDetailScreen({
    Key? key,
    required this.categorizedExamination,
    this.choosedExamination,
    this.initialMessage,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final String? initialMessage; // show flushbar message on init
  final ExaminationPreventionStatus? choosedExamination;

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              showEditSheet(context: context, categorizedExamination: categorizedExamination);
            },
            child: Text(
              context.l10n.btn_edit_examination,
              style: LoonoFonts.actionMenuItem,
            ),
          ),
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              context.l10n.back,
              style: LoonoFonts.actionMenuBack,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final examination = choosedExamination ??
        Provider.of<ExaminationsProvider>(context, listen: true)
            .examinations!
            .examinations
            .firstWhere(
              (item) => item.examinationType == categorizedExamination.examination.examinationType,
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              key: const Key('examinationDetailPage_btn_action'),
              onPressed: () => _showActionSheet(context),
              icon: SvgPicture.asset(
                'assets/icons/dots_action.svg',
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: categorizedExamination.category == const ExaminationCategory.unknownLastVisit() &&
                choosedExamination?.examinationCategoryType == ExaminationCategoryType.MANDATORY
            ? ScheduleExamination(
                examinationRecord: categorizedExamination.examination,
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
