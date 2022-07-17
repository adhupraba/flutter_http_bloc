import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final Repository repository;

  TodosCubit({required this.repository}) : super(TodosInitial());

  void fetchTodos() {
    Timer(const Duration(seconds: 2), () {
      repository.fetchTodos().then((todos) {
        emit(TodosLoaded(todos: todos));
      });
    });
  }

  void toggleCompletion(Todo todo) {
    repository.toggleCompletion(todo.id, !todo.isCompleted).then((isUpdated) {
      if (isUpdated) {
        todo.isCompleted = !todo.isCompleted;
        updateTodos();
      }
    });
  }

  void updateTodos() {
    final currState = state;

    if (currState is TodosLoaded) {
      emit(TodosLoaded(todos: currState.todos));
    }
  }

  void addTodo(Todo todo) {
    final currState = state;

    if (currState is TodosLoaded) {
      final todoList = currState.todos;
      todoList.add(todo);

      emit(TodosLoaded(todos: todoList));
    }
  }

  void deleteTodo(Todo todo) {
    final currState = state;

    if (currState is TodosLoaded) {
      final todoList = currState.todos;
      todoList.removeWhere((element) => element.id == todo.id);

      emit(TodosLoaded(todos: todoList));
    }
  }
}
