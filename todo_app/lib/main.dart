import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/ui/router.dart';
import 'package:todo_app/ui/screens/todos_screen.dart';

void main() {
  runApp(MyApp(
    router: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider.value(
        value: router.todosCubit,
        child: const TodosScreen(),
      ),
      onGenerateRoute: router.generateRoute,
    );
  }
}
