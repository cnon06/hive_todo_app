import 'package:flutter/material.dart';
import 'package:hive_todo_app/main.dart';


import 'package:intl/intl.dart';

import '../data/local_storage.dart';
import '../models/task_model.dart';


class TaskItem extends StatefulWidget {
 final Task task;
 final int index;
  const TaskItem({Key? key, required this.task, required this.index}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  var textEditingController = TextEditingController();
  final _localStorage = locator<LocalStorage>();

  @override
  void initState() {
    textEditingController.text = widget.task.name;
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        shape: const StadiumBorder(),
        child: ListTile(
          leading: GestureDetector(
            onTap: () async {
              widget.task.isCompleted = !widget.task.isCompleted;
              await _localStorage.updateTask(task: widget.task);
              
                
                
              
              
              setState(() {});
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor:
                  !widget.task.isCompleted ? Colors.white : Colors.green,
              child: Icon(
                Icons.check,
                color: !widget.task.isCompleted ? Colors.black : Colors.white,
              ),
            ),
          ),
          title: widget.task.isCompleted
              ? Text(
                  widget.task.name,
                  style: const TextStyle(color: Colors.grey),
                )
              : TextField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  textInputAction: TextInputAction.done,
                  minLines: 1,
                  maxLines: null,
                  controller: textEditingController,
                  onSubmitted: (value) async {
                    widget.task.name = textEditingController.text;

                    await _localStorage.updateTask(task: widget.task);
                    setState(() {});
                  },
                ),
          trailing:
              Text(DateFormat('dd/MM/yy HH:mm').format(widget.task.createdAt)),
        ),
      ),
    );
  }
}
