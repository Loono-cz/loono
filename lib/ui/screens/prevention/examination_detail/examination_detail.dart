import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_action_types.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/calendar_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_badges.dart';
import 'package:loono/ui/screens/prevention/examination_detail/faq_section.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/prevention/calendar_permission_sheet.dart';
import 'package:loono/ui/widgets/prevention/change_last_visit_sheet.dart';
import 'package:loono/ui/widgets/prevention/datepicker_sheet.dart';
import 'package:loono/ui/widgets/prevention/examination_confirm_sheet.dart';
import 'package:loono/ui/widgets/prevention/examination_edit_modal.dart';
import 'package:loono/ui/widgets/prevention/examination_new_sheet.dart';
import 'package:loono/ui/widgets/prevention/examination_progress_content.dart';
import 'package:loono/ui/widgets/prevention/last_visit_sheet.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class ExaminationDetail extends StatefulWidget {
  const ExaminationDetail({
    Key? key,
    required this.categorizedExamination,
    this.initialMessage,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final String? initialMessage;

  @override
  State<ExaminationDetail> createState() => _ExaminationDetailState();
}

class _ExaminationDetailState extends State<ExaminationDetail> {
  final _calendarRepository = registry.get<CalendarRepository>();

  final _calendarService = registry.get<CalendarService>();

  final _calendarEventsDao = registry.get<DatabaseService>().calendarEvents;

  final _usersDao = registry.get<DatabaseService>().users;

  ExaminationPreventionStatus get _examination => widget.categorizedExamination.examination;

  ExaminationType get _examinationType => _examination.examinationType;
  ExaminationCategoryType get _examinationCategoryType => _examination.examinationCategoryType;
  ExaminationActionType get _examinationActionType =>
      _examination.examinationActionType ?? ExaminationActionType.CONTROL;

  DateTime? get _lastPlannedVisitDate => _examination.lastConfirmedDate;
  DateTime? get _nextVisitDate => _examination.plannedDate;
  bool get _isPeriodicalExam => _examination.periodicExam == true; //Pravidelna prohlidka

  Widget get _doctorAsset => SvgPicture.asset(
        _examinationCategoryType == ExaminationCategoryType.MANDATORY
            ? _examinationType.assetPath
            : _examinationType.customExamAssetPath,
        width: 180,
      );
  String get _note => '';
  int get _hashCodeOfExam => _examination.hashCode;
  Sex get _sex {
    final user = registry.get<DatabaseService>().users.user;
    return user?.sex ?? Sex.MALE;
  }

  String _intervalYears(BuildContext context) =>
      '${widget.categorizedExamination.examination.intervalYears.toString()} ${widget.categorizedExamination.examination.intervalYears > 1 ? context.l10n.years : context.l10n.year}';

  Widget _calendarRow(String text, {VoidCallback? onTap}) => GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/icons/prevention/calendar.svg'),
            const SizedBox(width: 5),
            Text(
              text.toUpperCase(),
              style: LoonoFonts.cardSubtitle,
            ),
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.initialMessage != null) {
        showFlushBarSuccess(context, widget.initialMessage!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final lastVisitDateWithoutDay =
        widget.categorizedExamination.examination.lastConfirmedDate?.toLocal();

    final lastVisit = lastVisitDateWithoutDay != null &&
            widget.categorizedExamination.examination.state != ExaminationStatus.UNKNOWN
        ? DateFormat.yMMMM('cs-CZ').format(
            DateTime(lastVisitDateWithoutDay.year, lastVisitDateWithoutDay.month),
          )
        : l10n.skip_idk;

    final practitioner =
        procedureQuestionTitle(context, examinationType: _examinationType).toLowerCase();
    final preposition = czechPreposition(context, examinationType: _examinationType);

    /// not ideal in build method but need context
    Future<void> _onPostNewCheckupSubmit({required DateTime date}) async {
      /// code anchor: #postNewExamination
      /// TODO: Add Note property
      final response = await registry.get<ExaminationRepository>().postExamination(
            _examinationType,
            newDate: date,
            uuid: widget.categorizedExamination.examination.uuid,
            firstExam: false,
            status: ExaminationStatus.NEW,
            categoryType: _examinationCategoryType,
          );

      response.map(
        success: (res) {
          Provider.of<ExaminationsProvider>(context, listen: false)
              .updateExaminationsRecord(res.data);
          AutoRouter.of(context).popUntilRouteWithName(ExaminationDetailRoute.name);
          showFlushBarSuccess(context, l10n.checkup_reminder_toast);
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16.0),
        SizedBox(
          height: 250,
          child: Stack(
            children: [
              Positioned(
                right: -66,
                top: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(107),
                  child: Container(
                    color: LoonoColors.beigeLighter,
                    width: 207,
                    height: 207,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 66,
                          child: _doctorAsset,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),
                        Text(
                          _examinationType.l10n_name,
                          style: LoonoFonts.headerFontStyle.copyWith(
                            color: LoonoColors.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          ExaminationActionTypeExt(_examinationActionType).l10n_name,
                          style: LoonoFonts.headerFontStyle.copyWith(
                            color: LoonoColors.green,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_isPeriodicalExam)
                          _calendarRow(
                            '${context.l10n.once_per} ${_intervalYears(context)}',
                          ),
                        const SizedBox(height: 10),
                        if (_isPeriodicalExam)
                          _calendarRow(
                            '${context.l10n.last_visit}:\n$lastVisit',
                            onTap: () {
                              /// must be first exam and no planned examination should exist
                              if (!widget.categorizedExamination.examination.firstExam &&
                                  widget.categorizedExamination.examination.plannedDate != null) {
                                return;
                              }

                              /// if "nevim", open question sheet else allow to change date
                              if (widget.categorizedExamination.examination.lastConfirmedDate !=
                                  null) {
                                final title =
                                    '${_sex == Sex.MALE ? l10n.last_checkup_question_male : l10n.last_checkup_question_female} $preposition $practitioner?';
                                showChangeLastVisitSheet(
                                  context: context,
                                  title: title,
                                  examination: widget.categorizedExamination,
                                );
                              } else {
                                showLastVisitSheet(
                                  context: context,
                                  examination: widget.categorizedExamination,
                                  sex: _sex,
                                );
                              }
                            },
                          ),
                        if (!_isPeriodicalExam)
                          _calendarRow(
                            _nextVisitDate != null
                                ? DateFormat('dd.MM.yyyy HH:mm').format(_nextVisitDate!)
                                : '',
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_isPeriodicalExam || _examinationCategoryType == ExaminationCategoryType.MANDATORY)
          buildPeriodicalAndMandatorySection(context),
        buildButtons(context, _onPostNewCheckupSubmit, preposition),
        buildExaminationBadges(context),
        const SizedBox(height: 40),
        //SHOWING FAQ Section only for Default
        if (_isPeriodicalExam && _examinationCategoryType == ExaminationCategoryType.MANDATORY)
          FaqSection(examinationType: _examinationType),
        const SizedBox(height: 20),
        if (_nextVisitDate != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextFormField(
              minLines: 5,
              maxLines: 10,
              maxLength: 256,
              keyboardType: TextInputType.multiline,
              initialValue: _note,
              enabled: false,
              decoration: InputDecoration(
                hintText: context.l10n.note_visiting_description,
                label: Text(context.l10n.note_visiting),
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'Další prohlídky u specialisty',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(height: 20),
        buildNextSpecialistExams(context)
      ],
    );
  }

  Widget buildPeriodicalAndMandatorySection(
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              context.l10n.early_ordering,
              textAlign: TextAlign.right,
              style: earlyOrderStyles(widget.categorizedExamination),
            ),
          ),
        ),
        ExaminationProgressContent(
          categorizedExamination: widget.categorizedExamination,
          sex: _sex,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              context.l10n.preventive_inspection,
              style: preventiveInspectionStyles(widget.categorizedExamination.category),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtons(
    BuildContext context,
    Future<void> Function({required DateTime date}) onPostNewCheckupSubmit,
    String preposition,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          // displays calendar button for the scheduled check-ups which did not happen yet
          if (_nextVisitDate != null &&
              [
                const ExaminationCategory.scheduled(),
                const ExaminationCategory.scheduledSoonOrOverdue()
              ].contains(widget.categorizedExamination.category)) ...[
            StreamBuilder<CalendarEvent?>(
              stream: _calendarEventsDao.watch(_examinationType),
              builder: (streamContext, snapshot) {
                final isCheckupInCalendar = snapshot.hasData;
                final isCheckupAfterNow = _nextVisitDate!.isAfter(DateTime.now());
                if (!isCheckupInCalendar && isCheckupAfterNow) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 19),
                      child: LoonoButton.light(
                        key: const Key('examinationDetailPage_btn_calendar'),
                        text: context.l10n.examination_detail_add_to_calendar_button,
                        onTap: () async {
                          final autoRouter = AutoRouter.of(context);
                          final hasPermissionsGranted =
                              await _calendarService.hasPermissionsGranted();
                          if (hasPermissionsGranted) {
                            final defaultDeviceCalendarId = _usersDao.user?.defaultDeviceCalendarId;
                            if (defaultDeviceCalendarId != null) {
                              // default device calendar id is set, do not display list of calendars
                              await _calendarRepository.createEvent(
                                _examinationType,
                                deviceCalendarId: defaultDeviceCalendarId,
                                startingDate: _nextVisitDate!,
                              );
                              //TODO: Fix lint...
                              // ignore: use_build_context_synchronously
                              showFlushBarSuccess(
                                context,
                                context.l10n.calendar_added_success_message,
                              );
                            } else {
                              await autoRouter.push(
                                CalendarListRoute(
                                  examinationRecord: widget.categorizedExamination.examination,
                                ),
                              );
                            }
                          } else {
                            final result = await autoRouter.push<bool>(
                              CalendarPermissionInfoRoute(
                                examinationRecord: widget.categorizedExamination.examination,
                              ),
                            );
                            // permission was permanently denied, show permission settings guide
                            if (result == false) {
                              //TODO: Fix lint...
                              // ignore: use_build_context_synchronously
                              showCalendarPermissionSheet(context);
                            }
                          }
                        },
                      ),
                    ),
                  );
                }
                return !isCheckupAfterNow
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 19),
                          child: LoonoButton(
                            text: _sex == Sex.MALE
                                ? context.l10n.checkup_confirmation_male
                                : context.l10n.checkup_confirmation_female,
                            onTap: () {
                              showConfirmationSheet(
                                context,
                                widget.categorizedExamination.examination.examinationType,
                                _sex,
                                widget.categorizedExamination.examination.uuid,
                                awardPoints: widget.categorizedExamination.examination.points,
                              );
                            },
                          ),
                        ),
                      )
                    // hides calendar button if the event is already added in the device calendar
                    : const SizedBox.shrink();
              },
            ),
            Expanded(
              child: LoonoButton.light(
                key: const Key('examinationDetailPage_btn_updateDate'),
                text: context.l10n.examination_detail_edit_date_button,
                onTap: () => showEditModal(context, widget.categorizedExamination),
              ),
            ),
          ] else if ([
            const ExaminationCategory.unknownLastVisit(),
            const ExaminationCategory.newToSchedule(),
            const ExaminationCategory.waiting()
          ].contains(widget.categorizedExamination.category)) ...[
            Expanded(
              child: LoonoButton(
                key: const Key('examinationDetailPage_btn_order'),
                text: context.l10n.examination_detail_order_examination, //objednat se
                onTap: () => showNewCheckupSheetStep1(
                  context,
                  widget.categorizedExamination,
                  onPostNewCheckupSubmit,
                  _sex,
                ),
              ),
            ),
            const SizedBox(width: 19),
            Expanded(
              child: LoonoButton.light(
                text: context.l10n.examination_detail_set_examination_button, //mám objednáno
                onTap: () => showDatePickerSheet(
                  context: context,
                  categorizedExamination: widget.categorizedExamination,
                  onSubmit: onPostNewCheckupSubmit,
                  isNewCheckup: true,
                  firstStepTitle:
                      '${_sex == Sex.MALE ? context.l10n.checkup_new_date_title_male : context.l10n.checkup_new_date_title_female} $preposition ${examinationTypeCasus(
                    context,
                    casus: Casus.genitiv,
                    examinationType: _examinationType,
                  ).toUpperCase()}?',
                  secondStepTitle:
                      '${context.l10n.checkup_new_time_title} $preposition ${examinationTypeCasus(
                    context,
                    casus: Casus.nomativ,
                    examinationType: _examinationType,
                  ).toLowerCase()}',
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget buildExaminationBadges(BuildContext context) {
    return _isPeriodicalExam
        ? ExaminationBadges(
            examinationType: _examinationType,
            categorizedExamination: widget.categorizedExamination,
          )
        : Container();
  }

  Widget buildNextSpecialistExams(BuildContext context) {
    final examProvider = Provider.of<ExaminationsProvider>(context, listen: true);
    final specialistExams = examProvider.examinations?.examinations
        .toList()
        .where(
          (exam) => exam.examinationType == _examinationType && exam.hashCode != _hashCodeOfExam,
        )
        .toList();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: specialistExams!.isNotEmpty
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: specialistExams.length,
              itemBuilder: (context, index) {
                final item = specialistExams[index];
                return specialistCard(context, item);
              },
            )
          : Center(
              child: Text(
                context.l10n.not_other_examinaiton,
                style: LoonoFonts.fontStyle,
              ),
            ),
    );
  }

  Widget specialistCard(BuildContext context, ExaminationPreventionStatus? item) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(
          ExaminationDetailRoute(
            categorizedExamination: widget.categorizedExamination,
            choosedExamination: item,
          ),
        );
      },
      child: SizedBox(
        height: 80,
        child: Card(
          color: LoonoColors.primaryLight,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (item?.examinationActionType != null)
                      Text(
                        ExaminationActionTypeExt(item!.examinationActionType!).l10n_name,
                        style: LoonoFonts.cardTitle,
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (item?.plannedDate != null)
                      _calendarRow(
                        DateFormat('dd.MM.yyyy HH:mm').format(item!.plannedDate!),
                      )
                  ],
                ),
                SvgPicture.asset('assets/icons/next_icon.svg')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
