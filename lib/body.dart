import 'package:DoPad/namescreen.dart';
import 'package:DoPad/rounded_button.dart';
import 'package:flutter/material.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    //this provides us total height and width of our screen
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            Image.asset(
              "asset/3567828.jpg",
              height: size.height * 0.5,
            ),
            SizedBox(height: size.height * 0.04),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: "Welcome to ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Alegreya',
                        fontSize: 30,
                      )),
                  TextSpan(
                    text: "DoPad",
                    style: TextStyle(
                        color: Color(0XFFE8505B),
                        fontFamily: 'Alegreya',
                        fontSize: 30),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              child: RoundedButton(
                text: "Continue...", //add fontfamily
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NameScreen();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
