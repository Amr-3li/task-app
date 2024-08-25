import 'package:flutter/material.dart';

class TextInputData extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final int minLine;

  const TextInputData({
    super.key,
    required this.controller,
    required this.text,
    this.minLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: minLine,
      maxLines: 4,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelText: text,
      ),
    );
  }
}
