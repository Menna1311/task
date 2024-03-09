import 'package:flutter/material.dart';

class TaskNameTextField extends StatelessWidget {
  final TextEditingController controller;

  const TaskNameTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: 'Name'),
      ),
    );
  }
}
