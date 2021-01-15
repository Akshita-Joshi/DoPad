import 'package:DoPad/shopping/shoppingmodel/shoppingdb.dart';
import 'package:DoPad/shopping/shoppingmodel/shoppingmodel.dart';

class DBWrapper {
  static final DBWrapper sharedInstance = DBWrapper._();

  DBWrapper._();

  Future<List<ShoppingTodo>> getShoppingTodos() async {
    List list = await DB.sharedInstance.retrieveShoppingTodos();
    return list;
  }

  Future<List<ShoppingTodo>> getShoppingDones() async {
    List list = await DB.sharedInstance
        .retrieveShoppingTodos(status: ShoppingTodoStatus.done);
    return list;
  }

  void addShoppingTodo(ShoppingTodo shoppingtodo) async {
    // ignore: await_only_futures
    await DB.sharedInstance.createShoppingTodo(shoppingtodo);
  }

  void markShoppingTodoAsShoppingDone(ShoppingTodo shoppingtodo) async {
    shoppingtodo.status = ShoppingTodoStatus.done.index;
    shoppingtodo.updated = DateTime.now();
    // ignore: await_only_futures
    await DB.sharedInstance.updateShoppingTodo(shoppingtodo);
  }

  void markShoppingDoneAsShoppingTodo(ShoppingTodo shoppingtodo) async {
    shoppingtodo.status = ShoppingTodoStatus.active.index;
    shoppingtodo.updated = DateTime.now();
    // ignore: await_only_futures
    await DB.sharedInstance.updateShoppingTodo(shoppingtodo);
  }

  void deleteShoppingTodo(ShoppingTodo shoppingtodo) async {
    // ignore: await_only_futures
    await DB.sharedInstance.deleteShoppingTodo(shoppingtodo);
  }

  void deleteAllShoppingDoneShoppingTodos() async {
    // ignore: await_only_futures
    await DB.sharedInstance.deleteAllShoppingTodos();
  }
}
