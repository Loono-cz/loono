import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/services/calendar_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/registry.dart';

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
  final _calendarIdChoice = ValueNotifier<String?>(null);

  late final Future<UnmodifiableListView<Calendar>> _deviceCalendarsFuture;

  @override
  void initState() {
    super.initState();
    _deviceCalendarsFuture = _calendarService.retrieveDeviceCalendars();
  }

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
            icon: const Icon(Icons.close, size: 22),
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

                      return ValueListenableBuilder<String?>(
                        valueListenable: _calendarIdChoice,
                        builder: (context, calendarChoiceValue, child) {
                          return ListView.builder(
                            itemCount: calendars.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final calendar = calendars.elementAt(index);

                              if (calendar.id == null) return const SizedBox.shrink();
                              if (calendars.length == 1) {
                                WidgetsBinding.instance?.scheduleFrameCallback((_) {
                                  _calendarIdChoice.value = calendars.first.id;
                                });
                              }
                              return ListTile(
                                onTap: () => _calendarIdChoice.value = calendar.id,
                                leading: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(calendar.color ?? 0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                                minLeadingWidth: 20,
                                title: Text(
                                  calendar.name ?? '${l10n.calendar} ${calendar.id ?? ''}',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                trailing: Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: LoonoColors.grey,
                                  ),
                                  child: Radio<String?>(
                                    value: calendars.elementAt(index).id,
                                    groupValue: calendarChoiceValue,
                                    activeColor: LoonoColors.primaryEnabled,
                                    onChanged: (choice) => _calendarIdChoice.value = choice,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              const SizedBox(height: 30),
              ValueListenableBuilder<String?>(
                valueListenable: _calendarIdChoice,
                builder: (context, calendarChoiceValue, child) {
                  return LoonoButton(
                    text: l10n.calendar_choose_calendar_button,
                    enabled: calendarChoiceValue != null,
                    onTap: () async {
                      final result = await _calendarRepository.createEvent(
                        examinationRecord.examinationType,
                        deviceCalendarId: calendarChoiceValue!,
                        startingDate: nextVisitDate!,
                      );
                      if (result) {
                        showSnackBarSuccess(
                          context,
                          message: l10n.calendar_added_success_message,
                        );
                        await AutoRouter.of(context).pop();
                      }
                    },
                  );
                },
              ),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
