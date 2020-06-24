import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/todo.dart';

class DbService {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    var dbpath = await getDatabasesPath();
    String path = join(dbpath, 'saswatitodo.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS todo(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      task TEXT
    )
    ''');
  }

  Future<int> addTask({Todo todo}) async {
    int result = 0;
    try {
      var dbClient = await db;
      result = await dbClient.insert('todo', {'task': todo.text});
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<int> updateTask({Todo todo, int id}) async {
    int result = 0;
    try {
      var dbClient = await db;
      result = await dbClient.update('todo', {'task': todo.text},
          where: 'id=?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<int> deleteTask({int id}) async {
    int result = 0;
    try {
      var dbClient = await db;
      result = await dbClient.delete('todo', where: 'id=?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<List<Todo>> getTodoList() async {
    List<Todo> _todoList = [];
    try {
      var dbClient = await db;
      Iterable queryResult = await dbClient.query('todo');
      _todoList = queryResult.map((e) => Todo.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
    return _todoList;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
