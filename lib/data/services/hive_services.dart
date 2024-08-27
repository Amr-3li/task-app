import 'package:hive/hive.dart';
import 'package:tadwina/data/Models/task_mdel.dart';

class HiveServices {
  Future insert(String title, String description) async {
    final taskModel = TaskModel(
      description: description,
      title: title,
      isDone: 0,
      isStar: 0,
    );
    final nbox = Hive.box<TaskModel>('taskBox');
    await nbox.add(taskModel);
  }

  Future<List<TaskModel>> getTasks() async {
    var box = Hive.box<TaskModel>('taskBox');
    return box.values.toList();
  }

  Future delete(int id) async {
    final nbox = Hive.box<TaskModel>('taskBox');
    await nbox.deleteAt(id);
  }

  Future<List<TaskModel>> getStarTasks() async {
    final nbox = Hive.box<TaskModel>('taskBox');
    return nbox.values.where((element) => element.isStar == 1).toList();
  }

  Future<List<TaskModel>> getDoneTasks() async {
    final nbox = Hive.box<TaskModel>('taskBox');
    return nbox.values.where((element) => element.isDone == 1).toList();
  }

  Future done(int id) async {
    final nbox = Hive.box<TaskModel>('taskBox');
    final task = nbox.get(id);
    if (task != null) {
      task.isDone = 1;
      await nbox.put(id, task);
    }
  }

  Future updateStar(int id, int isStar) async {
    final nbox = Hive.box<TaskModel>('taskBox');
    final task = nbox.get(id);
    if (task != null) {
      task.isStar = isStar;
      await nbox.put(id, task);
    }
  }
}
