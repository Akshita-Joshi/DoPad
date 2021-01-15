import 'dart:io';

import 'package:DoPad/shopping/shoppingmodel/shoppingmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

const kShoppingTodosStatusActive = 0;
const kShoppingTodosStatusDone = 1;

const kDatabaseName = 'shoppingtodos.db';
const kDatabaseVersion = 1;
const kSQLCreateStatement = '''
CREATE TABLE "Shoppingtodos" (
	 "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "title" TEXT NOT NULL,
	 "created" text NOT NULL,
	 "updated" TEXT NOT NULL,
	 "status" integer DEFAULT $kShoppingTodosStatusActive
);
''';

const kShoppingTableTodos = 'shoppingtodos';

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

  void createShoppingTodo(ShoppingTodo shoppingtodo) async {
    final db = await database;
    await db.insert(kShoppingTableTodos, shoppingtodo.toMapAutoID());
  }

  void updateShoppingTodo(ShoppingTodo shoppingtodo) async {
    final db = await database;
    await db.update(kShoppingTableTodos, shoppingtodo.toMap(),
        where: 'id=?', whereArgs: [shoppingtodo.id]);
  }

  // ignore: non_constant_identifier_names
  void deleteShoppingTodo(ShoppingTodo Shoppingtodo) async {
    final db = await database;
    await db.delete(kShoppingTableTodos,
        where: 'id=?', whereArgs: [Shoppingtodo.id]);
  }

  void deleteAllShoppingTodos({int status = kShoppingTodosStatusDone}) async {
    final db = await database;
    await db
        .delete(kShoppingTableTodos, where: 'status=?', whereArgs: [status]);
  }

  Future<List<ShoppingTodo>> retrieveShoppingTodos(
      {ShoppingTodoStatus status = ShoppingTodoStatus.active}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(kShoppingTableTodos,
        where: 'status=?', whereArgs: [status.index], orderBy: 'updated ASC');

    // Convert List<Map<String, dynamic>> to List<Todo_object>
    return List.generate(maps.length, (i) {
      return ShoppingTodo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        created: DateTime.parse(maps[i]['created']),
        updated: DateTime.parse(maps[i]['updated']),
        status: maps[i]['status'],
      );
    });
  }
}
