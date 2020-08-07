import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ErrorPage extends StatelessWidget {
  String title;

  ErrorPage({String title}) {
    this.title = title == null ? '伺服器發生異常！' : title;
  }

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
            Image.asset('assets/setting/img_login_provideinfo@3x.png',
                width: size.width, height: size.height * 0.5),
          ],
        ),
      ),
    );
  }
}
