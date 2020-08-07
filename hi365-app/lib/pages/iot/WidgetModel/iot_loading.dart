part of '../index.dart';

///todo: this widget is for customizing the loading animation.
Widget loading([Size size]) {
  return SizedBox(
      height: size.height * 0.8,
      child: Center(child: CircularProgressIndicator()));
}