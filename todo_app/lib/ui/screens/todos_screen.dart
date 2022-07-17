import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/settings.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ADD_TODO_ROUTE);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (ctx, state) {
          if (state is! TodosLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final todos = state.todos;

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (_, idx) {
              return todoTile(_, todos[idx]);
            },
          );
        },
      ),
    );
  }

  Widget todoTile(BuildContext context, Todo todo) {
    final icon = todo.isCompleted ? Icons.unpublished_outlined : Icons.done;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EDIT_TODO_ROUTE, arguments: todo);
      },
      child: Dismissible(
        key: Key("${todo.id}"),
        confirmDismiss: (direction) async {
          debugPrint("swipe direction -> ${direction.name}");
          BlocProvider.of<TodosCubit>(context).toggleCompletion(todo);
          return false;
        },
        background: Container(
          color: todo.isCompleted ? Colors.red : Colors.green,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white),
              Icon(icon, color: Colors.white),
            ],
          ),
        ),
        // secondaryBackground: Container(
        //   color: Colors.red,
        //   padding: const EdgeInsets.only(right: 20),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: const [
        //       Icon(Icons.unpublished_outlined, color: Colors.white),
        //     ],
        //   ),
        // ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(68, 158, 158, 158),
              ),
            ),
          ),
          child: ListTile(
            title: Text(todo.message),
            trailing: Icon(
              Icons.circle_outlined,
              color: (todo.isCompleted ? Colors.green : Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
