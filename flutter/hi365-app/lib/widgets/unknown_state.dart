import 'package:flutter/material.dart';

class UnknowState extends StatelessWidget {
  const UnknowState({
    Key key,
    @required this.state,
  }) : super(key: key);

  final String state;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('Unknown State $state'),
    );
  }
}
