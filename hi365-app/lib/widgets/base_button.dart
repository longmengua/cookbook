import 'package:flutter/material.dart';
import 'package:hi365/utils/app_configs.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _title;

  const BaseButton({
    Key key,
    @required onPressed,
    @required title,
  })  : _onPressed = onPressed,
        _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: RaisedButton(
        disabledColor: Color.fromRGBO(0xff, 0xe1, 0xcc, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: _onPressed,
        color: AppConfig().primaryColor,
        child: Text(
          _title ?? '',
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
    );
  }
}
