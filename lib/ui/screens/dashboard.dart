import 'package:flutter/material.dart';
import 'package:loono/repositories/todo_repository.dart';
import 'package:loono/services/database_streams.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/memoized_stream.dart';
import 'package:loono/utils/registry.dart';

class DashboardScreen extends StatelessWidget {
  final _todoRepository = registry.get<TodoRepository>();
  final _databaseStreams = registry.get<DatabaseStreams>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo app'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctx) {
                final controller = TextEditingController();
                return AlertDialog(
                  title: const Text('Add new todo'),
                  content: TextField(controller: controller),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('close'),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (controller.text.isNotEmpty) {
                          await _todoRepository.addNewTodo(controller.text);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('add new'),
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: MemoizedStreamBuilder<List<Todo>>(
        memoizedStream: _databaseStreams.todosStream,
        builder: (context, snapshot) {
          if (snapshot.data?.isEmpty ?? true) {
            return const Center(child: Text('no data'));
          }
          final todos = snapshot.data!;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (ctx, i) {
              final todo = todos[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(todo.body),
                    Checkbox(
                      value: todo.done,
                      onChanged: (v) {
                        _todoRepository.modifyTodoProgress(todo, value: !todo.done);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
