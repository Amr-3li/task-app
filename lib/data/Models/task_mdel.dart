import 'package:hive/hive.dart';

part 'task_mdel.g.dart';  

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  int? isDone;
  @HiveField(4)
  int? isStar;

  TaskModel({this.id, this.title, this.description, this.isDone, this.isStar});

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        isStar: map['isStar'],
        isDone: map['isDone']);
  }
}
