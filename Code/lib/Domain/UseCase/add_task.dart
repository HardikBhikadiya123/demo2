import 'package:demo2/Domain/Entities/task.dart';
import 'package:demo2/Domain/Repositories/TaskRepository.dart';

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> call(Task task) {
    return repository.addTask(task);
  }
}