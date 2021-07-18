import 'package:encrypted_moor/encrypted_moor.dart';
import 'package:flutter/material.dart';
import 'package:loono/models/todo.dart';
import 'package:moor/moor.dart';

part 'database.g.dart';

@UseMoor(tables: [
  Todos,
], daos: [
  TodosDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(String path, String password)
      : super(EncryptedExecutor.inDatabaseFolder(path: path, password: password));
  @override
  int get schemaVersion => 1;
  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        debugPrint('**Moor** migration');
      });

  Future<void> deleteAllData() {
    return transaction(() async {
      for (final table in allTables) {
        debugPrint('**Moor** delele all tables');
        await delete(table).go();
      }
    });
  }
}
