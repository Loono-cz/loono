import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/calendar_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/screens/prevention/examination_detail/faq_section.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/prevention/calendar_permission_sheet.dart';
import 'package:loono/ui/widgets/prevention/checkup_confirmation_sheet.dart';
import 'package:loono/ui/widgets/prevention/checkup_edit_modal.dart';
import 'package:loono/ui/widgets/prevention/examination_progress_content.dart';
import 'package:loono/ui/widgets/prevention/last_visit_sheet.dart';
import 'package:loono/ui/widgets/prevention/show_order_checkup_sheet.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationDetail extends StatelessWidget {
  ExaminationDetail({
    Key? key,
    required this.categorizedExamination,
  }) : super(key: key);

  final _calendarRepository = registry.get<CalendarRepository>();
  final _calendarService = registry.get<CalendarService>();
  final _calendarEventsDao = registry.get<DatabaseService>().calendarEvents;
  final _usersDao = registry.get<DatabaseService>().users;

  final CategorizedExamination categorizedExamination;

  /// TODO: replace skipped date for "posledni prohlidka: nevim" from db or api
  final lastVisitSkippedDate = DateTime.now().subtract(
    const Duration(days: 60),
  );

  ExaminationTypeEnum get _examinationType => categorizedExamination.examination.examinationType;

  DateTime? get _nextVisitDate => categorizedExamination.examination.nextVisitDate;

  Widget get _doctorAsset => SvgPicture.asset(_examinationType.assetPath, width: 180);

  Sex get _sex {
    final user = registry.get<DatabaseService>().users.user;
    return user?.sex ?? Sex.MALE;
  }

  String _intervalYears(BuildContext context) =>
      '${categorizedExamination.examination.interval.toString()} ${categorizedExamination.examination.interval > 1 ? context.l10n.years : context.l10n.year}';

  Widget _calendarRow(String text, {VoidCallback? onTap}) => GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/icons/prevention/calendar.svg'),
            const SizedBox(width: 5),
            Text(
              text,
              style: LoonoFonts.cardSubtitle,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final lastVisitDateWithoutDay = categorizedExamination.examination.lastVisitDate;

    final lastVisit = lastVisitDateWithoutDay != null
        ? DateFormat.yMMMM('cs-CZ').format(
            DateTime(lastVisitDateWithoutDay.year, lastVisitDateWithoutDay.month.index + 1),
          )
        : context.l10n.never;

    final practitioner =
        procedureQuestionTitle(context, examinationType: _examinationType).toLowerCase();
    final preposition = czechPreposition(context, examinationType: _examinationType);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        SizedBox(
          height: 207,
          child: Stack(
            children: [
              Positioned(
                right: -66,
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
                    padding: const EdgeInsets.only(left: 10.0, top: 16),
                    child: IconButton(
                      onPressed: () {
                        AutoRouter.of(context).pop();
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/arrow_back.svg',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),
                        Text(
                          _examinationType.l10n_name.toUpperCase(),
                          style: LoonoFonts.headerFontStyle.copyWith(
                            color: LoonoColors.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _calendarRow(
                          '${context.l10n.once_per} ${_intervalYears(context)}',
                        ),
                        const SizedBox(height: 10),
                        _calendarRow(
                          '${context.l10n.last_visit}:\n$lastVisit',
                          onTap: () {
                            if (lastVisitDateWithoutDay != null &&
                                categorizedExamination.examination.id != null) {
                              AutoRouter.of(context).navigate(
                                ChangeLastVisitRoute(
                                  originalDate: DateTime(
                                    lastVisitDateWithoutDay.year,
                                    lastVisitDateWithoutDay.month.index,
                                  ),
                                  // refactor after api UUID and ID inconsistency fix
                                  uuid: categorizedExamination.examination.id,
                                  title:
                                      '${l10n.change_last_visit_title} $preposition $practitioner',
                                  examinationType: _examinationType,
                                  status: categorizedExamination.category,
                                ),
                              );
                            } else {
                              showLastVisitSheet(
                                context: context,
                                // refactor after api UUID and ID inconsistency fix
                                uuid: categorizedExamination.examination.id,
                                examinationType: _examinationType,
                                sex: _sex,
                                examinationIntervalYears:
                                    categorizedExamination.examination.interval,
                                skippedDate: lastVisitSkippedDate,
                                status: categorizedExamination.category,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  context.l10n.early_ordering,
                  textAlign: TextAlign.right,
                  style: earlyOrderStyles(categorizedExamination),
                ),
              ),
            ),
            ExaminationProgressContent(
              categorizedExamination: categorizedExamination,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  context.l10n.preventive_inspection,
                  style: preventiveInspectionStyles(categorizedExamination.category),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              // displays calendar button for the scheduled check-ups which did not happen yet
              if (_nextVisitDate != null &&
                  [
                    const ExaminationCategory.scheduled(),
                    const ExaminationCategory.scheduledSoonOrOverdue()
                  ].contains(categorizedExamination.category)) ...[
                StreamBuilder<CalendarEvent?>(
                  stream: _calendarEventsDao.watch(_examinationType),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        child: Row(
                          children: [
                            if (_nextVisitDate!.isAfter(DateTime.now()))
                              Expanded(
                                child: LoonoButton.light(
                                  text: l10n.examination_detail_add_to_calendar_button,
                                  onTap: () async {
                                    final hasPermissionsGranted =
                                        await _calendarService.hasPermissionsGranted();
                                    if (hasPermissionsGranted) {
                                      final defaultDeviceCalendarId =
                                          _usersDao.user?.defaultDeviceCalendarId;
                                      if (defaultDeviceCalendarId != null) {
                                        // default device calendar id is set, do not display list of calendars
                                        await _calendarRepository.createEvent(
                                          _examinationType,
                                          deviceCalendarId: defaultDeviceCalendarId,
                                          startingDate: _nextVisitDate!,
                                        );
                                        showSnackBarSuccess(
                                          context,
                                          message: l10n.calendar_added_success_message,
                                        );
                                      } else {
                                        await AutoRouter.of(context).push(
                                          CalendarListRoute(
                                            examinationRecord: categorizedExamination.examination,
                                          ),
                                        );
                                      }
                                    } else {
                                      final result = await AutoRouter.of(context).push<bool>(
                                        CalendarPermissionInfoRoute(
                                          examinationRecord: categorizedExamination.examination,
                                        ),
                                      );
                                      // permission was permanently denied, show permission settings guide
                                      if (result == false) {
                                        showCalendarPermissionSheet(context);
                                      }
                                    }
                                  },
                                ),
                              )
                            else
                              Expanded(
                                child: LoonoButton(
                                  text: _sex == Sex.MALE
                                      ? l10n.checkup_confirmation_male
                                      : l10n.checkup_confirmation_female,
                                  onTap: () {
                                    showConfirmationSheet(
                                      context,
                                      categorizedExamination.examination.examinationType,
                                      _sex,
                                      categorizedExamination.examination.id,
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                    // hides calendar button if the event is already added in the device calendar
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(width: 19),
                Expanded(
                  child: LoonoButton.light(
                    text: l10n.examination_detail_edit_date_button,
                    onTap: () => showEditModal(context, categorizedExamination),
                  ),
                ),
              ] else if ([
                const ExaminationCategory.unknownLastVisit(),
                const ExaminationCategory.newToSchedule()
              ].contains(categorizedExamination.category)) ...[
                Expanded(
                  child: LoonoButton(
                    text: l10n.examination_detail_order_examination, //objednej se
                    onTap: () => showOrderCheckupSheetStep1(context, categorizedExamination),
                  ),
                ),
                const SizedBox(width: 19),
                Expanded(
                  child: LoonoButton.light(
                    text: l10n.examination_detail_set_examination_button, //mám objednáno
                    onTap: () => AutoRouter.of(context).push(
                      NewDateRoute(
                        categorizedExamination: categorizedExamination,
                        showCancelIcon: false,
                      ),
                    ),
                  ),
                ),
              ] else if (categorizedExamination.category ==
                  const ExaminationCategory.waiting()) ...[
                Expanded(
                  /// tried connection the same calendar logic here as above, but calendar event didn't work
                  child: LoonoButton.light(
                    text: 'pridat_do_kalendare',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 19),
                Expanded(
                  child: LoonoButton.light(
                    text: 'mam_objednano',
                    onTap: () {},
                  ),
                ),
              ]
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        FaqSection(
          examinationType: _examinationType,
        ),
      ],
    );
  }
}
