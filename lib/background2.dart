import 'package:flutter/material.dart';

class Background2 extends StatelessWidget {
  final Widget child;
  const Background2({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "asset/Top corner.png",
              width: size.width * 0.33,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
