import 'package:flutter/material.dart';

class RoundedButton2 extends StatelessWidget {
  final String text;
  final Function press;
  final Color textColor;
  const RoundedButton2({
    Key key,
    this.text,
    this.press,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8, //length of button
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(
              vertical: 20, horizontal: 45), //dimensions of button
          color: Color(0XFFDF878E),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
