import 'dart:convert';

import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/type_converters.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/memoized_stream.dart';
import 'package:loono_api/loono_api.dart';
import 'package:moor/moor.dart';

part 'user.g.dart';

class Users extends Table {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get id => text()();

  TextColumn get sex => text().map(const SexDbConverter()).nullable()();

  TextColumn get dateOfBirthRaw => text().nullable()();

  TextColumn get nickname => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get profileImageUrl => text().nullable()();

  TextColumn get defaultDeviceCalendarId => text().nullable()();

  DateTimeColumn get latestMapUpdateCheck => dateTime().nullable()();

  DateTimeColumn get latestMapUpdate => dateTime().nullable()();
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
    await updateCurrentUser(UsersCompanion(sex: Value<Sex>(sex)));
  }

  Future<void> updateLatestMapUpdateCheck(DateTime date) async {
    await updateCurrentUser(UsersCompanion(latestMapUpdateCheck: Value(date)));
  }

  Future<void> updateLatestMapServerUpdate(DateTime date) async {
    await updateCurrentUser(UsersCompanion(latestMapUpdate: Value(date)));
  }

  Future<void> updateDateOfBirth(DateWithoutDay dateWithoutDay) async {
    await updateCurrentUser(
      UsersCompanion(dateOfBirthRaw: Value(jsonEncode(dateWithoutDay.toJson()))),
    );
  }

  Future<void> updateNickname(String nickname) async {
    await updateCurrentUser(UsersCompanion(nickname: Value(nickname)));
  }

  Future<void> updateProfileImageUrl(String? url) async {
    await updateCurrentUser(UsersCompanion(profileImageUrl: Value(url)));
  }

  Future<void> updateEmail(String email) async {
    await updateCurrentUser(UsersCompanion(email: Value(email)));
  }
}
