
class Task {
  final int id;
  final String title;
  final String description;
  final String priority;
  final String status;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> tasks;
  final List<String> completeTask;

  Task({
    required this.id,
    required this.description,
    required this.title,
    required this.priority,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.tasks,
    required this.completeTask
  });
}
