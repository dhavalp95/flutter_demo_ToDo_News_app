import 'package:my_auth_app/models/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager1 {
  // Singletone object
  static var shared = DBManager1();

  final tableName = 'todos';

  // Database object
  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _createDB();
      // create database if null
    }
    return _database!;
  }

  // Create Database

  Future<Database> _createDB() async {
    // Database path
    final path = await getDatabasesPath();
    final fullPath = join(path, 'my_todos.db');
    print('Base path: $fullPath');

    // Open / create database
    return await openDatabase(
      fullPath,
      version: 1,
      onCreate: _createTable,
    );
  }

  // Create table
  Future<void> _createTable(Database db, int version) async {
    return await db.execute('''
    CREATE TABLE $tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    priority INTEGER,
    isDone INTEGER
    )
    ''');
  }

  // Insert (add)
  Future<int> insertToDo(Map<String, dynamic> map) async {
    final db = await database;
    return await db.insert(tableName, map);
  }

  // Fetch (get all data)
  Future<List<ToDoData>> fetchToDos() async {
    final db = await database;
    final dictData = await db.query(tableName);

    List<ToDoData> listToDos = [];
    for (final singleDic in dictData) {
      final obj = ToDoData(
        id: singleDic['id'] as int,
        title: singleDic['title'] as String,
        descriptoin: singleDic['description'] as String,
        priority: singleDic['priority'] as int,
        isDone: singleDic['isDone'] as int == 1,
      );
      listToDos.add(obj);
    }
    return listToDos;
  }

  // Delete
  Future<int> deleteToDo(int id) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update
  Future<int> updateToDo({
    required int id,
    required Map<String, dynamic> map,
  }) async {
    final db = await database;
    return await db.update(
      tableName,
      map,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
