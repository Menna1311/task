import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp/components/backbutton.dart';
import 'package:temp/components/dayselect.dart';
import 'package:temp/screens/task_screens/details.dart';
import 'package:temp/screens/task_screens/adddtask.dart';

import '../../components/yearmonth.dart';
import '../../models/task.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  Task? selectedTask;
  Color pickedColor = Color(0xFF0386D0);
   late DateTime selectedDate;
  void updateTask(Task oldTask, Task newTask) {
    setState(() {
      final index = tasks.indexOf(oldTask);
      tasks[index] = newTask;
    });
  }
 @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now(); // Initialize selectedDate
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.bottomCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffFFFFFF),
            Color(0xff3B5998),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2, // Adjust the elevation as needed
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(39.0),
                bottomRight: Radius.circular(39.0),
              ),
              color: Color.fromRGBO(255, 255, 255, 0.708),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(39.0),
                  bottomRight: Radius.circular(39.0),
                ),
                child: Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Daily Tasks',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      backbutton(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          CurrentMonthYearWidget(),
                          SizedBox(
                            width: 40,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddTaskScreen(onTaskAdded: addTask)),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Set circular border radius
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 30),
                                // Increase vertical padding
                                elevation: 4,
                                backgroundColor:
                                    pickedColor, // Add some elevation
                              ),
                              child: Text('+Add Task'))
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DaySelector(),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Tasks',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(12), // adjust as needed
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white
                                .withOpacity(0.2), // adjust opacity as needed
                            Colors.white
                                .withOpacity(0.1), // adjust opacity as needed
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                       child: ListTile(
                      leading: Image.asset(
                        'assets/icons8-task-100.png',
                        width: 40,
                        height: 40,
                      ),
                      title: Text(tasks[index].name),
                      subtitle: Text(
                        '${selectedDate.day}. ${DateFormat('MMM').format(selectedDate)}. ${selectedDate.year}',
                      ),
                      trailing: Checkbox(
                        value: tasks[index].completed,
                        onChanged: (value) {
                          setState(() {
                            tasks[index].completed = value!;
                          });
                        },
                      ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailsScreen(
                                task: tasks[index],
                                onTaskUpdated: (editedTask) {
                                  updateTask(tasks[index], editedTask);
                                },
                              ),
                            ),
                          );
                        },
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }
}
