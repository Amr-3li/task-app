import 'package:flutter/material.dart';
import 'package:tadwina/data/Models/task_mdel.dart';
import 'package:tadwina/data/services/hive_services.dart';
import 'package:tadwina/data/services/sqflite_services.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    SqfliteServices sqfliteDatabase = SqfliteServices();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          border: Border.all(color: Colors.black, width: 3),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const Spacer(flex: 1),
                Text(
                  task.title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 29),
                ),
                const Spacer(flex: 1),
                IconButton(
                  icon: task.isStar == 1
                      ? const Icon(Icons.star, color: Colors.yellow)
                      : const Icon(Icons.star_border_outlined),
                  onPressed: () async {
                    await sqfliteDatabase.updateStar(
                      task.id!,
                      task.isStar == 1 ? 0 : 1,
                    );
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(task.description!,
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 77, 77, 77))),
            ),
            const SizedBox(height: 20),
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      sqfliteDatabase.done(task.id!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 1, 52, 94),
                      fixedSize: const Size(150, 40),
                    ),
                    child: const Text(
                      'Done',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      sqfliteDatabase.delete(task.id!);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Task deleted successfully!')));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 94, 1, 1),
                      fixedSize: const Size(100, 40),
                    ),
                    child: const Text(
                      'Delete',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}
