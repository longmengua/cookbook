import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Spacer(
          flex: 3,
        ),
        Flexible(
          flex: 1,
          child: Text(
            '....李氏健康達人....',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.blueAccent,
            ),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.asset(
                'assets/images/clinic.png',
                alignment: Alignment.centerLeft,
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
