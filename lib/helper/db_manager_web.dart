import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_auth_app/models/todo_model.dart';

/*
Add this two packages
- hive
- hive_flutter
*/

class DBManagerWeb {
  // Singleton object
  static final shared = DBManagerWeb();

  final String boxName = 'todos';

  Box<Map>? _box;

  // Lazy init Hive + open box (works on web + mobile)
  Future<Box<Map>> get _todosBox async {
    if (_box != null) return _box!;

    // Initialize Hive (safe to call multiple times)
    await Hive.initFlutter();

    _box = await Hive.openBox<Map>(boxName);
    return _box!;
  }

  // Insert (add)
  Future<int> insertToDo(Map<String, dynamic> map) async {
    final box = await _todosBox;

    // Generate auto-increment id (similar to AUTOINCREMENT in SQLite)
    int nextId = 1;
    if (box.isNotEmpty) {
      final keys = box.keys.cast<int>().toList();
      final maxId = keys.reduce(max);
      nextId = maxId + 1;
    }

    // Store id inside map for fetchToDos mapping
    map['id'] = nextId;

    await box.put(nextId, Map<String, dynamic>.from(map));
    return nextId;
  }

  // Fetch (get all data)
  Future<List<ToDoData>> fetchToDos() async {
    final box = await _todosBox;

    List<ToDoData> listToDos = [];

    for (final key in box.keys) {
      final singleDic = box.get(key);

      if (singleDic == null) continue;

      final obj = ToDoData(
        id: singleDic['id'] as int,
        title: singleDic['title'] as String,
        descriptoin: singleDic['description'] as String,
        priority: singleDic['priority'] as int,
        isDone: (singleDic['isDone'] as int) == 1,
      );

      listToDos.add(obj);
    }
    return listToDos;
  }

  // Delete
  Future<int> deleteToDo(int id) async {
    final box = await _todosBox;

    if (!box.containsKey(id)) {
      return 0; // no row deleted
    }

    await box.delete(id);
    return 1; // mimic "1 row affected"
  }

  // Update
  Future<int> updateToDo({
    required int id,
    required Map<String, dynamic> map,
  }) async {
    final box = await _todosBox;

    if (!box.containsKey(id)) {
      return 0; // no row updated
    }

    // Ensure id stays same
    map['id'] = id;

    await box.put(id, Map<String, dynamic>.from(map));
    return 1; // mimic "1 row affected"
  }
}
