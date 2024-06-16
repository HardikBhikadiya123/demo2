// lib/presentation/bloc/add_task/add_task_event.dart
import 'package:demo2/Domain/Entities/task.dart';
import 'package:equatable/equatable.dart';


abstract class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object> get props => [];
}


class LoadTasks extends AddTaskEvent {}
class AddNewTask extends AddTaskEvent {
  final Task task;

  const AddNewTask(this.task);

  @override
  List<Object> get props => [task];
}
class UpdateExistingTask extends AddTaskEvent {
  final Task task;

  const UpdateExistingTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteExistingTask extends AddTaskEvent {
  final int id;

  const DeleteExistingTask(this.id);

  @override
  List<int> get props => [id];
}

