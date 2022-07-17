part of 'edit_todo_cubit.dart';

@immutable
abstract class EditTodoState {}

class EditTodoInitial extends EditTodoState {}

class EditingTodo extends EditTodoState {}

class DeletingTodo extends EditTodoState {}

class TodoEdited extends EditTodoState {}

class TodoDeleted extends EditTodoState {}

class EditTodoError extends EditTodoState {
  final String error;

  EditTodoError({required this.error});
}
