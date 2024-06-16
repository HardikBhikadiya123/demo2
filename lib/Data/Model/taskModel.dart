

import 'package:demo2/Domain/Entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required int id,
    required String title,
    required String description,
    required String priority,
    required String status,
    required DateTime startTime,
    required DateTime endTime,
    required List<String> tasks,
    required List<String> completeTask,
  }) : super(
    id: id,
    title: title,
    description: description,
    priority: priority,
    status: status,
    startTime: startTime,
    endTime: endTime,
    tasks: tasks,
    completeTask:completeTask
  );

  factory TaskModel.fromJson(Map<dynamic, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      status: json['status'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      tasks: List<String>.from(json['tasks']),
      completeTask: List<String>.from(json['completeTask']),

    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'tasks': tasks,
      'completeTask': completeTask,
    };
  }
}
