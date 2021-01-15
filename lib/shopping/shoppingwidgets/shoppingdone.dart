import 'package:DoPad/shopping/shoppingutils/shoppingcolors.dart';
import 'package:flutter/material.dart';
import 'package:DoPad/shopping/shoppingwidgets/shoppingshared.dart';
import 'package:DoPad/shopping/shoppingmodel/shoppingmodel.dart' as Model;
import 'package:DoPad/shopping/shoppingutils/shoppingcolors.dart';

class ShoppingDone extends StatefulWidget {
  final Function onTap;
  final Function onDeleteTask;
  final List<Model.ShoppingTodo> shoppingdones;

  ShoppingDone({@required this.shoppingdones, this.onTap, this.onDeleteTask});

  @override
  _ShoppingDoneState createState() => _ShoppingDoneState();
}

class _ShoppingDoneState extends State<ShoppingDone> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: Color(0xffbcbab8),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              if (widget.shoppingdones == null ||
                  widget.shoppingdones.length == 0)
                Container(
                  height: 10,
                ),
              if (widget.shoppingdones != null)
                for (int i = widget.shoppingdones.length - 1; i >= 0; --i)
                  getTaskItem(
                    widget.shoppingdones[i].title,
                    index: i,
                    onTap: () {
                      widget.onTap(pos: i);
                    },
                  ),
            ],
          ),
        ),
        SharedWidget.getCardHeader(
            context: context,
            text: 'DONE',
            backgroundColorCode: ShoppingTodosColor.kSecondaryColorCode,
            customFontSize: 16),
      ],
    );
  }

  Widget getTaskItem(String text,
      {@required int index, @required Function onTap}) {
    final double height = 50.0;
    return Container(
        child: Column(
      children: <Widget>[
        Dismissible(
          key: Key(text + '$index'),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            widget.onDeleteTask(todo: widget.shoppingdones[index]);
          },
          background: SharedWidget.getOnDismissDeleteBackground(),
          child: InkWell(
            onTap: onTap,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    height: height,
                    child: Icon(
                      Icons.check,
                      color: Colors.grey[300],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 20, bottom: 10),
                      child: Text(
                        text,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.title.copyWith(
                              color: Colors.grey[300],
                              decoration: TextDecoration.lineThrough,
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
            color: Colors.white54,
          ),
        ),
      ],
    ));
  }
}
