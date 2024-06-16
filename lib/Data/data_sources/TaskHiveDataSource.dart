import 'package:demo2/Data/Model/taskModel.dart';
import 'package:hive/hive.dart';

class TaskHiveDataSource {
  final Box<Map<dynamic, dynamic>> taskBox;

  TaskHiveDataSource(this.taskBox);

  Future<List<TaskModel>> fetchTasks() async {
    return taskBox.values.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<void> addTask(TaskModel task) async {
    await taskBox.put(task.id, task.toJson());
  }

  Future<void> updateTask(TaskModel task) async {
    await taskBox.put(task.id, task.toJson());
  }

  Future<void> deleteTask(int id) async {
    await taskBox.delete(id);
  }
}
