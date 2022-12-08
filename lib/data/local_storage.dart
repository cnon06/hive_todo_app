import 'package:hive/hive.dart';

import '../models/task_model.dart';

List<Task> tasks = [];


abstract class LocalStorage {
  Future<void> addTask({required Task task});
  Future<void> getTask({required String id});
  Future<void> deleteTask({required Task task});
  Future<void> updateTask({required Task task});
  Future<List<Task>> getAllTask();
}

class HiveLocalStorage extends LocalStorage {
  late Box<Task> _taskBox;

  HiveLocalStorage() {
    _taskBox = Hive.box<Task>("taskf");
  }

  @override
  Future<void> addTask({required Task task}) async {
    _taskBox.put(task.id, task);
    
  }

  @override
  Future<void> deleteTask({required Task task}) async {
    task.delete();
    
  }

  @override
  Future<List<Task>> getAllTask() async {
    List<Task> taskList = _taskBox.values.toList();
    if (taskList.isNotEmpty) {
      taskList.sort((Task a, Task b) => b.createdAt.compareTo(a.createdAt));
    }
    return taskList;
    
  }

  @override
  Future<void> getTask({required String id}) {
    
    throw UnimplementedError();
  }

  @override
  
  Future<void> updateTask({required Task task}) async {
    task.save();
    
  }
}
