import 'package:DoPad/life/lifemodel/lifedb.dart';
import 'package:DoPad/life/lifemodel/lifemodel.dart';

class DBWrapper {
  static final DBWrapper sharedInstance = DBWrapper._();

  DBWrapper._();

  Future<List<LifeTodo>> getLifeTodos() async {
    List list = await DB.sharedInstance.retrieveLifeTodos();
    return list;
  }

  Future<List<LifeTodo>> getLifeDones() async {
    List list =
        await DB.sharedInstance.retrieveLifeTodos(status: LifeTodoStatus.done);
    return list;
  }

  void addLifeTodo(LifeTodo lifetodo) async {
    // ignore: await_only_futures
    await DB.sharedInstance.createLifeTodo(lifetodo);
  }

  void markLifeTodoAsLifeDone(LifeTodo lifetodo) async {
    lifetodo.status = LifeTodoStatus.done.index;
    lifetodo.updated = DateTime.now();
    // ignore: await_only_futures
    await DB.sharedInstance.updateLifeTodo(lifetodo);
  }

  void markLifeDoneAsLifeTodo(LifeTodo lifetodo) async {
    lifetodo.status = LifeTodoStatus.active.index;
    lifetodo.updated = DateTime.now();
    // ignore: await_only_futures
    await DB.sharedInstance.updateLifeTodo(lifetodo);
  }

  void deleteLifeTodo(LifeTodo lifetodo) async {
    // ignore: await_only_futures
    await DB.sharedInstance.deleteLifeTodo(lifetodo);
  }

  void deleteAllLifeDoneLifeTodos() async {
    // ignore: await_only_futures
    await DB.sharedInstance.deleteAllLifeTodos();
  }
}
