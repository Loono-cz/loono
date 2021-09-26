import 'dart:convert';

import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/memoized_stream.dart';
import 'package:moor/moor.dart';

part 'user.g.dart';

enum CcaDoctorVisit {
  inLastTwoYears,
  moreThanTwoYearsOrIdk,
}

class Users extends Table {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get id => text()();

  IntColumn get sexRaw => integer().nullable()();
  TextColumn get dateOfBirthRaw => text().nullable()();
  IntColumn get generalPracticionerCcaVisitRaw => integer().nullable()();
  TextColumn get generalPracticionerVisitDateRaw => text().nullable()();
  IntColumn get gynecologyCcaVisitRaw => integer().nullable()();
  TextColumn get gynecologyVisitDateRaw => text().nullable()();
  IntColumn get dentistCcaVisitRaw => integer().nullable()();
  TextColumn get dentistVisitDateRaw => text().nullable()();

  TextColumn get nickname => text().nullable()();
  TextColumn get email => text().nullable()();
}

@UseDao(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  UsersDao(AppDatabase db) : super(db) {
    userStream = MemoizedStream(watchUser());
  }

  late final MemoizedStream<User?> userStream;
  User? get user => userStream.lastItem;

  Stream<User?> watchUser() {
    return select(users).watchSingleOrNull();
  }

  Future<List<User>> getUser() {
    return select(users).get();
  }

  Future<void> deleteAll() async {
    await delete(users).go();
  }

  Future<void> updateCurrentUser(UsersCompanion usersCompanion) async {
    await update(users).write(usersCompanion);
  }

  Future<void> upsert(User user) async {
    await into(users).insertOnConflictUpdate(user);
  }

  Future<void> updateSex(Sex sex) async {
    await updateCurrentUser(UsersCompanion(sexRaw: Value(sex.index)));
  }

  Future<void> updateDateOfBirth(DateWithoutDay dateWithoutDay) async {
    await updateCurrentUser(
        UsersCompanion(dateOfBirthRaw: Value(jsonEncode(dateWithoutDay.toJson()))));
  }

  Future<void> updateGeneralPracticionerCcaVisit(CcaDoctorVisit ccaDoctorVisit) async {
    await updateCurrentUser(
        UsersCompanion(generalPracticionerCcaVisitRaw: Value(ccaDoctorVisit.index)));
  }

  Future<void> updateGeneralPracticionerVisitDate(DateWithoutDay dateWithoutDay) async {
    await updateCurrentUser(UsersCompanion(
        generalPracticionerVisitDateRaw: Value(jsonEncode(dateWithoutDay.toJson()))));
  }

  Future<void> updateGynecologyCcaVisit(CcaDoctorVisit ccaDoctorVisit) async {
    await updateCurrentUser(UsersCompanion(gynecologyCcaVisitRaw: Value(ccaDoctorVisit.index)));
  }

  Future<void> updateGynecologyVisitDate(DateWithoutDay dateWithoutDay) async {
    await updateCurrentUser(
        UsersCompanion(gynecologyVisitDateRaw: Value(jsonEncode(dateWithoutDay.toJson()))));
  }

  Future<void> updateDentistCcaVisit(CcaDoctorVisit ccaDoctorVisit) async {
    await updateCurrentUser(UsersCompanion(dentistCcaVisitRaw: Value(ccaDoctorVisit.index)));
  }

  Future<void> updateDentistVisitDate(DateWithoutDay dateWithoutDay) async {
    await updateCurrentUser(
        UsersCompanion(dentistVisitDateRaw: Value(jsonEncode(dateWithoutDay.toJson()))));
  }

  Future<void> updateNickname(String nickname) async {
    await updateCurrentUser(UsersCompanion(nickname: Value(nickname)));
  }

  Future<void> updateEmail(String email) async {
    await updateCurrentUser(UsersCompanion(email: Value(email)));
  }
}

extension UserExtension on User {
  Sex? get sex => sexRaw == null ? null : Sex.values[sexRaw!];

  CcaDoctorVisit? get generalPracticionerCcaVisit => generalPracticionerCcaVisitRaw == null
      ? null
      : CcaDoctorVisit.values[generalPracticionerCcaVisitRaw!];

  CcaDoctorVisit? get gynecologyCcaVisit =>
      gynecologyCcaVisitRaw == null ? null : CcaDoctorVisit.values[gynecologyCcaVisitRaw!];

  CcaDoctorVisit? get dentistCcaVisit =>
      dentistCcaVisitRaw == null ? null : CcaDoctorVisit.values[dentistCcaVisitRaw!];

  DateWithoutDay? get generalPracticionerVisitDate => generalPracticionerVisitDateRaw == null
      ? null
      : DateWithoutDay.fromJson(
          jsonDecode(generalPracticionerVisitDateRaw!) as Map<String, dynamic>);

  DateWithoutDay? get gynecologyVisitDate => gynecologyVisitDateRaw == null
      ? null
      : DateWithoutDay.fromJson(jsonDecode(gynecologyVisitDateRaw!) as Map<String, dynamic>);

  DateWithoutDay? get dentistVisitDate => dentistVisitDateRaw == null
      ? null
      : DateWithoutDay.fromJson(jsonDecode(dentistVisitDateRaw!) as Map<String, dynamic>);
}
