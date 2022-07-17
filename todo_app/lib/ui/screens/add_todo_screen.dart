import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  final _controller = TextEditingController();

  AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (cx, state) {
          if (state is TodoAdded) {
            Navigator.pop(cx);
          } else if (state is AddTodoError) {
            Toast.show(state.error, duration: 3, backgroundColor: Colors.red);
          }
        },
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                controller: _controller,
                decoration: const InputDecoration(hintText: "Enter todo message..."),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<AddTodoCubit, AddTodoState>(
                  builder: (ctx, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        BlocProvider.of<AddTodoCubit>(context).addTodo(_controller.text);
                      },
                      child: state is AddingTodo
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 3),
                            )
                          : const Text("Add Todo"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
