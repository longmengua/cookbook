import 'package:flutter/material.dart';

class CirclePoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      margin: EdgeInsets.only(right: 10, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.black,
      ),
    );
  }
}
