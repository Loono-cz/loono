import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';
import 'package:uuid/uuid.dart';

class TodoRepository {
  final _db = registry.get<DatabaseService>();

  Future<void> modifyTodoProgress(Todo todo, {required bool value}) async {
    await _db.todos.upsert(todo.copyWith(done: value));
  }

  Future<void> addNewTodo(String body) async {
    await _db.todos.upsert(Todo(body: body, id: const Uuid().v4(), done: false));
  }
}
