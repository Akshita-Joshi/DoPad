import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String msg;

  Header({this.msg});

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      child: Container(
        padding: EdgeInsets.only(left: 15.0, top: 30.0),
        child: Text(
          msg,
          style: Theme.of(context)
              .textTheme
              // ignore: deprecated_member_use
              .headline
              .copyWith(fontFamily: 'Lobster Two', fontSize: 30),
        ),
      ),
    );
  }
}
