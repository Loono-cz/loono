import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/type_converters.dart';
import 'package:loono/services/db/database.dart';
import 'package:moor/moor.dart';

part 'calendar_event.g.dart';

class CalendarEvents extends Table {
  @override
  Set<Column> get primaryKey => {type};

  TextColumn get type => text().map(const ExaminationDbTypeConverter())();

  TextColumn get deviceCalendarId => text()();

  TextColumn get calendarEventId => text()();

  DateTimeColumn get date => dateTime()();
}

@UseDao(tables: [CalendarEvents])
class CalendarEventsDao extends DatabaseAccessor<AppDatabase> with _$CalendarEventsDaoMixin {
  CalendarEventsDao(AppDatabase db) : super(db);

  Future<CalendarEvent?> get(ExaminationType examinationType) => (select(calendarEvents)
        ..where(
          (tbl) => tbl.type.equals(const ExaminationDbTypeConverter().mapToSql(examinationType)),
        ))
      .getSingleOrNull();

  Future<List<CalendarEvent>> getAll() => select(calendarEvents).get();

  Stream<CalendarEvent?> watch(ExaminationType examinationType) => (select(calendarEvents)
        ..where(
          (tbl) => tbl.type.equals(const ExaminationDbTypeConverter().mapToSql(examinationType)),
        ))
      .watchSingleOrNull();

  Stream<List<CalendarEvent>> watchAll() => select(calendarEvents).watch();

  Future<void> addOrUpdateEvent(CalendarEvent event) async {
    await into(calendarEvents).insertOnConflictUpdate(event);
  }

  Future<void> updateEvent(CalendarEventsCompanion calendarEventsCompanion) async {
    await update(calendarEvents).write(calendarEventsCompanion);
  }
}
