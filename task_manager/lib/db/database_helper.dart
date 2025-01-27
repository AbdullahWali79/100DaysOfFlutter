import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';
import '../services/sample_tasks_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static const String _prefsKey = 'is_first_run';

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    await _checkFirstRun();
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        dueDate TEXT NOT NULL,
        isCompleted INTEGER NOT NULL,
        isRepeating INTEGER NOT NULL,
        repeatPattern TEXT,
        subtasks TEXT,
        progress REAL NOT NULL
      )
    ''');
  }

  Future<void> _checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool(_prefsKey) ?? true;

    if (isFirstRun) {
      await insertSampleTasks();
      await prefs.setBool(_prefsKey, false);
    }
  }

  Future<void> insertSampleTasks() async {
    final sampleTasks = SampleTasksService.getSampleTasks();
    for (var task in sampleTasks) {
      await insertTask(task);
    }
  }

  Future<void> resetToSampleTasks() async {
    final db = await instance.database;
    await db.delete('tasks');
    await insertSampleTasks();
  }

  Future<int> insertTask(Task task) async {
    final db = await instance.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getAllTasks() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  Future<List<Task>> getTodayTasks() async {
    final db = await instance.database;
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'dueDate BETWEEN ? AND ?',
      whereArgs: [todayStart.toIso8601String(), todayEnd.toIso8601String()],
    );
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  Future<List<Task>> getCompletedTasks() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'isCompleted = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  Future<List<Task>> getRepeatingTasks() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'isRepeating = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
