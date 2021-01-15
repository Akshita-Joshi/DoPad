import 'dart:io';

import 'package:DoPad/life/lifemodel/lifemodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

const kLifeTodosStatusActive = 0;
const kLifeTodosStatusDone = 1;

const kDatabaseName = 'lifetodos.db';
const kDatabaseVersion = 1;
const kSQLCreateStatement = '''
CREATE TABLE "lifetodos" (
	 "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "title" TEXT NOT NULL,
	 "created" text NOT NULL,
	 "updated" TEXT NOT NULL,
	 "status" integer DEFAULT $kLifeTodosStatusActive
);
''';

const kLifeTableTodos = 'lifetodos';

class DB {
  DB._();
  static final DB sharedInstance = DB._();

  Database _database;
  Future<Database> get database async {
    return _database ?? await initDB();
  }

  Future<Database> initDB() async {
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, kDatabaseName);

    return await openDatabase(path, version: kDatabaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute(kSQLCreateStatement);
    });
  }

  void createLifeTodo(LifeTodo lifetodo) async {
    final db = await database;
    await db.insert(kLifeTableTodos, lifetodo.toMapAutoID());
  }

  void updateLifeTodo(LifeTodo lifetodo) async {
    final db = await database;
    await db.update(kLifeTableTodos, lifetodo.toMap(),
        where: 'id=?', whereArgs: [lifetodo.id]);
  }

  // ignore: non_constant_identifier_names
  void deleteLifeTodo(LifeTodo Lifetodo) async {
    final db = await database;
    await db.delete(kLifeTableTodos, where: 'id=?', whereArgs: [Lifetodo.id]);
  }

  void deleteAllLifeTodos({int status = kLifeTodosStatusDone}) async {
    final db = await database;
    await db.delete(kLifeTableTodos, where: 'status=?', whereArgs: [status]);
  }

  Future<List<LifeTodo>> retrieveLifeTodos(
      {LifeTodoStatus status = LifeTodoStatus.active}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(kLifeTableTodos,
        where: 'status=?', whereArgs: [status.index], orderBy: 'updated ASC');

    // Convert List<Map<String, dynamic>> to List<Todo_object>
    return List.generate(maps.length, (i) {
      return LifeTodo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        created: DateTime.parse(maps[i]['created']),
        updated: DateTime.parse(maps[i]['updated']),
        status: maps[i]['status'],
      );
    });
  }
}
