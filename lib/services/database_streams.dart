import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/memoized_stream.dart';
import 'package:loono/utils/registry.dart';

class DatabaseStreams {
  final _db = registry.get<DatabaseService>();

  late final MemoizedStream<List<Todo>> todosStream;
  List<Todo> get documents => todosStream.lastItem;
  DatabaseStreams() {
    todosStream = MemoizedStream(_db.todos.watchAll());
  }
  Future<void> init() async {
    todosStream.lastItem = await _db.todos.getAll();
  }
}
