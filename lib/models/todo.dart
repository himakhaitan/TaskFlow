class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    this.id,
    this.todoText,
    this.isDone = false,  
  });

  static List<Todo> todoList() {
    return [
      Todo(id: "1", todoText: "Buy milk"),
      Todo(id: "2", todoText: "Buy eggs"),
      Todo(id: "3", todoText: "Buy bread"),
      Todo(
        id: "4",
        todoText: "Buy a new phone",
        isDone: true,
      ),
      Todo(
        id: "5",
        todoText: "Buy a new laptop",
        isDone: true,
      ),
    ];
  }
}
