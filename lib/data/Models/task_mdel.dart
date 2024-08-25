class TaskModel {
  int? id;
  String? title;
  String? description;
  int? isDone;
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
