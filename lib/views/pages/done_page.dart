import 'package:flutter/material.dart';
import 'package:tadwina/data/Models/task_mdel.dart';
import 'package:tadwina/data/services/hive_services.dart';
import 'package:tadwina/data/services/sqflite_services.dart';
import 'package:tadwina/views/widgets/task_done.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  SqfliteServices sqfliteDatabase = SqfliteServices();
  Stream<List<TaskModel>> watchTasks() {
    return Stream.periodic(const Duration(seconds: 0), (_) async {
      return await sqfliteDatabase.getDoneTasks();
    }).asyncMap(
      (event) async => await event,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 52, 94),
        centerTitle: true,
        title: const Text(
          'Done Tasks',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<List<TaskModel>>(
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
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 250, 250, 250),
                    Color.fromARGB(255, 2, 55, 95),
                  ],
                  stops: [0.0, 0.7],
                ),
              ),
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return TaskDone(
                        description: data[index].description,
                        title: data[index].title);
                  }),
            );
          }),
    );
  }
}
