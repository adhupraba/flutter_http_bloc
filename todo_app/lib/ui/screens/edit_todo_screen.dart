import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;
  final _controller = TextEditingController();

  EditTodoScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    _controller.text = todo.message;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo"),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocListener<EditTodoCubit, EditTodoState>(
        listener: (ctx, state) {
          if (state is TodoEdited || state is TodoDeleted) {
            Navigator.pop(ctx);
          } else if (state is EditTodoError) {
            Toast.show(state.error, duration: 3, backgroundColor: Colors.red);
          }
        },
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(hintText: "Edit todo message..."),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<EditTodoCubit, EditTodoState>(
                  builder: (cx, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        BlocProvider.of<EditTodoCubit>(cx).editTodo(todo, _controller.text);
                      },
                      child: state is EditingTodo
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              "Update Todo",
                              style: TextStyle(color: Colors.white),
                            ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
