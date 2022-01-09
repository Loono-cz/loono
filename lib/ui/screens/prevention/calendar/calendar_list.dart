import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/services/calendar_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/registry.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarListScreen extends StatefulWidget {
  const CalendarListScreen({
    Key? key,
    required this.examinationRecord,
  }) : super(key: key);

  final ExaminationRecord examinationRecord;

  @override
  State<CalendarListScreen> createState() => _CalendarListScreenState();
}

class _CalendarListScreenState extends State<CalendarListScreen> {
  final _calendarRepository = registry.get<CalendarRepository>();
  final _calendarService = registry.get<CalendarService>();

  late final Future<UnmodifiableListView<Calendar>> _deviceCalendarsFuture;
  late final String _timezone;

  @override
  void initState() {
    super.initState();
    _deviceCalendarsFuture = _calendarService.retrieveDeviceCalendars();
    _initTz();
  }

  Future<String> _initTz() async => _timezone = await FlutterNativeTimezone.getLocalTimezone();

  ExaminationRecord get examinationRecord => widget.examinationRecord;

  DateTime? get nextVisitDate => examinationRecord.nextVisitDate;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: LoonoColors.bottomSheetPrevention,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: LoonoColors.black),
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => AutoRouter.of(context).pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Text(
                l10n.calendar_list_header,
                style: LoonoFonts.headerFontStyle,
              ),
              const SizedBox(height: 45),
              Expanded(
                child: FutureBuilder<UnmodifiableListView<Calendar>>(
                  future: _deviceCalendarsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final calendars =
                          snapshot.data!.where((c) => c.isReadOnly == false && c.id != null);

                      // TODO: Handle this case
                      if (calendars.isEmpty) return const Center(child: Text('Žádné kalendáře'));

                      return ListView.builder(
                        itemCount: calendars.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final calendar = calendars.elementAt(index);

                          if (calendar.id == null) return const SizedBox.shrink();
                          return GestureDetector(
                            onTap: () async {
                              final calendarId = calendar.id!;

                              final event = Event(
                                calendarId,
                                start: tz.TZDateTime.from(
                                  nextVisitDate!,
                                  tz.getLocation(_timezone),
                                ),
                                end: tz.TZDateTime.from(
                                  nextVisitDate!.add(const Duration(hours: 1)),
                                  tz.getLocation(_timezone),
                                ),
                                // TODO: Texts (https://cesko-digital.atlassian.net/browse/LOON-415)
                                title:
                                    'TODO: Preventivní prohlídka - ${examinationRecord.examinationType.name}',
                                description: 'TODO: popisek',
                              );
                              final result = await _calendarRepository.createEvent(
                                event: event,
                                examinationType: examinationRecord.examinationType,
                                startingDate: nextVisitDate!,
                              );
                              if (result) {
                                showSnackBarSuccess(
                                  context,
                                  message: l10n.calendar_added_success_message,
                                );
                                AutoRouter.of(context).pop();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(calendar.color ?? 0xFFFFFFFF),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      calendar.name ??
                                          '${l10n.calendar_unknown_name} ${calendar.id}',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              const SizedBox(height: 30),
              // TODO: Figma UI might not be final yet
              Visibility(
                visible: false,
                child: LoonoButton(
                  text: l10n.calendar_choose_calendar_button,
                  enabled: false,
                  onTap: null,
                ),
              ),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
