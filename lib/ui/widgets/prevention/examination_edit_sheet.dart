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
  required ExaminationPreventionStatus catExam,
}) {
  final exam = catExam;

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
  String _customIntervalText = '';
  DateTime? _lastExamDate;

  bool _idkCheck = false;

  void changeCustomInterval(String term) => Future<void>.delayed(
        Duration.zero,
        () => setState(() {
          _customIntervalText = term;
        }),
      );

  void setNextExamCheckbox(bool value) => Future<void>.delayed(
        Duration.zero,
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

  @override
  void initState() {
    super.initState();
    _lastExamDate = widget.exam?.lastConfirmedDate;
  }

  Future<void> sendRegularRequest({int? customInterval}) async {
    final response = await registry.get<ExaminationRepository>().postExamination(
          widget.exam!.examinationType,
          uuid: widget.exam!.uuid,
          actionType: widget.exam?.examinationActionType,
          periodicExam: widget.exam?.periodicExam,
          note: widget.exam?.note,
          customInterval: customInterval ?? widget.exam?.customInterval,
          newDate: _lastExamDate,
          categoryType: ExaminationCategoryType.CUSTOM,
          status: ExaminationStatus.CONFIRMED,
          firstExam: true,
        );
    response.map(
      success: (res) {
        registry
            .get<ExaminationRepository>()
            .postExamination(
              widget.exam!.examinationType,
              uuid: widget.exam!.uuid,
              actionType: widget.exam?.examinationActionType,
              periodicExam: widget.exam?.periodicExam,
              note: widget.exam?.note,
              customInterval: customInterval ?? widget.exam?.customInterval,
              newDate: _lastExamDate,
              categoryType: ExaminationCategoryType.CUSTOM,
              status: ExaminationStatus.NEW,
              firstExam: true,
            )
            .then((value) {
          value.map(
            success: (newRes) {
              Provider.of<ExaminationsProvider>(context, listen: false).updateExaminationsRecord(
                newRes.data,
              );
              AutoRouter.of(context).popUntilRouteWithName(ExaminationDetailRoute.name);
              showFlushBarSuccess(context, context.l10n.examination_was_edited, sync: true);
            },
            failure: (err) => showFlushBarError(
              context,
              statusCodeToText(
                context,
                err.error.response?.statusCode,
              ),
            ),
          );
        });
      },
      failure: (err) {
        showFlushBarError(
          context,
          statusCodeToText(
            context,
            err.error.response?.statusCode,
          ),
        );
      },
    );
  }

  Future<void> sendRegularRequestConfirm({int? customInterval}) async {
    final response = await registry.get<ExaminationRepository>().postExamination(
          widget.exam!.examinationType,
          uuid: widget.exam!.uuid,
          actionType: widget.exam?.examinationActionType,
          periodicExam: widget.exam?.periodicExam,
          note: widget.exam?.note,
          customInterval: customInterval ?? widget.exam?.customInterval, // Pravidelne
          newDate: _idkCheck ? DateTime.now() : _lastExamDate,
          categoryType: ExaminationCategoryType.CUSTOM,
          status: _idkCheck ? ExaminationStatus.UNKNOWN : ExaminationStatus.CONFIRMED,
          firstExam: true,
        );

    response.map(
      success: (res) {
        Provider.of<ExaminationsProvider>(context, listen: false).updateExaminationsRecord(
          res.data,
        );
        AutoRouter.of(context).popUntilRouteWithName(ExaminationDetailRoute.name);
      },
      failure: (err) => showFlushBarError(
        context,
        statusCodeToText(
          context,
          err.error.response?.statusCode,
        ),
      ),
    );
  }

  Future<void> _onPostNewCheckupSubmit({DateTime? newDate, int? customInterval}) async {
    final exam = widget.exam!;
    final noPlannedExamExist = exam.firstExam && exam.plannedDate == null ||
        [ExaminationStatus.CANCELED, ExaminationStatus.CONFIRMED].contains(exam.state);
    if (noPlannedExamExist) {
      await sendRegularRequestConfirm(customInterval: customInterval);
    } else {
      await sendRegularRequest(customInterval: customInterval);
    }
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
                await _onPostNewCheckupSubmit(
                  newDate: _lastExamDate,
                  customInterval: _customIntervalText.isNotEmpty
                      ? transformInterval(context, _customIntervalText)
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardContent(BuildContext context) {
    final usersDao = registry.get<DatabaseService>().users;
    final exam = widget.exam!;

    /// must be first exam and no planned examination should exist
    final noPlannedExamExist = exam.firstExam && exam.plannedDate == null;
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
              _customIntervalText,
              onClickInputField: () => AutoRouter.of(context).navigate(
                ChooseFrequencyOfExamRoute(
                  examType: exam.examinationType,
                  isDefaultExam: exam.examinationCategoryType == ExaminationCategoryType.MANDATORY,
                  value: _customIntervalText,
                  valueChanged: changeCustomInterval,
                ),
              ),
            ),
            if (noPlannedExamExist) ...[
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
