import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/services/calendar_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';

class CalendarRepository {
  const CalendarRepository({
    required DatabaseService databaseService,
    required CalendarService calendarService,
  })  : _db = databaseService,
        _calendarService = calendarService;

  final DatabaseService _db;
  final CalendarService _calendarService;

  Future<bool> createEvent({
    required Event event,
    required ExaminationRecord examinationRecord,
  }) async {
    final eventId = await _calendarService.createOrUpdateEvent(event);
    if (eventId != null) {
      final calendarId = event.calendarId;
      if (calendarId != null) {
        final dbEvent = CalendarEvent(
          type: examinationRecord.examinationType,
          deviceCalendarId: event.calendarId!,
          calendarEventId: eventId,
          date: examinationRecord.nextVisitDate!,
        );
        await _db.calendarEvents.addOrUpdateEvent(dbEvent);
        return true;
      }
    }
    debugPrint('DEBUG: calendar or event id is null');
    return false;
  }

  // TODO:
  Future<void> updateEventDate() async {
    //
  }

  // TODO:
  Future<void> deleteEvent() async {
    //
  }
}
