import 'package:DoPad/background2.dart';
import 'package:DoPad/home.dart';
import 'package:DoPad/roundedbutton2.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    //this provides us total height and width of our screen
    return Scaffold(
      body: Background2(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.06),
              Image.asset(
                "asset/3327597.jpg",
                height: size.height * 0.4,
              ),
              SizedBox(height: size.height * 0.06),
              Text(
                "DoPad will allow you to write your tasks in different categories, let you take notes and customise your tasks according to priority.",
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Alegreya',
                    fontSize: 18),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                child: RoundedButton2(
                  text: "Get Started",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Home();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
