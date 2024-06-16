import 'package:equatable/equatable.dart';

abstract class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskSuccess extends AddTaskState {}

class AddTaskError extends AddTaskState {
  final String message;

  const AddTaskError({required this.message});

  @override
  List<Object> get props => [message];
}
