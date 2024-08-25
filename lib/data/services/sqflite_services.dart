import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tadwina/data/Models/task_mdel.dart';

class SqfliteServices {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initialize();
    return _database;
  }

  initialize() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'flutter.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, isStar INTEGER DEFAULT 0, isDone INTEGER DEFAULT 0)');
    });

  }

  Future<int> insert(String title, String description) async {
    Database? db = await database;

    return await db!.insert('tasks', {'title': title, 'description': description});
  }

  Future<List<TaskModel>> getTasks() async {
    Database? db = await database;
    List<Map<String, dynamic>> tasks = await db!.query('tasks' ,where: 'isDone = ?',whereArgs: [0]);

    List <TaskModel> taskList = tasks.map((task) => TaskModel.fromMap(task)).toList();
    return taskList;
  }

  Future<int> delete(int id) async {
    Database? db = await database;
    return await db!.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

 
  Future <int> updateStar(int id, int isStar) async {
    Database? db = await database;
    return await db!.update('tasks', {'isStar': isStar }, where: 'id = ?', whereArgs: [id]);
  }
  Future <List< TaskModel>> getStarTasks() async {
    Database? db = await database;
    List<Map<String, dynamic>> tasks = await db!.query('tasks',where: 'isStar = ?',whereArgs: [1]);
    return tasks.map((task) => TaskModel.fromMap(task)).toList();
  }
  Future done(int id) async {
    Database? db = await database;
    return await db!.update('tasks', {'isDone': 1}, where: 'id = ?', whereArgs: [id]);
  }
  Future <List< TaskModel>> getDoneTasks() async {
    Database? db = await database;
    List<Map<String, dynamic>> tasks = await db!.query('tasks',where: 'isDone = ?',whereArgs: [1]);
    return tasks.map((task) => TaskModel.fromMap(task)).toList();
  }

}
