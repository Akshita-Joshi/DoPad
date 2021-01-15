import 'package:DoPad/life/lifemain.dart';
import 'package:DoPad/personal/personalmain.dart';
import 'package:DoPad/work/workmain.dart';
import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    //this provides us total height and width of our screen
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: (Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                "asset/Top corner.png",
                width: size.width * 0.33,
              ),
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "TO DO LIST",
                  style: TextStyle(
                    fontFamily: "Limelight",
                    fontSize: 30,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            Row(
              children: [
                ImageButton(
                  children: <Widget>[],
                  width: 180,
                  height: 180,
                  paddingTop: 20,
                  pressedImage: Image.asset(
                    "asset/Work.png",
                  ),
                  unpressedImage: Image.asset("asset/Work.png"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: size.width * 0.03,
                  height: size.height * 0.04,
                ),
                ImageButton(
                  children: <Widget>[],
                  width: 180,
                  height: 230,
                  paddingTop: 20,
                  pressedImage: Image.asset(
                    "asset/Personal.png",
                  ),
                  unpressedImage: Image.asset("asset/Personal.png"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen2();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              width: size.width * 0.03,
              height: size.height * 0.04,
            ),
            Row(
              children: [
                ImageButton(
                  children: <Widget>[],
                  width: 180,
                  height: 190,
                  paddingTop: 20,
                  pressedImage: Image.asset(
                    "asset/Life.png",
                  ),
                  unpressedImage: Image.asset("asset/Life.png"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen3();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: size.width * 0.03,
                  height: size.height * 0.04,
                ),
                ImageButton(
                  children: <Widget>[],
                  width: 180,
                  height: 180,
                  paddingTop: 20,
                  pressedImage: Image.asset(
                    "asset/Shopping.png",
                  ),
                  unpressedImage: Image.asset("asset/Shopping.png"),
                  onTap: () {
                    print('test');
                  },
                ),
              ],
            ),
            SizedBox(
              width: size.width * 0.03,
              height: size.height * 0.04,
            ),
          ],
        )),
      ),
    );
  }
}
