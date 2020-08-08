import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoHealthBankFileError extends StatelessWidget {
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
              '....無健康存摺資料，請先登入健康存摺....',
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
