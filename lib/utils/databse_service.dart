import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/model/todo_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, dueDate TEXT, priority INTEGER,time TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertTodo(TodoModel todoModel) async {
    final db = await database;
    await db.insert('todo', todoModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TodoModel>> getTodo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (i) {
      return TodoModel.fromMap(maps[i]);
    });
  }

  Future<void> updateTask(TodoModel todoModel) async {
    final db = await database;
    await db.update(
      'todo',
      todoModel.toMap(),
      where: "id = ?",
      whereArgs: [todoModel.id],
    );
  }


  Future<void> deleteTodoById(int id) async {
    final db = await database;
    await db.delete('todo', where: 'id = ?', whereArgs: [id]);
  }


}


