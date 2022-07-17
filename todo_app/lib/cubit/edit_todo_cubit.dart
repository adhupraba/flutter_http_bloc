import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  Repository repository;
  TodosCubit todosCubit;

  EditTodoCubit({required this.repository, required this.todosCubit}) : super(EditTodoInitial());

  void editTodo(Todo todo, String newMsg) {
    if (newMsg.isEmpty) {
      return emit(EditTodoError(error: "Todo message cannot be empty!"));
    }

    emit(EditingTodo());

    Timer(const Duration(seconds: 2), () {
      repository.editTodo(todo.id, newMsg).then((isEdited) {
        if (isEdited) {
          todo.message = newMsg;
          todosCubit.updateTodos();
          emit(TodoEdited());
        }
      });
    });
  }

  void deleteTodo(Todo todo) {
    emit(DeletingTodo());

    Timer(const Duration(seconds: 2), () {
      repository.deleteTodo(todo.id).then((isDeleted) {
        if (!isDeleted) {
          return emit(EditTodoError(error: "Failed to delete todo!"));
        }

        todosCubit.deleteTodo(todo);
        emit(TodoDeleted());
      });
    });
  }
}
