import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HorizontalDivider extends StatelessWidget {
  Color color;
  double height;
  double width;
  HorizontalDivider({this.height = 30, this.width = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
