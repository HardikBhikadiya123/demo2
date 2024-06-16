import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo2/Domain/Entities/task.dart';
import 'package:demo2/Domain/UseCase/get_tasks.dart';
import 'package:equatable/equatable.dart';

part 'Task_screen_event.dart';

part 'Task_screen_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  TaskBloc({
    required this.getTasks,
  }) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await getTasks();
        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError(message: e.toString()));
      }
    });

  }
}
