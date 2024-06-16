import 'package:demo2/Domain/Entities/task.dart';
import 'package:demo2/Domain/Repositories/TaskRepository.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<void> call(Task task) {
    return repository.updateTask(task);
  }
}
