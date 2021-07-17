import 'package:loono/services/db/database.dart';
import 'package:moor/moor.dart';

part 'todo.g.dart';

class Todos extends Table {
  TextColumn get id => text()();
  TextColumn get body => text()();
  BoolColumn get done => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseDao(tables: [Todos])
class TodosDao extends DatabaseAccessor<AppDatabase> with _$TodosDaoMixin {
  TodosDao(AppDatabase db) : super(db);

  Stream<List<Todo>> watchAll() {
    return select(todos).watch();
  }

  Future<List<Todo>> getAll() {
    return select(todos).get();
  }

  Future<void> upsert(Todo todo) async {
    await into(todos).insertOnConflictUpdate(todo);
  }
}
