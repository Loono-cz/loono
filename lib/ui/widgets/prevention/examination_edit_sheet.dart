import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_helpers.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/ui/widgets/custom_exam_form/custom_input_text_field.dart';
import 'package:loono/ui/widgets/prevention/examination_choose_exam_frequency.dart';
import 'package:loono/ui/widgets/settings/checkbox.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

void showCustomEditExamSheet({
  required BuildContext context,
  required ExaminationType examinationType,
  required DateTime date,
  required String id,
}) {
  final examProvider = Provider.of<ExaminationsProvider>(context, listen: false);
  final exam = examProvider.examinations?.examinations.firstWhere((p0) => p0.uuid == id);
  final l10n = context.l10n;

  registry.get<FirebaseAnalytics>().logEvent(name: 'OpenCancelCheckupModal');
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    isScrollControlled: true,
    builder: (BuildContext modalContext) => Container(
      color: LoonoColors.primary,
      child: CustomEditExamination(exam: exam),
    ),
  ).whenComplete(() {
    registry.get<FirebaseAnalytics>().logEvent(name: 'CloseCancelEditModal');
  });
}

class CustomEditExamination extends StatefulWidget {
  const CustomEditExamination({super.key, this.exam});
  final ExaminationPreventionStatus? exam;
  @override
  State<CustomEditExamination> createState() => _CustomEditExaminationState();
}

class _CustomEditExaminationState extends State<CustomEditExamination> {
  String _term = '';
  DateTime? _lastExamDate;

  bool _idkCheck = false;
  final bool _showLastExamError = false;

  void changeFreqTerm(String term) => Future<void>.delayed(
        const Duration(milliseconds: 500),
        () => setState(() {
          _term = term;
        }),
      );

  void setNextExamCheckbox(bool value) => Future<void>.delayed(
        const Duration(milliseconds: 200),
        () => setState(() {
          _idkCheck = value;
        }),
      );

  void onDateChange(DateTime? dateTime) => Future<void>.delayed(
        const Duration(milliseconds: 200),
        () => setState(() {
          _lastExamDate = dateTime;
        }),
      );

  Future<void> _onPostNewCheckupSubmit({DateTime? date, String? note}) async {
    ///TODO: Zeptat se stepana co by tady asi melo bejt ja totiz uz nevim :D

    final response = await registry.get<ExaminationRepository>().postExamination(
          widget.exam!.examinationType,
          newDate: date ?? widget.exam?.plannedDate ?? widget.exam!.lastConfirmedDate,
          uuid: widget.exam!.uuid,
          periodicExam: widget.exam?.periodicExam,
          note: widget.exam?.note,
          categoryType: widget.exam?.examinationCategoryType ?? ExaminationCategoryType.CUSTOM,
          status: ExaminationStatus.CONFIRMED,
          customInterval: _term.isNotEmpty
              ? transformInterval(context, _term)
              : widget.exam?.examinationCategoryType == ExaminationCategoryType.MANDATORY
                  ? widget.exam!.intervalYears
                  : widget.exam!.customInterval,
          actionType: widget.exam!.examinationActionType,
          firstExam: true,
        );

    response.map(
      success: (res) {
        final examProvider = Provider.of<ExaminationsProvider>(context, listen: false);

        final newExam = examProvider.updateAndReturnCustomExaminationsRecord(
          res.data,
          examProvider.getChoosedCustomExamination().choosedExamination!,
        );
        print(newExam);
        AutoRouter.of(context).popUntilRouteWithName(ExaminationDetailRoute.name);
        AutoRouter.of(context).replace(
          ExaminationDetailRoute(
            categorizedExamination: examProvider.categorizedExamination!,
            choosedExamination: newExam,
          ),
        );

        showFlushBarSuccess(context, context.l10n.examination_was_edited, sync: true);
      },
      failure: (err) {
        showFlushBarError(
          context,
          err.error.response?.statusCode == 400
              ? context.l10n.unsupported_interval
              : context.l10n.something_went_wrong,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('editExamSheet'),
      decoration: const BoxDecoration(
        color: LoonoColors.bottomSheetPrevention,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LoonoCloseButton(onPressed: () => AutoRouter.of(context).pop()),
              ],
            ),
            Text(
              context.l10n.edit_examination,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              child: buildCardContent(context),
            ),
            const SizedBox(
              height: 40.0,
            ),
            AsyncLoonoApiButton(
              key: const Key('editExamSheet_btn_editExam'),
              text: context.l10n.action_save,
              asyncCallback: () async {
                await _onPostNewCheckupSubmit(date: _lastExamDate);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardContent(BuildContext context) {
    final usersDao = registry.get<DatabaseService>().users;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Frekvence prohlídek',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10.0,
            ),
            chooseExamFrequency(
              context,
              _term,
              onClickInputField: () => AutoRouter.of(context).navigate(
                ChooseFrequencyOfExamRoute(
                  examType: widget.exam!.examinationType,
                  isDefaultExam:
                      widget.exam!.examinationCategoryType == ExaminationCategoryType.MANDATORY,
                  value: _term,
                  valueChanged: changeFreqTerm,
                ),
              ),
            ),
            if (widget.exam?.lastConfirmedDate != null) ...[
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: LoonoSizes.isScreenSmall(context)
                        ? MediaQuery.of(context).size.width * 0.52
                        : MediaQuery.of(context).size.width * 0.6,
                    child: CustomInputTextField(
                      error: false,
                      enabled: !_idkCheck,
                      label: _lastExamDate == null ? '' : context.l10n.last_visit,
                      hintText: context.l10n.last_visit,
                      value: _lastExamDate != null
                          ? DateFormat(LoonoStrings.dateFormat).format(_lastExamDate!)
                          : '',
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/calendar.svg',
                        width: 5,
                        height: 5,
                        fit: BoxFit.scaleDown,
                        color: _idkCheck ? Colors.black38 : Colors.black87,
                      ),
                      onClickInputField: () => AutoRouter.of(context).navigate(
                        ChooseExamPeriodDateRoute(
                          showLastExamDate: true,
                          label: _getUserLabelBySex(context, sex: usersDao.user?.sex ?? Sex.FEMALE),
                          pickTime: false,
                          dateTime: _lastExamDate,
                          onValueChange: onDateChange,
                          isLastExamChoose: true,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: CheckboxCustom(
                      text: context.l10n.idk,
                      isChecked: _idkCheck,
                      whatIsChecked: setNextExamCheckbox,
                    ),
                  )
                ],
              )
            ] else
              Container()
          ],
        ),
      ),
    );
  }

  String _getUserLabelBySex(BuildContext context, {required Sex? sex}) {
    if (sex == null) return '';
    late final String value;
    switch (sex) {
      case Sex.MALE:
        value = context.l10n.your_last_examination_male;
        break;
      case Sex.FEMALE:
        value = context.l10n.your_last_examination_female;
        break;
    }
    return value;
  }
}
