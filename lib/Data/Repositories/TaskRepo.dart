import 'package:demo2/Data/Model/taskModel.dart';
import 'package:demo2/Data/data_sources/TaskHiveDataSource.dart';
import 'package:demo2/Domain/Entities/task.dart';
import 'package:demo2/Domain/Repositories/TaskRepository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskHiveDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<List<Task>> getTasks() async {
    final taskModels = await localDataSource.fetchTasks();
    print(taskModels.runtimeType);
    return taskModels.map((TaskModel model) => model as Task).toList();
  }

  @override
  Future<void> addTask(Task task) async {
    await localDataSource.addTask(TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      priority: task.priority,
      status: task.status,
      startTime: task.startTime,
      endTime: task.endTime,
      tasks: task.tasks,
      completeTask: task.completeTask,
    ));
  }

  @override
  Future<void> updateTask(Task task) async {
    await localDataSource.updateTask(TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      priority: task.priority,
      status: task.status,
      startTime: task.startTime,
      endTime: task.endTime,
      tasks: task.tasks,
      completeTask:task.completeTask
    ));
  }

  @override
  Future<void> deleteTask(int id) async {
    await localDataSource.deleteTask(id);
  }
}
