import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/settings.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/network_service.dart';
import 'package:todo_app/data/repository.dart';
import 'package:todo_app/ui/screens/add_todo_screen.dart';
import 'package:todo_app/ui/screens/edit_todo_screen.dart';
import 'package:todo_app/ui/screens/todos_screen.dart';

class AppRouter {
  static Repository repository = Repository(networkService: NetworkService());
  TodosCubit todosCubit = TodosCubit(repository: repository);

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case TODOS_ROUTE:
        return MaterialPageRoute(
          builder: (c) => BlocProvider.value(
            value: todosCubit,
            child: const TodosScreen(),
          ),
        );
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
          builder: (c) => BlocProvider(
            create: (ctx) => AddTodoCubit(repository: repository, todosCubit: todosCubit),
            child: AddTodoScreen(),
          ),
        );
      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;

        return MaterialPageRoute(
          builder: (c) => BlocProvider(
            create: (ctx) => EditTodoCubit(repository: repository, todosCubit: todosCubit),
            child: EditTodoScreen(todo: todo),
          ),
        );
      default:
        return null;
    }
  }
}
