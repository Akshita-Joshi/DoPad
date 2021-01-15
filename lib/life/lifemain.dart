import 'package:DoPad/life/lifewidgets/lifetodo.dart';
import 'package:flutter/material.dart';
import 'package:DoPad/life/lifewidgets/lifeheader.dart';
import 'package:DoPad/life/lifewidgets/lifetask_input.dart';
import 'package:DoPad/life/lifewidgets/lifedone.dart';
import 'package:DoPad/life/lifemodel/lifemodel.dart' as Model;
import 'package:DoPad/life/lifemodel/lifedb_wrapper.dart';
import 'package:DoPad/life/lifeutils/lifeutils.dart';
import 'package:DoPad/life/lifewidgets/lifepopup.dart';

class HomeScreen3 extends StatefulWidget {
  @override
  _HomeScreen3State createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> {
  String welcomeMsg;
  List<Model.LifeTodo> lifetodos;
  List<Model.LifeTodo> lifedones;
  //String _selection;

  @override
  void initState() {
    super.initState();
    getLifeTodosAndLifeDones();
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
                                        getLifeTodosAndLifeDones:
                                            getLifeTodosAndLifeDones,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: TaskInput(
                                  onSubmitted: addTaskInLifeTodo,
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
                        return LifeTodo(
                          lifetodos: lifetodos,
                          onTap: markLifeTodoAsLifeDone,
                          onDeleteTask: deleteTask,
                        ); // Active todos
                      case 1:
                        return SizedBox(
                          height: 30,
                        );
                      default:
                        return LifeDone(
                          lifedones: lifedones,
                          onTap: markLifeDoneAsLifeTodo,
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

  void getLifeTodosAndLifeDones() async {
    final _lifetodos = await DBWrapper.sharedInstance.getLifeTodos();
    final _lifedones = await DBWrapper.sharedInstance.getLifeDones();

    setState(() {
      lifetodos = _lifetodos.cast<Model.LifeTodo>();
      lifedones = _lifedones.cast<Model.LifeTodo>();
    });
  }

  void addTaskInLifeTodo({@required TextEditingController controller}) {
    final inputText = controller.text.trim();

    if (inputText.length > 0) {
      // Add todos
      Model.LifeTodo lifetodo = Model.LifeTodo(
        title: inputText,
        created: DateTime.now(),
        updated: DateTime.now(),
        status: Model.LifeTodoStatus.active.index,
      );

      DBWrapper.sharedInstance.addLifeTodo(lifetodo);
      getLifeTodosAndLifeDones();
    } else {
      Utils.hideKeyboard(context);
    }

    controller.text = '';
  }

  void markLifeTodoAsLifeDone({@required int pos}) {
    DBWrapper.sharedInstance.markLifeTodoAsLifeDone(lifetodos[pos]);
    getLifeTodosAndLifeDones();
  }

  void markLifeDoneAsLifeTodo({@required int pos}) {
    DBWrapper.sharedInstance.markLifeDoneAsLifeTodo(lifedones[pos]);
    getLifeTodosAndLifeDones();
  }

  void deleteTask({@required Model.LifeTodo lifetodo}) {
    DBWrapper.sharedInstance.deleteLifeTodo(lifetodo);
    getLifeTodosAndLifeDones();
  }
}
