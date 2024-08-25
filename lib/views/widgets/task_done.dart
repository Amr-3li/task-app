import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TaskDone extends StatelessWidget {
  const TaskDone({super.key, required this.description, required this.title});
  final String? title, description;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        border: Border.all(color: Colors.green, width: 3),
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
                title!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Spacer(flex: 1),
              Icon(Icons.done, color: Colors.green, size: 30),
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
            child: Text(description!,
                style: const TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 77, 77, 77))),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
