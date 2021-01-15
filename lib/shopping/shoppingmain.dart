import 'package:DoPad/shopping/shoppingwidgets/shoppingtodo.dart';
import 'package:flutter/material.dart';
import 'package:DoPad/shopping/shoppingwidgets/shoppingheader.dart';
import 'package:DoPad/shopping/shoppingwidgets/shoppingtask_input.dart';
import 'package:DoPad/shopping/shoppingwidgets/shoppingdone.dart';
import 'package:DoPad/shopping/shoppingmodel/shoppingmodel.dart' as Model;
import 'package:DoPad/shopping/shoppingmodel/shoppingdb_wrapper.dart';
import 'package:DoPad/shopping/shoppingutils/shoppingutils.dart';
import 'package:DoPad/shopping/shoppingwidgets/shoppingpopup.dart';

class HomeScreen4 extends StatefulWidget {
  @override
  _HomeScreen4State createState() => _HomeScreen4State();
}

class _HomeScreen4State extends State<HomeScreen4> {
  String welcomeMsg;
  List<Model.ShoppingTodo> shoppingtodos;
  List<Model.ShoppingTodo> shoppingdones;
  //String _selection;

  @override
  void initState() {
    super.initState();
    getShoppingTodosAndShoppingDones();
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
                                        getShoppingTodosAndShoppingDones:
                                            getShoppingTodosAndShoppingDones,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: TaskInput(
                                  onSubmitted: addTaskInShoppingTodo,
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
                        return ShoppingTodo(
                          shoppingtodos: shoppingtodos,
                          onTap: markShoppingTodoAsShoppingDone,
                          onDeleteTask: deleteTask,
                        ); // Active todos
                      case 1:
                        return SizedBox(
                          height: 30,
                        );
                      default:
                        return ShoppingDone(
                          shoppingdones: shoppingdones,
                          onTap: markShoppingDoneAsShoppingTodo,
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

  void getShoppingTodosAndShoppingDones() async {
    final _shoppingtodos = await DBWrapper.sharedInstance.getShoppingTodos();
    final _shoppingdones = await DBWrapper.sharedInstance.getShoppingDones();

    setState(() {
      shoppingtodos = _shoppingtodos.cast<Model.ShoppingTodo>();
      shoppingdones = _shoppingdones.cast<Model.ShoppingTodo>();
    });
  }

  void addTaskInShoppingTodo({@required TextEditingController controller}) {
    final inputText = controller.text.trim();

    if (inputText.length > 0) {
      // Add todos
      Model.ShoppingTodo shoppingtodo = Model.ShoppingTodo(
        title: inputText,
        created: DateTime.now(),
        updated: DateTime.now(),
        status: Model.ShoppingTodoStatus.active.index,
      );

      DBWrapper.sharedInstance.addShoppingTodo(shoppingtodo);
      getShoppingTodosAndShoppingDones();
    } else {
      Utils.hideKeyboard(context);
    }

    controller.text = '';
  }

  void markShoppingTodoAsShoppingDone({@required int pos}) {
    DBWrapper.sharedInstance.markShoppingTodoAsShoppingDone(shoppingtodos[pos]);
    getShoppingTodosAndShoppingDones();
  }

  void markShoppingDoneAsShoppingTodo({@required int pos}) {
    DBWrapper.sharedInstance.markShoppingDoneAsShoppingTodo(shoppingdones[pos]);
    getShoppingTodosAndShoppingDones();
  }

  void deleteTask({@required Model.ShoppingTodo shoppingtodo}) {
    DBWrapper.sharedInstance.deleteShoppingTodo(shoppingtodo);
    getShoppingTodosAndShoppingDones();
  }
}
