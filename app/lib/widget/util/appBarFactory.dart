import 'package:flutter/material.dart';

class AppBarFactory {
  static Widget custom({
    BuildContext context,
    String leadingImagePath,
    String title,
    String trailingImagePath,
    Function trailingImageOnTap,
  }) {
    return AppBar(
      elevation: 1,
      leading: Container(
        margin: EdgeInsets.all(5),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(leadingImagePath),
        ),
      ),
      title: Container(
        margin: EdgeInsets.all(5),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            title ?? '-',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      actions: <Widget>[
        GestureDetector(
          child: Container(
            margin: EdgeInsets.all(5),
            child: Image.asset(trailingImagePath),
          ),
          onTap: () => trailingImageOnTap(),
        ),
      ],
    );
  }
}
