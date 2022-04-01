import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/calendar_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class CalendarListScreen extends StatefulWidget {
  const CalendarListScreen({
    Key? key,
    required this.examinationRecord,
  }) : super(key: key);

  final ExaminationPreventionStatus examinationRecord;

  @override
  State<CalendarListScreen> createState() => _CalendarListScreenState();
}

class _CalendarListScreenState extends State<CalendarListScreen> {
  final _calendarRepository = registry.get<CalendarRepository>();
  final _calendarService = registry.get<CalendarService>();
  final _userRepository = registry.get<UserRepository>();

  late final Future<UnmodifiableListView<Calendar>> _deviceCalendarsFuture;

  @override
  void initState() {
    super.initState();
    _deviceCalendarsFuture = _calendarService.retrieveDeviceCalendars();
  }

  String? _calendarIdChoice;

  ExaminationPreventionStatus get examinationRecord => widget.examinationRecord;

  DateTime? get nextVisitDate => examinationRecord.plannedDate;

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
                      if (calendars.length == 1) {
                        WidgetsBinding.instance?.scheduleFrameCallback((_) {
                          setState(() => _calendarIdChoice = calendars.first.id);
                        });
                      }

                      return ListView.builder(
                        itemCount: calendars.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final calendar = calendars.elementAt(index);

                          return ListTile(
                            onTap: () => setState(() => _calendarIdChoice = calendar.id),
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
                                value: calendar.id,
                                groupValue: _calendarIdChoice,
                                activeColor: LoonoColors.primaryEnabled,
                                onChanged: (choice) => setState(() => _calendarIdChoice = choice),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              const SizedBox(height: 30),
              LoonoButton(
                text: l10n.calendar_choose_calendar_button,
                enabled: _calendarIdChoice != null,
                onTap: () async {
                  final result = await _calendarRepository.createEvent(
                    examinationRecord.examinationType,
                    deviceCalendarId: _calendarIdChoice!,
                    startingDate: nextVisitDate!,
                  );
                  if (result) {
                    await _userRepository.updateDeviceCalendarId(_calendarIdChoice!);
                    showFlushBarSuccess(
                      context,
                      l10n.calendar_added_success_message,
                    );
                    await AutoRouter.of(context).pop();
                  }
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
