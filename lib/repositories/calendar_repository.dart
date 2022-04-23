import 'package:device_calendar/device_calendar.dart';
import 'package:drift/drift.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/services/calendar_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarRepository {
  const CalendarRepository({
    required DatabaseService databaseService,
    required CalendarService calendarService,
  })  : _db = databaseService,
        _calendarService = calendarService;

  final DatabaseService _db;
  final CalendarService _calendarService;

  Future<Event> _getDefaultCheckupEvent({
    required ExaminationType examinationType,
    required String deviceCalendarId,
    String? deviceCalendarEventId,
    required DateTime startingDate,
  }) async {
    final timezone = await FlutterNativeTimezone.getLocalTimezone();
    return Event(
      deviceCalendarId,
      eventId: deviceCalendarEventId,
      reminders: [
        Reminder(minutes: const Duration(hours: 2).inMinutes),
        Reminder(minutes: const Duration(hours: 24).inMinutes),
      ],
      start: tz.TZDateTime.from(startingDate, tz.getLocation(timezone)),
      end: tz.TZDateTime.from(startingDate.add(const Duration(hours: 1)), tz.getLocation(timezone)),
      title: '${examinationType.l10n_name} - preventivní prohlídka [Preventivka]',
    );
  }

  Future<bool> createEvent(
    ExaminationType examinationType, {
    required String deviceCalendarId,
    required DateTime startingDate,
  }) async {
    final event = await _getDefaultCheckupEvent(
      examinationType: examinationType,
      deviceCalendarId: deviceCalendarId,
      startingDate: startingDate,
    );
    final eventId = await _calendarService.createOrUpdateEvent(event);
    if (eventId != null) {
      final calendarId = event.calendarId;
      if (calendarId != null) {
        final dbEvent = CalendarEvent(
          type: examinationType,
          deviceCalendarId: event.calendarId!,
          calendarEventId: eventId,
          date: startingDate,
        );
        await _db.calendarEvents.addOrUpdateEvent(dbEvent);
        await registry.get<FirebaseAnalytics>().logEvent(name: 'AddVisitToCalendar');
        return true;
      }
    }
    debugPrint('DEBUG: calendar or event id is null');
    return false;
  }

  Future<void> updateEventDate(
    ExaminationType examinationType, {
    required DateTime newDate,
  }) async {
    final existingDbEvent = await _db.calendarEvents.get(examinationType);
    if (existingDbEvent != null) {
      final deviceEvent = await _getDefaultCheckupEvent(
        examinationType: examinationType,
        deviceCalendarId: existingDbEvent.deviceCalendarId,
        deviceCalendarEventId: existingDbEvent.calendarEventId,
        startingDate: newDate,
      );
      final eventId = await _calendarService.createOrUpdateEvent(deviceEvent);
      if (eventId != null) {
        await _db.calendarEvents.updateEvent(
          examinationType,
          calendarEventsCompanion: CalendarEventsCompanion(date: Value(newDate)),
        );
        await registry.get<FirebaseAnalytics>().logEvent(name: 'UpdateVisitInCalendar');
      } else {
        debugPrint(
          'DEBUG: there was an "existingDbCalendarEvent" but it was not updated in the device calendar',
        );
      }
    }
  }

  Future<void> deleteEvent(ExaminationType examinationType) async {
    final existingDbEvent = await _db.calendarEvents.get(examinationType);
    if (existingDbEvent != null) {
      await _db.calendarEvents.deleteEvent(examinationType);
      final result = await _calendarService.deleteEvent(
        calendarId: existingDbEvent.deviceCalendarId,
        eventId: existingDbEvent.calendarEventId,
      );
      await registry.get<FirebaseAnalytics>().logEvent(name: 'RemoveVisitFromCalendar');
      if (!result) {
        debugPrint(
          'DEBUG: there was an "existingDbCalendarEvent" but it was not removed from the device calendar',
        );
      }
    }
  }

  /// This will only delete an event in the database but **not** from the **device calendar**.
  ///
  /// The use-case is when for example a user confirms a check-up visit, we want to keep the event
  /// in the device calendar so the user does not lose the track of it.
  Future<void> deleteOnlyDbEvent(ExaminationType examinationType) async {
    await _db.calendarEvents.deleteEvent(examinationType);
  }
}
