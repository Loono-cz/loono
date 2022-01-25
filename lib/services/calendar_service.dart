import 'dart:collection';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/foundation.dart';

class CalendarService {
  CalendarService({
    required DeviceCalendarPlugin deviceCalendarPlugin,
  }) : _deviceCalendarPlugin = deviceCalendarPlugin;

  final DeviceCalendarPlugin _deviceCalendarPlugin;

  /// Gets the permission status of writing and reading from the calendar.
  ///
  /// Returns `true` if permission is granted.
  Future<bool> hasPermissionsGranted() async {
    final permissionResult = await _deviceCalendarPlugin.hasPermissions();
    if (permissionResult.isSuccess && permissionResult.data == true) {
      return true;
    }
    return false;
  }

  /// Prompts the user for permission to write and read from the calendar.
  ///
  /// Returns `true` if permission was granted.
  Future<bool> promptPermissions() async {
    var permissionResult = await _deviceCalendarPlugin.hasPermissions();
    if (permissionResult.isSuccess && permissionResult.data == false) {
      permissionResult = await _deviceCalendarPlugin.requestPermissions();
    }
    return permissionResult.isSuccess && permissionResult.data == true;
  }

  /// Retrieves user's device calendars.
  ///
  /// Must have granted the calendar permissions beforehand.
  Future<UnmodifiableListView<Calendar>> retrieveDeviceCalendars() async {
    final calendars = await _deviceCalendarPlugin.retrieveCalendars();
    return calendars.isSuccess ? calendars.data! : UnmodifiableListView(<Calendar>[]);
  }

  /// Creates or updates an event in the device calendar.
  ///
  /// Returns `eventId` of the created/updated event or `null` if an error has occurred.
  Future<String?> createOrUpdateEvent(Event event) async {
    final result = await _deviceCalendarPlugin.createOrUpdateEvent(event);
    if (result == null) return null;
    if (result.isSuccess) return result.data;
    if (result.hasErrors) debugPrint(result.errors.map((e) => e.errorMessage).toString());
    return null;
  }

  /// Deletes an event from the device calendar.
  ///
  /// Returns `true` if the operation was successful.
  Future<bool> deleteEvent({
    required String calendarId,
    required String eventId,
  }) async {
    final result = await _deviceCalendarPlugin.deleteEvent(calendarId, eventId);
    return result.isSuccess && result.data == true;
  }
}
