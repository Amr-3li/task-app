// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tadwina/data/services/sqflite_services.dart';
import 'package:tadwina/views/widgets/text_input_data.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    SqfliteServices sqfliteDatabase = SqfliteServices();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Task information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 1, color: Colors.black),
          const SizedBox(height: 10),
          TextInputData(
            controller: titleController,
            text: 'Title',
          ),
          const SizedBox(height: 20),
          TextInputData(
            controller: descriptionController,
            text: 'Description',
            minLine: 4,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    int result = await sqfliteDatabase.insert(
                        titleController.text, descriptionController.text);
                    if (result > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Task added successfully'),
                        ),
                      );
                      Navigator.pop(context);
                    } else if (result == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Task not inserted'),
                        ),
                      );
                    }
                  } on Exception catch (e) {
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 52, 94),
                ),
                child: const Text('Add Task',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
