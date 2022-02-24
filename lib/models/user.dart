import 'package:drift/drift.dart';
import 'package:loono/helpers/type_converters.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/memoized_stream.dart';

part 'user.g.dart';

class Users extends Table {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get id => text()();

  TextColumn get sex => text().map(const SexDbConverter()).nullable()();

  TextColumn get dateOfBirth => text().map(const DateOfBirthConverter()).nullable()();

  TextColumn get nickname => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get profileImageUrl => text().nullable()();

  TextColumn get defaultDeviceCalendarId => text().nullable()();

  DateTimeColumn get latestMapUpdateCheck => dateTime().nullable()();

  DateTimeColumn get latestMapUpdate => dateTime().nullable()();

  IntColumn get points => integer().withDefault(const Constant(0))();

  TextColumn get badges => text().map(const BadgeListConverter()).nullable()();
}

@DriftAccessor(tables: [Users])
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

  Future<void> updateLatestMapUpdateCheck(DateTime date) async {
    await updateCurrentUser(UsersCompanion(latestMapUpdateCheck: Value(date)));
  }

  Future<void> updateLatestMapServerUpdate(DateTime date) async {
    await updateCurrentUser(UsersCompanion(latestMapUpdate: Value(date)));
  }
}
