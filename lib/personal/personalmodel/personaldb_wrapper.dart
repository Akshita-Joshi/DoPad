import 'package:DoPad/personal/personalmodel/personaldb.dart';

import '../../personalmodel.dart';

class DBWrapper {
  static final DBWrapper sharedInstance = DBWrapper._();

  DBWrapper._();

  Future<List<PersonalTodo>> getPersonalTodos() async {
    List list = await DB.sharedInstance.retrievePersonalTodos();
    return list;
  }

  Future<List<PersonalTodo>> getPersonalDones() async {
    List list = await DB.sharedInstance
        .retrievePersonalTodos(status: PersonalTodoStatus.done);
    return list;
  }

  void addPersonalTodo(PersonalTodo personaltodo) async {
    await DB.sharedInstance.createPersonalTodo(personaltodo);
  }

  void markPersonalTodoAsPersonalDone(PersonalTodo personaltodo) async {
    personaltodo.status = PersonalTodoStatus.done.index;
    personaltodo.updated = DateTime.now();
    await DB.sharedInstance.updatePersonalTodo(personaltodo);
  }

  void markPersonalDoneAsPersonalTodo(PersonalTodo personaltodo) async {
    personaltodo.status = PersonalTodoStatus.active.index;
    personaltodo.updated = DateTime.now();
    await DB.sharedInstance.updatePersonalTodo(personaltodo);
  }

  void deletePersonalTodo(PersonalTodo personaltodo) async {
    await DB.sharedInstance.deletePersonalTodo(personaltodo);
  }

  void deleteAllPersonalDonePersonalTodos() async {
    await DB.sharedInstance.deleteAllPersonalTodos();
  }
}
