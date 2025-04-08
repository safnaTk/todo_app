import 'package:flutter/material.dart';
import 'package:todo_app/controller/todo_screen_controller.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    super.key,
    this.isEdit = false,
    this.taskTitle,
    this.des,
    this.taskId,
  });
  final bool isEdit; // for updating data
  final String? taskTitle;
  final String? des;
  final int? taskId;
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController =
      TextEditingController(); // data show-controller
  TextEditingController desController = TextEditingController();
  @override
  void initState() {
    // update the controllers with value from db
    if (widget.isEdit) {
      titleController.text = widget.taskTitle ?? "";
      desController.text = widget.des ?? "";
      setState(() {});
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: Text(
          widget.isEdit == true ? "Update task" : 'Add Task',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Title",
                label: Text("Title", style: TextStyle(color: Colors.grey)),
                hintStyle: TextStyle(color: Colors.black54),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red),
                ),
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: desController,
              maxLines: 3,
              minLines: 3,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Enter details ",
                label: Text("Details", style: TextStyle(color: Colors.grey)),
                hintStyle: TextStyle(color: Colors.black54),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red),
                ),
                border: UnderlineInputBorder(),
              ),
            ),

            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (widget.isEdit) {
                    await TodoScreenController.updateTask(
                      taskId: widget.taskId,
                      title: titleController.text,
                      des: desController.text,
                    );
                    // to edit data
                  } else {
                    // to add a task
                    await TodoScreenController.addTask(
                      title: titleController.text,
                      des: desController.text,
                    );
                  }

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  widget.isEdit ? "Update" : "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
