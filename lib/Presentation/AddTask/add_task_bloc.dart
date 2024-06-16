import 'package:bloc/bloc.dart';
import 'package:demo2/Domain/UseCase/add_task.dart';
import 'package:demo2/Domain/UseCase/delete_task.dart';
import 'package:demo2/Domain/UseCase/update_tasks.dart';
import 'package:demo2/Presentation/AddTask/add_task_event.dart';
import 'package:demo2/Presentation/AddTask/add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  AddTaskBloc({ required this.addTask, required this.updateTask, required this.deleteTask}) : super(AddTaskInitial()) {
    on<AddNewTask>((event, emit) async {
      try {
        emit(AddTaskLoading());
        await addTask(event.task);
        emit(AddTaskSuccess());
      } catch (e) {
        emit(AddTaskError(message: e.toString()));
      }
    });

    on<UpdateExistingTask>((event, emit) async {
      try{
        emit(AddTaskLoading());
        await updateTask(event.task);
        emit(AddTaskSuccess());
      }catch(e){
        emit(AddTaskError(message: e.toString()));
      }
    });

    on<DeleteExistingTask>((event, emit) async {
      try{
        emit(AddTaskLoading());
        await deleteTask(event.id);
        emit(AddTaskSuccess());
      }catch(e){
        print("(e ---->$e");
        emit(AddTaskError(message: e.toString()));
      }
    });
  }
}
