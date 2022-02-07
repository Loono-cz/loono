import 'package:loono/helpers/type_converters.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono_api/loono_api.dart';
import 'package:moor/moor.dart';

part 'calendar_event.g.dart';

class CalendarEvents extends Table {
  @override
  Set<Column> get primaryKey => {type};

  TextColumn get type => text().map(const ExaminationTypeEnumDbConverter())();

  TextColumn get deviceCalendarId => text()();

  TextColumn get calendarEventId => text()();

  DateTimeColumn get date => dateTime()();
}

@UseDao(tables: [CalendarEvents])
class CalendarEventsDao extends DatabaseAccessor<AppDatabase> with _$CalendarEventsDaoMixin {
  CalendarEventsDao(AppDatabase db) : super(db);

  Future<CalendarEvent?> get(ExaminationTypeEnum examinationType) => (select(calendarEvents)
        ..where(
          (tbl) =>
              tbl.type.equals(const ExaminationTypeEnumDbConverter().mapToSql(examinationType)),
        ))
      .getSingleOrNull();

  Future<List<CalendarEvent>> getAll() => select(calendarEvents).get();

  Stream<CalendarEvent?> watch(ExaminationTypeEnum examinationType) => (select(calendarEvents)
        ..where(
          (tbl) =>
              tbl.type.equals(const ExaminationTypeEnumDbConverter().mapToSql(examinationType)),
        ))
      .watchSingleOrNull();

  Stream<List<CalendarEvent>> watchAll() => select(calendarEvents).watch();

  Future<void> addOrUpdateEvent(CalendarEvent event) async {
    await into(calendarEvents).insertOnConflictUpdate(event);
  }

  Future<void> updateEvent(
    ExaminationTypeEnum examinationType, {
    required CalendarEventsCompanion calendarEventsCompanion,
  }) async {
    await (update(calendarEvents)
          ..where(
            (tbl) =>
                tbl.type.equals(const ExaminationTypeEnumDbConverter().mapToSql(examinationType)),
          ))
        .write(calendarEventsCompanion);
  }

  Future<void> deleteEvent(ExaminationTypeEnum examinationType) async {
    await (delete(calendarEvents)
          ..where(
            (tbl) =>
                tbl.type.equals(const ExaminationTypeEnumDbConverter().mapToSql(examinationType)),
          ))
        .go();
  }
}
