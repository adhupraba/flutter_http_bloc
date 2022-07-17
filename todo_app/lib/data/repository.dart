import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/network_service.dart';

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});

  Future<Todo?> addTodo(String message) async {
    final res = await networkService.addTodo({"message": message, "isCompleted": false});

    if (res == null) return null;

    return Todo.fromJson(res);
  }

  Future<List<Todo>> fetchTodos() async {
    final raw = await networkService.fetchTodos();
    return raw.map((e) => Todo.fromJson(e)).toList();
  }

  Future<bool> toggleCompletion(int id, bool status) async {
    final res = await networkService.patchTodo(id, {"isCompleted": status});
    return res;
  }

  Future<bool> editTodo(int id, String message) async {
    final res = await networkService.patchTodo(id, {"message": message});
    return res;
  }

  Future<bool> deleteTodo(int id) async {
    final res = await networkService.deleteTodo(id);
    return res;
  }
}
