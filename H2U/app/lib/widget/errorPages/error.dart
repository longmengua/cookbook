import 'package:app/description/errorsDescription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Errors extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Spacer(
            flex: 3,
          ),
          Flexible(
            flex: 1,
            child: Text(
              ErrorsDescription.msg,
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
