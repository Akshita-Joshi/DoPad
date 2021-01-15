import 'package:flutter/material.dart';
import 'package:DoPad/life/lifewidgets/lifeshared.dart';
import 'package:DoPad/life/lifemodel/lifemodel.dart' as Model;
import 'package:DoPad/life/lifeutils/lifecolors.dart';

const int NoTask = -1;
const int animationMilliseconds = 500;

class LifeTodo extends StatefulWidget {
  final Function onTap;
  final Function onDeleteTask;
  final List<Model.LifeTodo> lifetodos;

  LifeTodo({@required this.lifetodos, this.onTap, this.onDeleteTask});

  @override
  _LifeTodoState createState() => _LifeTodoState();
}

class _LifeTodoState extends State<LifeTodo> {
  int taskPosition = NoTask;
  bool showCompletedTaskAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              if (widget.lifetodos == null || widget.lifetodos.length == 0)
                Container(
                  height: 10,
                ),
              if (widget.lifetodos != null)
                for (int i = 0; i < widget.lifetodos.length; ++i)
                  AnimatedOpacity(
                    curve: Curves.fastOutSlowIn,
                    opacity: taskPosition != i
                        ? 1.0
                        : showCompletedTaskAnimation
                            ? 0
                            : 1,
                    duration: Duration(seconds: 1),
                    child: getTaskItem(
                      widget.lifetodos[i].title,
                      index: i,
                      onTap: () {
                        setState(() {
                          taskPosition = i;
                          showCompletedTaskAnimation = true;
                        });
                        Future.delayed(
                          Duration(milliseconds: animationMilliseconds),
                        ).then((value) {
                          taskPosition = NoTask;
                          showCompletedTaskAnimation = false;
                          widget.onTap(pos: i);
                        });
                      },
                    ),
                  ),
            ],
          ),
        ),
        SharedWidget.getCardHeader(
            context: context, text: 'TO DO', customFontSize: 16),
      ],
    );
  }

  Widget getTaskItem(String text,
      {@required int index, @required Function onTap}) {
    // ignore: unused_local_variable
    final double height = 50.0;
    return Container(
        child: Column(
      children: <Widget>[
        Dismissible(
          key: Key(text + '$index'),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            widget.onDeleteTask(todo: widget.lifetodos[index]);
          },
          background: SharedWidget.getOnDismissDeleteBackground(),
          child: InkWell(
            onTap: onTap,
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 7,
                    decoration: BoxDecoration(
                      color:
                          LifeTodosColor.sharedInstance.leadingTaskColor(index),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, top: 15, right: 20, bottom: 15),
                      child: Text(
                        text,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.title.copyWith(
                              color: Color(0xff373640),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.5,
          child: Container(
            color: Colors.grey,
          ),
        ),
      ],
    ));
  }
}
