import 'package:flutter/material.dart';
import 'package:DoPad/personal/personalmodel/personaldb_wrapper.dart';
import 'package:DoPad/personal/personalutils/personalutils.dart';

// ignore: must_be_immutable
class Popup extends StatelessWidget {
  Function getPersonalTodosAndPersonalDones;

  Popup(
      {this.getPersonalTodosAndPersonalDones,
      void Function() getPersonalTodosAndDones});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        elevation: 4,
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          print('Selected value: $value');
          if (value == kMoreOptionsKeys.clearAll.index) {
            Utils.showCustomDialog(context,
                title: 'Are you sure?',
                msg: 'All done todos will be deleted permanently',
                onConfirm: () {
              DBWrapper.sharedInstance.deleteAllPersonalDonePersonalTodos();
              getPersonalTodosAndPersonalDones();
            });
          }
        },
        itemBuilder: (context) {
          List list = List<PopupMenuEntry<int>>();

          for (int i = 0; i < kMoreOptionsMap.length; ++i) {
            list.add(PopupMenuItem(value: i, child: Text(kMoreOptionsMap[i])));

            if (i == 0) {
              list.add(PopupMenuDivider(
                height: 5,
              ));
            }
          }

          return list;
        });
  }
}
