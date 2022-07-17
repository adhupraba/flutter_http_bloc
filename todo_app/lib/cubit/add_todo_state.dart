part of 'add_todo_cubit.dart';

@immutable
abstract class AddTodoState {}

class AddingTodo extends AddTodoState {}

class AddTodoError extends AddTodoState {
  final String error;

  AddTodoError({required this.error});
}

class AddTodoInitial extends AddTodoState {}

class TodoAdded extends AddTodoState {}
