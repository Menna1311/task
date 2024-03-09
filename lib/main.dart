import 'package:flutter/material.dart';
import 'package:temp/screens/task_screens/tasklist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
