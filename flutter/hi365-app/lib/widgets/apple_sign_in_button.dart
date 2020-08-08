import 'package:flutter/material.dart';

class AppleSignInButton extends StatelessWidget {
  final VoidCallback _onPressed;

  const AppleSignInButton({
    Key key,
    @required onPressed,
  })  : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: RaisedButton.icon(
        // disabledColor: Color.fromRGBO(0xff, 0xe1, 0xcc, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.black),
        ),
        onPressed: _onPressed,
        color: Colors.white,
        label: Padding(
          padding: EdgeInsets.only(top: 3.0),
          child: Text(
            '使用 Apple 登入',
            style: TextStyle(fontSize: 15.0, color: Colors.black),
          ),
        ),
        icon: ImageIcon(
          AssetImage('assets/icons/cloud_download/apple-logo.png'),
          size: 20.0,
        ),
      ),
    );
  }
}
