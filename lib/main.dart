import 'package:flutter/material.dart';
import 'dart:async';

import 'body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DoPad',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), openBody);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'asset/icons8-checklist-100.png',
                height: 350,
                width: 350,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
              ),
              SizedBox(height: 70),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "DoPad",
                  style: TextStyle(
                    fontFamily: "Alegreya",
                    fontStyle: FontStyle.italic,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void openBody() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Body()));
  }
}
