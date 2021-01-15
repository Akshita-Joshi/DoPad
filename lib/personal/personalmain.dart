import 'package:DoPad/personaltodo.dart';
import 'package:flutter/material.dart';
import 'package:DoPad/personal/personalwidgets/personalheader.dart';
import 'package:DoPad/personal/personalwidgets/personaltask_input.dart';
import 'package:DoPad/personal/personalwidgets/personaldone.dart';
import 'package:DoPad/personalmodel.dart' as Model;
import 'package:DoPad/personal/personalmodel/personaldb_wrapper.dart';
import 'package:DoPad/personal/personalutils/personalutils.dart';
import 'package:DoPad/personal/personalwidgets/personalpopup.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String welcomeMsg;
  List<Model.PersonalTodo> personaltodos;
  List<Model.PersonalTodo> personaldones;
  //String _selection;

  @override
  void initState() {
    super.initState();
    getPersonalTodosAndPersonalDones();
    welcomeMsg = Utils.getWelcomeMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Utils.hideKeyboard(context);
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Header(
                                      msg: welcomeMsg,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 35),
                                      child: Popup(
                                        getPersonalTodosAndPersonalDones:
                                            getPersonalTodosAndPersonalDones,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: TaskInput(
                                  onSubmitted: addTaskInPersonalTodo,
                                ), // Add Todos
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                expandedHeight: 200,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    switch (index) {
                      case 0:
                        return PersonalTodo(
                          personaltodos: personaltodos,
                          onTap: markPersonalTodoAsPersonalDone,
                          onDeleteTask: deleteTask,
                        ); // Active todos
                      case 1:
                        return SizedBox(
                          height: 30,
                        );
                      default:
                        return PersonalDone(
                          personaldones: personaldones,
                          onTap: markPersonalDoneAsPersonalTodo,
                          onDeleteTask: deleteTask,
                        ); // Done todos
                    }
                  },
                  childCount: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getPersonalTodosAndPersonalDones() async {
    final _personaltodos = await DBWrapper.sharedInstance.getPersonalTodos();
    final _personaldones = await DBWrapper.sharedInstance.getPersonalDones();

    setState(() {
      personaltodos = _personaltodos.cast<Model.PersonalTodo>();
      personaldones = _personaldones.cast<Model.PersonalTodo>();
    });
  }

  void addTaskInPersonalTodo({@required TextEditingController controller}) {
    final inputText = controller.text.trim();

    if (inputText.length > 0) {
      // Add todos
      Model.PersonalTodo personaltodo = Model.PersonalTodo(
        title: inputText,
        created: DateTime.now(),
        updated: DateTime.now(),
        status: Model.PersonalTodoStatus.active.index,
      );

      DBWrapper.sharedInstance.addPersonalTodo(personaltodo);
      getPersonalTodosAndPersonalDones();
    } else {
      Utils.hideKeyboard(context);
    }

    controller.text = '';
  }

  void markPersonalTodoAsPersonalDone({@required int pos}) {
    DBWrapper.sharedInstance.markPersonalTodoAsPersonalDone(personaltodos[pos]);
    getPersonalTodosAndPersonalDones();
  }

  void markPersonalDoneAsPersonalTodo({@required int pos}) {
    DBWrapper.sharedInstance.markPersonalDoneAsPersonalTodo(personaldones[pos]);
    getPersonalTodosAndPersonalDones();
  }

  void deleteTask({@required Model.PersonalTodo personaltodo}) {
    DBWrapper.sharedInstance.deletePersonalTodo(personaltodo);
    getPersonalTodosAndPersonalDones();
  }
}
