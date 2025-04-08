// sqflite -local database- phone memory
import 'package:flutter/material.dart';
import 'package:todo_app/controller/todo_screen_controller.dart';
import 'package:todo_app/view/add_task_screen/add_task_screen.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text(
          "My Tasks",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: TodoScreenController.taskList.length, // Dummy task count
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 2,
            child: ListTile(
              title: Text(
                TodoScreenController.taskList[index]["title"] ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[300],
                ),
              ),
              subtitle: Text(TodoScreenController.taskList[index]["des"] ?? ""),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  IconButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AddTaskScreen(
                                isEdit: true,
                                taskId:
                                    TodoScreenController
                                        .taskList[index]["id"] ??
                                    "",
                                taskTitle:
                                    TodoScreenController
                                        .taskList[index]["title"] ??
                                    "",
                                des:
                                    TodoScreenController
                                        .taskList[index]["des"] ??
                                    "",
                              ),
                        ),
                      );
                      setState(() {});
                    },
                    icon: Icon(Icons.edit, color: Colors.purple[300]),
                  ),
                  IconButton(
                    onPressed: () async {
                      int taskId =
                          TodoScreenController.taskList[index]["id"] ?? "";
                      await TodoScreenController.deleteTask(taskId);

                      setState(() {});
                    },
                    icon: Icon(Icons.delete, color: Colors.purple[300]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[300],
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );

          setState(() {});
        },
      ),
    );
  }
}
