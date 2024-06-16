import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manage_task_event.dart';
part 'manage_task_state.dart';

class ManageTaskBloc extends Bloc<ManageTaskEvent, ManageTaskState> {
  ManageTaskBloc() : super(ManageTaskInitial()) {
    on<ManageTaskEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
