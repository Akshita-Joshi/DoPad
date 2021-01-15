import 'dart:io';

import 'package:DoPad/personalmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

const kPersonalTodosStatusActive = 0;
const kPersonalTodosStatusDone = 1;

const kDatabaseName = 'personaltodos.db';
const kDatabaseVersion = 1;
const kSQLCreateStatement = '''
CREATE TABLE "personaltodos" (
	 "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "title" TEXT NOT NULL,
	 "created" text NOT NULL,
	 "updated" TEXT NOT NULL,
	 "status" integer DEFAULT $kPersonalTodosStatusActive
);
''';

const kPersonalTableTodos = 'personaltodos';

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

  void createPersonalTodo(PersonalTodo personaltodo) async {
    final db = await database;
    await db.insert(kPersonalTableTodos, personaltodo.toMapAutoID());
  }

  void updatePersonalTodo(PersonalTodo personaltodo) async {
    final db = await database;
    await db.update(kPersonalTableTodos, personaltodo.toMap(),
        where: 'id=?', whereArgs: [personaltodo.id]);
  }

  void deletePersonalTodo(PersonalTodo personaltodo) async {
    final db = await database;
    await db.delete(kPersonalTableTodos,
        where: 'id=?', whereArgs: [personaltodo.id]);
  }

  void deleteAllPersonalTodos({int status = kPersonalTodosStatusDone}) async {
    final db = await database;
    await db
        .delete(kPersonalTableTodos, where: 'status=?', whereArgs: [status]);
  }

  Future<List<PersonalTodo>> retrievePersonalTodos(
      {PersonalTodoStatus status = PersonalTodoStatus.active}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(kPersonalTableTodos,
        where: 'status=?', whereArgs: [status.index], orderBy: 'updated ASC');

    // Convert List<Map<String, dynamic>> to List<Todo_object>
    return List.generate(maps.length, (i) {
      return PersonalTodo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        created: DateTime.parse(maps[i]['created']),
        updated: DateTime.parse(maps[i]['updated']),
        status: maps[i]['status'],
      );
    });
  }
}
