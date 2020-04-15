import 'package:flutter/material.dart';
import 'package:hi365/utils/app_configs.dart';

enum FieldType {
  TEXT,
  PASSWORD,
}

/// @Author`Zane Chen`[zane.chen@h2uclub.com]
///
///
/// A customized [TextFormField] for Hi365 style.[type] determines the field will
/// be text mode or password mode by [FieldType]. [labelText], [hintText],
/// [controller] and [controller] map to the fields of [TextFormField].
/// [validateFailureMessage] is the warring message that will be shown when validate is failure.
///
/// # Example
/// ## Text Mode
/// ```dart
/// TextFormFieldBuilder(
///   labelText: '電子郵件',
///   hintText: '請輸入您的電子郵件',
///   controller: _emailController,
///   keyboardType: TextInputType.emailAddress,
///   validateFailureMessage: !state.isEmailValid ? '請輸入電子郵件' : null,
/// );
/// ```
///
/// ## Password Mode
/// ```dart
///TextFormFieldBuilder(
///  type: FieldType.PASSWORD,
///  labelText: '密碼',
///  hintText: '請輸入您的密碼',
///  controller: _passwordController,
///  validateFailureMessage: !state.isPasswordValid ? '請輸入密碼' : null,
///);
/// ```
class TextFormFieldBuilder extends StatefulWidget {
  TextFormFieldBuilder({
    Key key,
    @required this.labelText,
    @required this.hintText,
    @required this.controller,
    @required this.validateFailureMessage,
    this.keyboardType,
    this.isReadOnly = false,
    this.focusNode,
    this.type = FieldType.TEXT,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  final FieldType type;
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String validateFailureMessage;
  final TextInputType keyboardType;
  final bool isReadOnly;
  final FocusNode focusNode;
  final String initialValue;
  final Function onChanged;

  @override
  _TextFormFieldBuilderState createState() => _TextFormFieldBuilderState();
}

class _TextFormFieldBuilderState extends State<TextFormFieldBuilder> {
  final Color _mainTextColor = const Color.fromRGBO(0x11, 0x11, 0x11, .54);
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        onChanged: widget.onChanged,
        cursorColor: AppConfig().primaryColor,
        initialValue: widget.initialValue,
        readOnly: widget.isReadOnly,
        focusNode: widget.focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.type == FieldType.PASSWORD ? _isObscure : false,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 13.0),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            height: 0.5,
            fontSize: 20.0,
            color: _mainTextColor,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            height: 0.5,
            fontSize: 16.0,
            color: _mainTextColor.withOpacity(.15),
          ),
          suffixIcon: widget.type == FieldType.PASSWORD
              ? _showPasswordToggleButton()
              : null,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppConfig().primaryColor),
          ),
        ),
        autovalidate: true,
        autocorrect: false,
        validator: (_) => widget.validateFailureMessage,
      ),
    );
  }

  IconButton _showPasswordToggleButton() {
    return IconButton(
      icon: Icon(
        Icons.remove_red_eye,
        color: _isObscure ? Colors.grey : AppConfig().primaryColor,
      ),
      onPressed: () {
        setState(() => _isObscure = !_isObscure);
      },
    );
  }
}
