
import 'package:demo2/Domain/Entities/task.dart';
import 'package:demo2/Domain/Repositories/TaskRepository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() {
    return repository.getTasks();
  }
}


