import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final e;

  Error(this.e);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('個人健康管理系統'),
      ),
      body: Container(
//      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 4),
        child: Center(
          child: Text('$e',style: TextStyle(color: Colors.red),),
        ),
      ),
    );
  }
}
