import 'package:demo2/Domain/Repositories/TaskRepository.dart';

class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> call(int id) {
    return repository.deleteTask(id);
  }
}