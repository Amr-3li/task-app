import 'package:flutter/material.dart';
import 'package:tadwina/data/Models/task_mdel.dart';
import 'package:tadwina/data/services/hive_services.dart';
import 'package:tadwina/data/services/sqflite_services.dart';
import 'package:tadwina/views/widgets/task.dart';

class StarPage extends StatefulWidget {
  const StarPage({super.key});

  @override
  State<StarPage> createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  SqfliteServices sqfliteDatabase = SqfliteServices();
  Stream<List<TaskModel>> watchTasks() {
    return Stream.periodic(const Duration(seconds: 1), (_) async {
      return await sqfliteDatabase.getStarTasks();
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Star Tasks',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 1, 52, 94),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
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
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<List<TaskModel>>(
          stream: watchTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text(
                'No Tasks Available',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ));
            }

            final data = snapshot.data!;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return TaskWidget(task: data[index],);
              },
            );
          },
        ),
      ),
    );
  }
}
