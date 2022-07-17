class Todo {
  String message;
  bool isCompleted;
  int id;

  Todo.fromJson(Map json)
      : message = json["message"],
        isCompleted = json["isCompleted"] as bool,
        id = json["id"] as int;
}
