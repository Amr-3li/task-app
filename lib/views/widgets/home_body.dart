import 'package:flutter/material.dart';
import 'package:tadwina/data/Models/task_mdel.dart';
import 'package:tadwina/data/services/hive_services.dart';
import 'package:tadwina/data/services/sqflite_services.dart';
import 'package:tadwina/views/widgets/task.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  SqfliteServices sqfliteDatabase = SqfliteServices();

  Stream<List<TaskModel>> watchTasks() {
    // Assuming you already have a method to fetch tasks, you should convert it to a Stream
    return Stream.periodic(const Duration(seconds: 0), (_) async {
      return await sqfliteDatabase.getTasks();
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: StreamBuilder<List<TaskModel>>(
        stream: watchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Tasks Available'));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return TaskWidget(
                task: data[index],
              );
            },
          );
        },
      ),
    );
  }
}
