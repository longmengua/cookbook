import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget{
  final String title = '謝謝您，\n正在為您準備個人化。';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Image.asset('assets/setting/img_login_ready@3x.png',
                width: size.width, height: size.height * 0.5),
          ],
        ),
      ),
    );
  }
}