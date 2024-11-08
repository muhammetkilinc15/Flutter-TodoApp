

class Todo {
  String? id;

  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false
  });

   static List<Todo> todoList() {
    return [
      Todo(id: "1", todoText: "study Operaings system",isDone: true),
      Todo(id: "2", todoText: "do sport"),
      Todo(id: "3", todoText: "Write not arkadasim api"),
      Todo(id: "4", todoText: "Love my darling"),
      Todo(id: "5", todoText: "watch movie with my babe"),
      Todo(id: "6", todoText: "Review the computer network notes"),
    ];
  }



}