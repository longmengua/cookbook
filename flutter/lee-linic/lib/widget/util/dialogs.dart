import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static showAlert({
    @required BuildContext context,
    @required Widget content,
  }) async {
    return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        children: <Widget>[content],
      ),
    );
  }

  static Future showCustomDialog({
    @required BuildContext context,
    @required String title,
    @required String content,
    @required List<String> options,
  }) async {
    return await showDialog(
      barrierDismissible: false, // user must tap button!
      context: context,
      builder: (_) => Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    shadows: <Shadow>[
                      Shadow(
                          color: Colors.red.withOpacity(0.5),
                          offset: Offset(1, 2))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      content ?? '',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Spacer(),
                    _dialogCustomActionButton(
                      text: options[1],
                      function: () => Navigator.of(context).pop(),
                    ),
                    _dialogCustomActionButton(
                      text: options[0],
                      function: () => Navigator.of(context).pop(true),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _dialogCustomActionButton({String text, Function function}) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 30,
              shadows: <Shadow>[
                Shadow(color: Colors.red.withOpacity(0.5), offset: Offset(1, 2))
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        function();
      },
    );
  }

  static Future alertMSG({
    @required BuildContext context,
    @required String title,
    @required String content,
    @required String close,
  }) async {
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title ?? '',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              close ?? 'close',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
