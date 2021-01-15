enum ShoppingTodoStatus { active, done }

class ShoppingTodo {
  int id;
  String title;
  DateTime created;
  DateTime updated;
  int status;

  ShoppingTodo({this.id, this.title, this.created, this.updated, this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'created': created.toString(),
      'updated': updated.toString(),
      'status': status,
    };
  }

  Map<String, dynamic> toMapAutoID() {
    return {
      'title': title,
      'created': created.toString(),
      'updated': updated.toString(),
      'status': ShoppingTodoStatus.active.index,
    };
  }
}
