import 'package:flutter/material.dart';

class CheckupNoDataScreen extends StatelessWidget {
  const CheckupNoDataScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(48, 46, 48, 0),
            child: Image(
              image: AssetImage('assets/images/checkup/img_nodata.png'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 41),
            child: Text(
              '無健檢報告明細',
              style: TextStyle(
                color: Color.fromRGBO(0x11, 0x11, 0x11, 0.54),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
